# To learn more about how to use Nix to configure your environment
# see: https://developers.google.com/idx/guides/customize-idx-env
{ pkgs, ... }: {

  channel = "stable-24.05";

  # Use https://search.nixos.org/packages to find packages
  packages = [
    pkgs.python311
    pkgs.python311Packages.pip
  ];

  # Sets environment variables in the workspace
  env = {};

  idx = {
    extensions = [
      "albert.TabOut"
      "ms-python.python"
      "ms-python.vscode-pylance"
      "njpwerner.autodocstring"
      "ms-python.debugpy"
      "sourcegraph.cody-ai"
    ];

    # Workspace lifecycle hooks
    workspace = {
      # Runs when a workspace is first created
      onCreate = {
        install =
          "python -m venv .venv && source .venv/bin/activate && pip install --upgrade pip && pip install -r requirements.txt";
        # Open editors for the following files by default, if they exist:
      };
      # Runs when the workspace is (re)started
      onStart = {
        run-venv =''
        if [ ! -d .venv ]; then
          python -m venv .venv
          source .venv/bin/activate
          pip install --upgrade pip
          pip install -r requirements.txt
        fi
          '';
        default.openFiles = [];
      };
    };

    previews = {
      enable = true;
      previews = {
        web = {
          command = [
          ];
          manager = "web";
          env = {
          };
        };
      };
    };
  };
}
