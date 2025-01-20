{
  config,
  pkgs,
  lib,
  ...
}:

{

  home.username = lib.mkDefault "freek";
  home.homeDirectory = lib.mkDefault "/home/freek";
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  #  imports = [ nixvim.homeManagerModules.nixvim ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.zsh
    pkgs.tmux
    pkgs.jq # Json query / formatter
    pkgs.yq # YAML query / formatter

    # Kubernetes
    pkgs.kubectl # Kubernetes CLI
    pkgs.openshift # OpenShift CLI
    pkgs.kubectl-cnpg # Kubernetes CloudNativePG plugin
    pkgs.k9s # kubernetes dashboard
    pkgs.stern # Kubernetes log (combine pod logs)
    pkgs.kubernetes-helm

    # You got to try this
    pkgs.lazygit
    pkgs.tldr # Better man packages
    pkgs.eza # Better ls
    pkgs.duf # Better diskspace information: overview
    pkgs.dust # Better diskspace information: searching the full tree
    pkgs.bat # The bat is better then cat
    pkgs.delta # Diff, but better
    pkgs.entr # Watch a file, on change: do something
    pkgs.fzf # Fuzzy file finder
    pkgs.procs # ps, but then better
    pkgs.btop # even better then procs
    pkgs.sd # sed, but then easy
    pkgs.ddgr # duck-duck-go...cli style
    pkgs.ripgrep # Better grep
    pkgs.fd # Better find
    pkgs.chezmoi # dotfiles manager

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/freek/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # LC_ALL = "C.UTF-8";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.shellAliases = {
    update-home = "chezmoi update && home-manager switch && source ~/.zshrc";
    update-nix = "nix flake update --flake ~/\.config/home-manager && home-manager switch";
    # Apps
    lg = "lazygit";
    cm = "chezmoi";
    ls = "eza";

    # My shorthands
    urldecode = "python -c 'import sys; from urllib.parse import unquote; print(unquote(sys.stdin.read()))'";
    urlencode = "python -c 'import sys; from urllib.parse import quote; print(quote(sys.stdin.read()))'";
    git-clean = "CURRENT_BRANCH=$(git rev-parse --abrev-ref HEAD) && git checkout main && git pull --prune && git branch -d \"$CURRENT_BRANCH\" ";
  };

  programs.zsh = {
    enable = true;
    autosuggestion = {
      enable = true;
    };
    sessionVariables = {
      ZSH_DISABLE_COMPFIX = "true"; # This is necessary on the multi-user setup at work
    };
    # syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        # Basics
        "git"
        "history"
        "dotenv"

        # Backend
        "docker"
        "python"
        "virtualenv"
        "kubectl"
        # "rust"

        # Frontend
        # "npm"
        # "nvm"
        # "node"
        # "yarn"
      ];
    };
    initExtra = ''

      # To add something to the bottom of .zshrc, find this line in ~/.config/home-manager/home.nix
      # And add it below this line in that file.

      # Add box in front of prompt if on distrobox podman container
      draw_cond_box() {
          if [ -n "''${CONTAINER_ID+1}" ]; then
            echo '📦'
          fi
      }
      PS1="$(draw_cond_box)$PS1"

    '';
  };

  programs.tmux = {
    enable = true;

    sensibleOnTop = true;
    keyMode = "vi";
    mouse = true;
    escapeTime = 1;

    baseIndex = 1;
    prefix = "C-a";
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "screen-256color";
    historyLimit = 100000;
    clock24 = true;
    newSession = true;
    disableConfirmationPrompt = true;

    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.tokyo-night-tmux;
        extraConfig = ''
          set -g @tokyo-night-tmux_window_id_style fsquare
          # set -g @tokyo-night-tmux_pane_id_style hsquare
          # set -g @tokyo-night-tmux_zoom_id_style dsquare;

          set -g status-left "#[fg=colour83][#S]" # on the left, session name
          set -g status-right "#[fg=colour80][#H]" # on the right, hostname
          set -g status-justify centre
        '';
      }
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '60' # minutes
        '';
      }
      tmuxPlugins.yank
    ];
    extraConfig = ''
      # Use prefix-| to split the window horizontally 
      # and prefix-- to split the window vertically
      bind | split-window -h
      bind - split-window -v

      # Change window switching binds to match tab binds in lazyvim
      bind ] next-window
      bind [ previous-window

      # Use prefix with vi movements keys to move around panes
      # bind h select-pane -L
      # bind j select-pane -D
      # bind k select-pane -U
      # bind l select-pane -R

      # Smart pane switching with awareness of vim splits
      #bind -n C-h run "(tmux display-message -p '#{pane_current_command}' | grep -iqE '(^|\/)vim$' && tmux send-keys C-h) || tmux select-pane -L"
      #bind -n C-j run "(tmux display-message -p '#{pane_current_command}' | grep -iqE '(^|\/)vim$' && tmux send-keys C-j) || tmux select-pane -D"
      #bind -n C-k run "(tmux display-message -p '#{pane_current_command}' | grep -iqE '(^|\/)vim$' && tmux send-keys C-k) || tmux select-pane -U"
      #bind -n C-l run "(tmux display-message -p '#{pane_current_command}' | grep -iqE '(^|\/)vim$' && tmux send-keys C-l) || tmux select-pane -R"
      #bind -n C-\ run "(tmux display-message -p '#{pane_current_command}' | grep -iqE '(^|\/)vim$' && tmux send-keys 'C-\\') || tmux select-pane -l"

      # Use prefix with capital vi movement keys to resize panes
      # bind -r H resize-pane -L 5
      # bind -r J resize-pane -D 5
      # bind -r K resize-pane -U 5
      # bind -r L resize-pane -R 5

      # Cycle through windows
      #bind -r C-h select-window -t :-
      #bind -r C-l select-window -t :+

    '';
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      # Nix
      nil
      nixfmt-rfc-style

      # Lua
      lua-language-server
      stylua
      # Telescope
      ripgrep

      # Helm
      helm-ls

      # Ansible
      ansible-language-server
      ansible-lint

      # Python
      pyright
      ruff

      # Docker
      hadolint

      # SQL
      sqlfluff

      # YAML
      yaml-language-server

      # Formatter for YAML and JSON:
      nodePackages.prettier
    ];

    plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];

    extraLuaConfig =
      let
        plugins = with pkgs.vimPlugins; [
          # LazyVim
          LazyVim
          bufferline-nvim
          cmp-buffer
          cmp-nvim-lsp
          cmp-path
          cmp_luasnip
          conform-nvim
          dressing-nvim
          flash-nvim
          friendly-snippets
          gitsigns-nvim
          grug-far-nvim
          indent-blankline-nvim
          lualine-nvim
          markview-nvim
          neo-tree-nvim
          neoconf-nvim
          neodev-nvim
          noice-nvim
          nui-nvim
          nvim-cmp
          nvim-lint
          nvim-lspconfig
          nvim-notify
          nvim-spectre
          nvim-treesitter
          nvim-treesitter-context
          nvim-treesitter-textobjects
          nvim-ts-autotag
          nvim-ts-context-commentstring
          nvim-web-devicons
          persistence-nvim
          plenary-nvim
          refactoring-nvim
          snacks-nvim
          SchemaStore-nvim
          telescope-fzf-native-nvim
          telescope-nvim
          todo-comments-nvim
          tokyonight-nvim
          trouble-nvim
          ts-comments-nvim
          vim-illuminate
          vim-startuptime
          vim-dadbod
          vim-dadbod-ui
          vim-dadbod-completion
          which-key-nvim

          # Missing from Nixpkgs:
          # nvim-ansible (not the same as ansible-vim)
          # venv-selector

          vim-helm
          {
            name = "LuaSnip";
            path = luasnip;
          }
          {
            name = "catppuccin";
            path = catppuccin-nvim;
          }
          {
            name = "mini.ai";
            path = mini-nvim;
          }
          {
            name = "mini.bufremove";
            path = mini-nvim;
          }
          {
            name = "mini.comment";
            path = mini-nvim;
          }
          {
            name = "mini.icons";
            path = mini-nvim;
          }
          {
            name = "mini.indentscope";
            path = mini-nvim;
          }
          {
            name = "mini.pairs";
            path = mini-nvim;
          }
          {
            name = "mini.surround";
            path = mini-nvim;
          }
        ];
        mkEntryFromDrv =
          drv:
          if lib.isDerivation drv then
            {
              name = "${lib.getName drv}";
              path = drv;
            }
          else
            drv;
        lazyPath = pkgs.linkFarm "lazy-plugins" (builtins.map mkEntryFromDrv plugins);
      in
      ''
        require("lazy").setup({
          defaults = {
            lazy = true,
          },
          dev = {
            -- reuse files from pkgs.vimPlugins.*
            path = "${lazyPath}",
            patterns = { "." },
            -- fallback to download
            fallback = true,
          },
          spec = {
            { "LazyVim/LazyVim", import = "lazyvim.plugins" },
            -- The following configs are needed for fixing lazyvim on nix
            -- force enable telescope-fzf-native.nvim
            { "nvim-telescope/telescope-fzf-native.nvim", enabled = true },
            -- disable mason.nvim, use programs.neovim.extraPackages
            { "williamboman/mason-lspconfig.nvim", enabled = false },
            { "williamboman/mason.nvim", enabled = false },
            -- import/override with your plugins
            { import = "plugins" },
            -- treesitter handled by xdg.configFile."nvim/parser", put this line at the end of spec to clear ensure_installed
            {
                "nvim-treesitter/nvim-treesitter",
                opts = function(_, opts)
                  opts.ensure_installed = {}
                end,
            },
          },
        })
        vim.g.clipboard = {
          name = 'OSC 52',
          copy = {
            ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
            ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
          },
          paste = {
            ['+'] = function () end,
            ['*'] = function () end,
          },
        }
      '';
  };

  # https://github.com/nvim-treesitter/nvim-treesitter#i-get-query-error-invalid-node-type-at-position
  xdg.configFile."nvim/parser".source =
    let
      parsers = pkgs.symlinkJoin {
        name = "treesitter-parsers";
        paths =
          (pkgs.vimPlugins.nvim-treesitter.withPlugins (
            plugins: with plugins; [
              c
              lua
            ]
          )).dependencies;
      };
    in
    "${parsers}/parser";

  # Normal LazyVim config here, see https://github.com/LazyVim/starter/tree/main/lua
  #xdg.configFile."nvim/lua".source = ./lua;

}
