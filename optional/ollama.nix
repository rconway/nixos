{ lib, pkgs, ... }:

{
  services.ollama = {
    enable = true;
    package = pkgs.ollama-vulkan;
    loadModels = [ "qwen2.5-coder:7b" ];
    environmentVariables = {
      OLLAMA_IGPU_ENABLE = "1";
      OLLAMA_CONTEXT_LENGTH = "65536";
    };
  };

  environment.systemPackages = with pkgs; [
    ollama-vulkan
    # opencode  # commented out due to build error
  ];

  home-manager.users.rconway.home.file.".config/opencode/opencode.json".text =
    builtins.toJSON {
      "$schema" = "https://opencode.ai/config.json";
      model = "ollama/qwen2.5-coder:7b";
      provider.ollama = {
        npm = "@ai-sdk/openai-compatible";
        name = "Ollama (local)";
        options.baseURL = "http://127.0.0.1:11434/v1";
        models."qwen2.5-coder:7b" = {
          name = "Qwen2.5 Coder 7B";
          limit = {
            context = 65536;
            output = 8192;
          };
        };
      };
    };
}
