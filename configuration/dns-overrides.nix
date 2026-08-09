{ lib, ... }:

let
  # Domain -> IPv4 override map. Add entries here to scale this config.
  dnsOverrides = {
    "verify.eoepca.org" = "192.168.0.50";
  };

  domains = lib.sort builtins.lessThan (builtins.attrNames dnsOverrides);
in
{
  # Local wildcard DNS overrides served by dnsmasq on loopback.
  services.dnsmasq = {
    enable = true;
    # Keep loopback DNS scoped to resolved route-only domain rules below.
    resolveLocalQueries = false;
    settings = {
      "listen-address" = "127.0.0.1";
      "bind-interfaces" = true;
      address = map (domain: "/${domain}/${builtins.getAttr domain dnsOverrides}") domains;
      local = map (domain: "/${domain}/") domains;
    };
  };

  # Route only override domains to local dnsmasq via resolved delegates.
  services.resolved = {
    enable = true;
    dnsDelegates = builtins.listToAttrs (
      map (domain: {
        name = domain;
        value = {
          Delegate = {
            DNS = [ "127.0.0.1" ];
            Domains = [ "~${domain}" ];
          };
        };
      }) domains
    );
  };
}