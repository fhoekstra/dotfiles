{
  config,
  pkgs,
  lib,
  ...
}:
let
  certs_path = "/etc/pki/ca-trust/source/anchors/";
  secrets = (import ../local-secrets.nix);
in
# yamllsWrapped = pkgs.symlinkJoin {
#   name = "yamlls-wrapped";
#   paths = [ pkgs.nodePackages.yaml-language-server ];
#   buildInputs = [ pkgs.makeWrapper ];
#   postBuild = ''
#     wrapProgram "$out/bin/yaml-language-server" \
#       --set HTTP_PROXY "${secrets.proxy_address}" \
#       --set HTTPS_PROXY "${secrets.proxy_address}" \
#       --set NODE_EXTRA_CA_CERTS "${certs_path}"
#   '';
# };
{
  home.shellAliases.login1 = secrets.login1;
  home.shellAliases.login2 = secrets.login2;
  home.shellAliases.l1 = secrets.login1;
  home.shellAliases.l2 = secrets.login2;
  home.sessionVariables = {
    HTTP_PROXY = secrets.proxy_address;
    HTTPS_PROXY = secrets.proxy_address;
    NODE_EXTRA_CA_CERTS = certs_path;
  };
  programs.zsh.initContent = ''
    # Extra init stuff goes here
    PATH="$PATH:/mnt/c/scoop/shims/win32yank.exe"
  '';
}
