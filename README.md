<div align="center">
  <img src=".readme/logo.png" />
  <h1><strong>Mac Dev</strong></h1>
  <p>Personal `.zshrc`, and mac-dev related things.</p>
</div>

## Link `.zshrc`, and related files
First `cd` into the repository. Then:
```sh
ln .zshrc ~/.zshrc
ln .zsh_php ~/.zsh_php
ln .zsh_functions ~/.zsh_functions
```
or, inline:
```sh
ln .zshrc ~/.zshrc && ln .zsh_php ~/.zsh_php && ln .zsh_functions ~/.zsh_functions
```

The `.zsh_motd` it's not linked, since it likely you have a different one for each machine.
So simply copy it, and then modify it (it will not change in the repo, hopefully, so no need to link it)
```sh
cp .zsh_motd ~
```
