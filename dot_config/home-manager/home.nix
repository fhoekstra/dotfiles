{ config, pkgs, lib, ... }:

#let
#    nixvim = import (builtins.fetchGit {
#        url = "https://github.com/nix-community/nixvim";
#        # When using a different channel you can use `ref = "nixos-<version>"` to set it here
#    });
#in

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "adm-hoekstrf";
  home.homeDirectory = "/home/adm-hoekstrf";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

#  imports = [ nixvim.homeManagerModules.nixvim ];


  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.lazygit
    pkgs.zsh
    pkgs.jq               # Json query / formatter
    pkgs.yq               # YAML query / formatter

    # Kubernetes
    pkgs.kubectl          # Kubernetes CLI
    pkgs.openshift        # OpenShift CLI
    pkgs.kubectl-cnpg     # Kubernetes CloudNativePG plugin
    pkgs.k9s              # kubernetes dashboard
    pkgs.stern            # Kubernetes log (combine pod logs)
    pkgs.helm

    # You got to try this
    pkgs.tldr             # Better man packages
    pkgs.eza              # Better ls
    pkgs.duf              # Better diskspace information
    pkgs.dust             # Better diskspace information
    pkgs.bat              # The bat is better then cat
    pkgs.delta            # Diff, but better
    pkgs.entr             # Watch a file, on change: do something
    pkgs.fzf              # Fuzzy file finder
    pkgs.procs            # ps, but then better
    pkgs.btop             # even better then procs
    pkgs.sd               # sed, but then easy
    pkgs.ddgr             # duck-duck-go...cli style
    pkgs.ripgrep          # Better grep
    pkgs.fd               # Better find


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
  #  /etc/profiles/per-user/adm-hoekstrf/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
   # LC_ALL = "C.UTF-8";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.shellAliases = {
      update-nix = "sudo -i nix-channel --update && home-manager switch";
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
        # "rust"
        
        # Frontend
        # "npm"
        # "nvm"
        # "node"
        # "yarn"
      ];
    };
    initExtra = ''
    source ~/git/dba-ansible-automation/dev-bin/shell-functions.rc
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

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      # Nix
      nil

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
          dashboard-nvim
          dressing-nvim
          flash-nvim
          friendly-snippets
          gitsigns-nvim
          indent-blankline-nvim
          lualine-nvim
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
          telescope-fzf-native-nvim
          telescope-nvim
          todo-comments-nvim
          tokyonight-nvim
          trouble-nvim
          vim-illuminate
          vim-startuptime
          which-key-nvim

          # LSP Helm
          vim-helm

          { name = "LuaSnip"; path = luasnip; }
          { name = "catppuccin"; path = catppuccin-nvim; }
          { name = "mini.ai"; path = mini-nvim; }
          { name = "mini.bufremove"; path = mini-nvim; }
          { name = "mini.comment"; path = mini-nvim; }
          { name = "mini.indentscope"; path = mini-nvim; }
          { name = "mini.pairs"; path = mini-nvim; }
          { name = "mini.surround"; path = mini-nvim; }
        ];
        mkEntryFromDrv = drv:
          if lib.isDerivation drv then
            { name = "${lib.getName drv}"; path = drv; }
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
        paths = (pkgs.vimPlugins.nvim-treesitter.withPlugins (plugins: with plugins; [
          c
          lua
        ])).dependencies;
      };
    in
    "${parsers}/parser";

  # Normal LazyVim config here, see https://github.com/LazyVim/starter/tree/main/lua
  #xdg.configFile."nvim/lua".source = ./lua;

}
