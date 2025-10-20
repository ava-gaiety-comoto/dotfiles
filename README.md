# dotfiles
For Codespaces
https://docs.github.com/codespaces/setting-your-user-preferences/personalizing-github-codespaces-for-your-account#dotfiles

Adds `task`, `bat`, `fzf`, my personal dotfiles for NeoVim etc

Useful Comoto workflow git aliases:

- `git start NERD-xxx` creates a properly named branch
- `git ticket NERD-xxx` switches to a branch regardless of what user made it / the branch prefix

## Forking this Repository

1. Fork the repository
2. Change `.gitconfig` to match your own user
3. Change `setup.sh`'s final lines to pull in _your_ own dotfiles, or remove that step altogether unless you want my private subject-to-change configs
4. [Connect your fork to GitHub CodeSpaces](https://github.com/settings/codespaces)
