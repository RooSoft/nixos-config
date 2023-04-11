# NixOS config

A NixOS attempt to configure a test VM with one user


Based on https://github.com/Misterio77/nix-starter-configs


## To update the server itself

```bash
sudo nixos-rebuild switch --flake .#nixos-mini
```


## To update user `roo`

```bash
home-manager switch --flake .#roo@nixos-mini
```
