[ ]
[ ]

[Skip to content](#download)

csvtk - CSV/TSV Toolkit

Download

Initializing search

[GitHub](https://github.com/shenwei356/csvtk "Go to repository")

csvtk - CSV/TSV Toolkit

[GitHub](https://github.com/shenwei356/csvtk "Go to repository")

* [Home](..)
* [ ]

  Download

  [Download](./)

  Table of contents
  + [Current Version](#current-version)

    - [Links](#links)
  + [Installation](#installation)

    - [Method 1: Download binaries (latest stable/dev version)](#method-1-download-binaries-latest-stabledev-version)
    - [Method 2: Install via conda or pixi (latest stable version)](#method-2-install-via-conda-or-pixi-latest-stable-version)
    - [Method 3: Install via homebrew](#method-3-install-via-homebrew)
    - [Method 4: For ArchLinux AUR users (may be not the latest)](#method-4-for-archlinux-aur-users-may-be-not-the-latest)
    - [Method 5: Compiling from source (latest stable/dev version)](#method-5-compiling-from-source-latest-stabledev-version)
  + [Shell-completion](#shell-completion)
  + [Release history](#release-history)
* [Usage](../usage/)
* [FAQs](../faq/)
* [Tutorial](../tutorial/)
* [中文介绍](../chinese/)
* [More tools](https://github.com/shenwei356)

Table of contents

* [Current Version](#current-version)

  + [Links](#links)
* [Installation](#installation)

  + [Method 1: Download binaries (latest stable/dev version)](#method-1-download-binaries-latest-stabledev-version)
  + [Method 2: Install via conda or pixi (latest stable version)](#method-2-install-via-conda-or-pixi-latest-stable-version)
  + [Method 3: Install via homebrew](#method-3-install-via-homebrew)
  + [Method 4: For ArchLinux AUR users (may be not the latest)](#method-4-for-archlinux-aur-users-may-be-not-the-latest)
  + [Method 5: Compiling from source (latest stable/dev version)](#method-5-compiling-from-source-latest-stabledev-version)
* [Shell-completion](#shell-completion)
* [Release history](#release-history)

# Download

`csvtk` is implemented in [Go](https://golang.org/) programming language,
executable binary files **for most popular operating system** are freely available
in [release](https://github.com/shenwei356/csvtk/releases) page.

## Current Version

* [csvtk v0.34.0](https://github.com/shenwei356/csvtk/releases/tag/v0.34.0)
  [![Github Releases (by Release)](https://img.shields.io/github/downloads/shenwei356/csvtk/v0.34.0/total.svg)](https://github.com/shenwei356/csvtk/releases/tag/v0.34.0)
  + new command `csvtk plot bar`. Contributed by @lovromazgon [#323](https://github.com/shenwei356/csvtk/pull/323)
  + `csvtk`:
    - fix panic when the first field is empty, e.g., `-f ,2,3`.
  + `csvtk cut`:
    - fix `-b`. [#156](https://github.com/shenwei356/csvtk/issues/156)
    - fix `-i`. [#317](https://github.com/shenwei356/csvtk/issues/317)
  + `csvtk plot box`:
    - fix `--horiz` does not swap axes labels. [#314](https://github.com/shenwei356/csvtk/issues/314)
  + `csvtk plot line`:
    - add a new flag `--data-field-x-nominal` to plot line with sortable nominal X axis values, such as date.
      [#308](https://github.com/shenwei356/csvtk/pull/308) by @lovromazgon
  + `csvtk plot`:
    - add two new flags `--hide-x-labs` and `--hide-y-labs`, for hiding X/Y axis, ticks, and tick labels. [#326](https://github.com/shenwei356/csvtk/issues/326)
  + `csvtk fix`:
    - add a new flag `--na` to set content to fill. [#316](https://github.com/shenwei356/csvtk/issues/316)
  + `csvtk replace`:
    - add new replacements symbol/placeholder for group-specific numbering: `{gnr}`, `{enr}`, `{rnr}`. [#322](https://github.com/shenwei356/csvtk/issues/322)
  + `csvtk sort`:
    - add support for sorting by date/time. [#278](https://github.com/shenwei356/csvtk/issues/278)

### Links

| OS | Arch | File, 中国镜像 | Download Count |
| --- | --- | --- | --- |
| Linux | 32-bit | [csvtk\_linux\_386.tar.gz](https://github.com/shenwei356/csvtk/releases/download/v0.34.0/csvtk_linux_386.tar.gz),  [中国镜像](http://app.shenwei.me/data/csvtk/csvtk_linux_386.tar.gz) | [![Github Releases (by Asset)](https://img.shields.io/github/downloads/shenwei356/csvtk/latest/csvtk_linux_386.tar.gz.svg?maxAge=3600)](https://github.com/shenwei356/csvtk/releases/download/v0.34.0/csvtk_linux_386.tar.gz) |
| Linux | **64-bit** | [**csvtk\_linux\_amd64.tar.gz**](https://github.com/shenwei356/csvtk/releases/download/v0.34.0/csvtk_linux_amd64.tar.gz),  [中国镜像](http://app.shenwei.me/data/csvtk/csvtk_linux_amd64.tar.gz) | [![Github Releases (by Asset)](https://img.shields.io/github/downloads/shenwei356/csvtk/latest/csvtk_linux_amd64.tar.gz.svg?maxAge=3600)](https://github.com/shenwei356/csvtk/releases/download/v0.34.0/csvtk_linux_amd64.tar.gz) |
| Linux | **64-bit** | [**csvtk\_linux\_arm64.tar.gz**](https://github.com/shenwei356/csvtk/releases/download/v0.34.0/csvtk_linux_arm64.tar.gz),  [中国镜像](http://app.shenwei.me/data/csvtk/csvtk_linux_arm64.tar.gz) | [![Github Releases (by Asset)](https://img.shields.io/github/downloads/shenwei356/csvtk/latest/csvtk_linux_arm64.tar.gz.svg?maxAge=3600)](https://github.com/shenwei356/csvtk/releases/download/v0.34.0/csvtk_linux_arm64.tar.gz) |
| macOS | **64-bit** | [**csvtk\_darwin\_amd64.tar.gz**](https://github.com/shenwei356/csvtk/releases/download/v0.34.0/csvtk_darwin_amd64.tar.gz),  [中国镜像](http://app.shenwei.me/data/csvtk/csvtk_darwin_amd64.tar.gz) | [![Github Releases (by Asset)](https://img.shields.io/github/downloads/shenwei356/csvtk/latest/csvtk_darwin_amd64.tar.gz.svg?maxAge=3600)](https://github.com/shenwei356/csvtk/releases/download/v0.34.0/csvtk_darwin_amd64.tar.gz) |
| macOS | **arm64** | [**csvtk\_darwin\_arm64.tar.gz**](https://github.com/shenwei356/csvtk/releases/download/v0.34.0/csvtk_darwin_arm64.tar.gz),  [中国镜像](http://app.shenwei.me/data/csvtk/csvtk_darwin_arm64.tar.gz) | [![Github Releases (by Asset)](https://img.shields.io/github/downloads/shenwei356/csvtk/latest/csvtk_darwin_arm64.tar.gz.svg?maxAge=3600)](https://github.com/shenwei356/csvtk/releases/download/v0.34.0/csvtk_darwin_arm64.tar.gz) |
| Windows | 32-bit | [csvtk\_windows\_386.exe.tar.gz](https://github.com/shenwei356/csvtk/releases/download/v0.34.0/csvtk_windows_386.exe.tar.gz),  [中国镜像](http://app.shenwei.me/data/csvtk/csvtk_windows_386.exe.tar.gz) | [![Github Releases (by Asset)](https://img.shields.io/github/downloads/shenwei356/csvtk/latest/csvtk_windows_386.exe.tar.gz.svg?maxAge=3600)](https://github.com/shenwei356/csvtk/releases/download/v0.34.0/csvtk_windows_386.exe.tar.gz) |
| Windows | **64-bit** | [**csvtk\_windows\_amd64.exe.tar.gz**](https://github.com/shenwei356/csvtk/releases/download/v0.34.0/csvtk_windows_amd64.exe.tar.gz),  [中国镜像](http://app.shenwei.me/data/csvtk/csvtk_windows_amd64.exe.tar.gz) | [![Github Releases (by Asset)](https://img.shields.io/github/downloads/shenwei356/csvtk/latest/csvtk_windows_amd64.exe.tar.gz.svg?maxAge=3600)](https://github.com/shenwei356/csvtk/releases/download/v0.34.0/csvtk_windows_amd64.exe.tar.gz) |

**Notes**

* run `csvtk version` to check update !!!
* run `csvtk genautocomplete` to update Bash completion !!!

## Installation

[Download Page](https://github.com/shenwei356/csvtk/releases)

`csvtk` is implemented in [Go](https://golang.org/) programming language,
executable binary files **for most popular operating systems** are freely available
in [release](https://github.com/shenwei356/csvtk/releases) page.

#### Method 1: Download binaries (latest stable/dev version)

Just [download](https://github.com/shenwei356/csvtk/releases) compressed
executable file of your operating system,
and decompress it with `tar -zxvf *.tar.gz` command or other tools.
And then:

1. **For Linux-like systems**

   1. If you have root privilege simply copy it to `/usr/local/bin`:

      ```
      sudo cp csvtk /usr/local/bin/
      ```
   2. Or copy to anywhere in the environment variable `PATH`:

      ```
      mkdir -p $HOME/bin/; cp csvtk $HOME/bin/
      ```
2. **For windows**, just copy `csvtk.exe` to `C:\WINDOWS\system32`.

#### Method 2: Install via conda or pixi (latest stable version) [![Anaconda Cloud](https://anaconda.org/conda-forge/csvtk/badges/version.svg)](https://anaconda.org/conda-forge/csvtk)

```
# >= v0.31.0
conda install -c conda-forge csvtk

# <= v0.31.0
conda install -c bioconda csvtk

# pixi

pixi global install csvtk
```

#### Method 3: Install via homebrew

```
brew install csvtk
```

#### Method 4: For ArchLinux AUR users (may be not the latest)

```
yaourt -S csvtk
```

#### Method 5: Compiling from source (latest stable/dev version)

```
# ------------------- install golang -----------------

# download Go from https://go.dev/dl
wget https://go.dev/dl/go1.24.3.linux-amd64.tar.gz

tar -zxf go1.24.3.linux-amd64.tar.gz -C $HOME/

# or
#   echo "export PATH=$PATH:$HOME/go/bin" >> ~/.bashrc
#   source ~/.bashrc
export PATH=$PATH:$HOME/go/bin

# ------------------- compile csvtk ------------------

git clone https://github.com/shenwei356/csvtk
cd csvtk/csvtk/

# optionally choose a release
# git check v0.34.0

go build -trimpath -ldflags="-s -w" -tags netgo

# The executable binary file is located in:
#   ./csvtk
# You can also move it to anywhere in the $PATH
mkdir -p $HOME/bin
cp ./csvtk $HOME/bin/
```

## Shell-completion

Bash:

```
# generate completion shell
csvtk genautocomplete --shell bash

# configure if never did.
# install bash-completion if the "complete" command is not found.
echo "for bcfile in ~/.bash_completion.d/* ; do source \$bcfile; done" >> ~/.bash_completion
echo "source ~/.bash_completion" >> ~/.bashrc
```

Zsh:

```
# generate completion shell
csvtk genautocomplete --shell zsh --file ~/.zfunc/_csvtk

# configure if never did
echo 'fpath=( ~/.zfunc "${fpath[@]}" )' >> ~/.zshrc
echo "autoload -U compinit; compinit" >> ~/.zshrc
```

fish:

```
csvtk genautocomplete --shell fish --file ~/.config/fish/completions/csvtk.fish
```

## Release history

* [csvtk v0.33.0](https://github.com/shenwei356/csvtk/releases/tag/v0.33.0)
  [![Github Releases (by Release)](https://img.shields.io/github/downloads/shenwei356/csvtk/v0.33.0/total.svg)](https://github.com/shenwei356/csvtk/releases/tag/v0.33.0)
  + new command `csvtk comma`: make numbers more readable by adding commas. [#300](https://github.com/shenwei356/csvtk/issues/300)
  + `csvtk`:
    - add a global flag `-V/--version`. [#304](https://github.com/shenwei356/csvtk/issues/304)
  + `csvtk plot box/hist/line`:
    - adds `--x-scale-ln` and `--y-scale-ln` for natural log scaling of the X & Y axes. #302https://github.com/shenwei356/csvtk/pull/302) by @xxxserxxx
  + `csvtk fold`:
    - allow folding fields with no separater. [#299](https://github.com/shenwei356/csvtk/pull/299) by @fgvieira
  + `csvtk summary`:
    - numbers in scientific notation are output as is.
* [csvtk v0.32.0](https://github.com/shenwei356/csvtk/releases/tag/v0.32.0)
  [![Github Releases (by Release)](https://img.shields.io/github/downloads/shenwei356/csvtk/v0.32.0/total.svg)](https://github.com/shenwei356/csvtk/releases/tag/v0.32.0)
  + `csvtk filter2/mutate2/mutate3`:
    - fix a bug of mismatch between column names and values which was brought in v0.31.1. [#295](https://github.com/shenwei356/csvtk/issues/295)
    - add some unit tests.
  + `csvtk pretty`:
    - `-w/--min-width` and `-W/--max-width` accept multiple values for setting column-specific thresholds.
    - add a new format style `round` for round corners.
* [csvtk v0.31.1](https://github.com/shenwei356/csvtk/releases/tag/v0.31.1)
  [![Github Releases (by Release)](https://img.shields.io/github/downloads/shenwei356/csvtk/v0.31.1/total.svg)](https://github.com/shenwei356/csvtk/releases/tag/v0.31.1)
  + `csvtk filter2/mutate2/mutate3`:
    - **fix the slow speed**, I was stupid before. [#269](https://github.com/shenwei356/csvtk/issues/269)
  + `csvtk csv2json`:
    - further fix values with double quotes and new line symbols. [#291](https://github.com/shenwei356/csvtk/issues/291)
* [csvtk v0.31.0](https://github.com/shenwei356/csvtk/releases/tag/v0.31.0)
  [![Github Releases (by Release)](https://img.shields.io/github/downloads/shenwei356/csvtk/v0.31.0/total.svg)](https://github.com/shenwei356/csvtk/releases/tag/v0.31.0)
  + new command:
    - `csvtk mutate3`: create a new column from selected fields with Go-like expressions. Contributed by @moorereason [172](https://github.com/shenwei356/csvtk/issues/172)
  + `csvtk sort/join`:
    - faster speed and lower memory.
  + `csvtk sort`:
    - do not panic for empty input. [#287](https://github.com/shenwei356/csvtk/issues/287)
  + `csvtk summary`:
    - fix the order of columns. [#282](https://github.com/shenwei356/csvtk/issues/282)
  + `csvtk rename2`:
    - fix `-n/--start-num`. [#286](https://github.com/shenwei356/csvtk/issues/286)
    - add flag `--nr-width`.
  + `csvtk replace`:
    - fix implementing `{nr}`. [#286](https://github.com/shenwei356/csvtk/issues/286)
  + `csvtk csv2json`:
    - fix values with double quotes and new line symbols.
  + `csvtk split`:
    - support customize output file prefix and subdirectory from prefix of keys. [#288](https://github.com/shenwei356/csvtk/issues/288)
  + `csvtk spread`:
    - add a new alias "scatter" to "spread". [#265](https://github.com/shenwei356/csvtk/issues/265)
  + `csvtk grep`:
    - do not show progress.
  + `csvtk fix-quotes`:
    - new flag `-b, --buffer-size`.
  + `csvtk plot`:
    - new flag `--scale` for scaling the image width/height, tick, axes, line/point and font sizes proportionally, adviced by @tseemann.
  + `csvtk plot line`:
    - only add legend for more than one group. [#279](https://github.com/shenwei356/csvtk/issues/279)
    - sort points by X for plotting lines. [#280](https://github.com/shenwei356/csvtk/issues/280)
  + `csvtk hist`:
    - new flags: `--line-width`.
  + `csvtk box`:
    - plots of different groups have different colors now.
    - new flags: `--line-width`, `--point-size`, and `color-index`.
* [csvtk v0.30.0](https://github.com/shenwei356/csvtk/releases/tag/v0.30.0)
  [![Github Releases (by Release)](https://img.shields.io/github/downloads/shenwei356/csvtk/v0.30.0/total.svg)](https://github.com/shenwei356/csvtk/releases/tag/v0.30.0)
* `csvtk`:
  + grouping subcommands in help message.
  + add a new global flag `--quiet`. [#261](https://github.com/shenwei356/csvtk/issues/261)
  + add a new global flag `-U, --delete-header` for disable outputing the header row. Supported commands: concat, csv2tab/tab2csv, csv2xlsx/xlsx2csv, cut, filter, filter2, freq, fold/unfold, gather, fmtdate, grep, head, join, mutate, mutate2, replace, round, sample. [#258](https://github.com/shenwei356/csvtk/issues/258)
  + support more commands with `-Z/--show-row-number`: head.
* `csvtk dim`:
  + fix duplicated rows for multiple input files, this bug was introduced in v0.27.0.
* `csvtk concat`:
  + fix panic when no data found. [#259](https://github.com/shenwei356/csvtk/issues/259)
* `csvtk spread`:
  + fix flag checking of `-k` and `-v`.
* `csvtk sort`:
  + fix ordering when given multiple cust