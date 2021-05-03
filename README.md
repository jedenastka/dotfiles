# dotfiles

This repo contains my personal configurations ("dotfiles") that I use everyday on my machines. It also contains a script called `dotman` that simplifies local managment of these configurations on mutliple computers.

## Installing

### Quick install

**NOTE:** Doesn't work yet! Use [manual install](#Manual-install).

#### Recommended (safer) method: download and execute

First, download `dotman`:

```sh
# with curl:
curl https://gitlab.com/grzesiek11/dotfiles/-/raw/rewrite/dotman -o /tmp/dotman
# or with wget:
wget https://gitlab.com/grzesiek11/dotfiles/-/raw/rewrite/dotman -O /tmp/dotman
```

Then, you may inspect the script to make sure that it won't do any harm to your machine.

When you are done, run the installer:

```sh
sh /tmp/dotman installer
```

#### Unsafe method: pipe `curl` to `sh`

**If** [**you are aware of the risks** of piping `curl` to `sh`](https://0x46.net/thoughts/2019/04/27/piping-curl-to-shell/) and want to anyways, you can run:

```sh
# with curl:
curl https://gitlab.com/grzesiek11/dotfiles/-/raw/rewrite/dotman | sh -s installer
# or with wget:
wget https://gitlab.com/grzesiek11/dotfiles/-/raw/rewrite/dotman -O - | sh -s installer
```

### Manual install

1. Download the repository to a suitable folder.

```sh
# with HTTP:
git clone https://gitlab.com/grzesiek11/dotfiles.git ~/.dots
# with SSH:
git clone git@gitlab.com:grzesiek11/dotfiles.git ~/.dots
```

2. `cd` into it.

```sh
cd ~/.dots
```

3. Download submodules.

```sh
git submodules update --init --depth=1
```

4. Finally, install packages that you need with `dotman`.

```sh
dotman link base graphics
```

## Dotfiles

TODO

## `dotman`

TODO

## License

This repo is licensed under [The Unlicense](LICENSE). This means that you can use any part of it without giving me attribution (these are just configs), however, it would be nice if you do anyways (no pressure though) :)

The only exception is the `dotman` script - it's under ISC, but the notice is already attached to the file, so you don't need to do anything to include it in your repo/modify it.

