# Grzesiek11's dotfiles

This repository holds the public part of my personal dotfiles. Feel free to take code for your own dotfiles!

## dotman

`dotman` is a simple dotfile manager written in POSIX `sh`.

Here is how to install these dotfiles automatically using `dotman`:

```
curl https://gitlab.com/grzesiek11/dotfiles/-/raw/master/dotman 2>/dev/null | sh -s -- auto
```

If you want to know more about `dotman`, download it and check `help` action.

```
~/.dotfiles $ ./dotman help  
dotman v2.2.0
Manages dotfiles.
Created by Grzesiek11. Licensed under The Unlicense.

Usage: dotman action [OPTIONS]
Actions:
    help            Show this help message.
    install         Stows dotfiles from source to target.
        Options:
            -s [...]    Source. Defaults to scripts directory.
            -p [...]    Package. Defaults to 'dotfiles'.
            -t [...]    Target. Defaults to $HOME.
            -c [...]    Conflict directory. Defaults to directory 'conflicts' in scripts directory.
            -r          Restow instead of stowing.
            -y          Don't ask about conflicts.
            -f          Don't create files and directories.
    uninstall       Unstows dotfiles from target.
        Options:
            -s [...]    Source. Defaults to scripts directory.
            -t [...]    Target. Defaults to $HOME.

    auto            Get dotfiles from Git repository with submodules, then stow it.
        Options:
            -r [...]    Git repository used.
            -t [...]    Target. Default to $HOME
    update          Updates the Git repository and its modules, then restows dotfiles.
        Options:
            -l [...]    Local repository location. Defaults to scripts directory.
            -u          Skip updating.
            -m          Skip modules.
            -r          Skip restowing.
```

## Attribution

You don't need to credit me or the repo (see the license), but it would be really nice if you do :)
