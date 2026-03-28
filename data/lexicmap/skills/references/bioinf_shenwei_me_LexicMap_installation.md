[Skip to main content](#main-content)

[ ]
[ ]

Open Navigation

Close Navigation

[![](/LexicMap/logo.svg)
LexicMap: efficient sequence alignment against millions of prokaryotic genomes​](https://bioinf.shenwei.me/LexicMap/)

[GitHub](https://github.com/shenwei356/LexicMap)

Toggle Dark/Light/Auto mode

Toggle Dark/Light/Auto mode

Toggle Dark/Light/Auto mode

[Back to homepage](https://bioinf.shenwei.me/LexicMap/)

Close Menu Bar

Open Menu Bar

## Navigation

* [ ]

  [Introduction](/LexicMap/introduction/)
* [ ]

  [Installation](/LexicMap/installation/)
* [ ]

  [Releases](/LexicMap/releases/)
* [ ]

  Tutorials
  + [ ]

    [Step 1. Building a database](/LexicMap/tutorials/index/)
  + [ ]

    [Step 2. Searching](/LexicMap/tutorials/search/)
  + [ ]

    More

    - [ ]

      [Indexing GTDB](/LexicMap/tutorials/misc/index-gtdb/)
    - [ ]

      [Indexing GenBank+RefSeq](/LexicMap/tutorials/misc/index-genbank/)
    - [ ]

      [Indexing AllTheBacteria](/LexicMap/tutorials/misc/index-allthebacteria/)
    - [ ]

      [Indexing GlobDB](/LexicMap/tutorials/misc/index-globdb/)
    - [ ]

      [Indexing UHGG](/LexicMap/tutorials/misc/index-uhgg/)
* [ ]

  Usage
  + [ ]

    [lexicmap](/LexicMap/usage/lexicmap/)
  + [ ]

    [index](/LexicMap/usage/index/)
  + [ ]

    [search](/LexicMap/usage/search/)
  + [ ]

    [utils](/LexicMap/usage/utils/)

    - [ ]

      [2blast](/LexicMap/usage/utils/2blast/)
    - [ ]

      [2sam](/LexicMap/usage/utils/2sam/)
    - [ ]

      [merge-search-results](/LexicMap/usage/utils/merge-search-results/)
    - [ ]

      [masks](/LexicMap/usage/utils/masks/)
    - [ ]

      [kmers](/LexicMap/usage/utils/kmers/)
    - [ ]

      [genomes](/LexicMap/usage/utils/genomes/)
    - [ ]

      [subseq](/LexicMap/usage/utils/subseq/)
    - [ ]

      [seed-pos](/LexicMap/usage/utils/seed-pos/)
    - [ ]

      [reindex-seeds](/LexicMap/usage/utils/reindex-seeds/)
    - [ ]

      [remerge](/LexicMap/usage/utils/remerge/)
    - [ ]

      [edit-genome-ids](/LexicMap/usage/utils/edit-genome-ids/)
* [ ]

  [FAQs](/LexicMap/faqs/)
* [ ]

  Notes
  + [ ]

    [Motivation](/LexicMap/notes/motivation/)

## More

* [ ]

  [More tools](https://github.com/shenwei356)

2. /
3. Installation

# Installation

LexicMap can be installed via [conda](#conda), downloading [executable binary files](#binary-files),
or [compiling from the source](#compile-from-the-source).

Besides, it supports [shell completion](#shell-completion), which could help accelerate typing.

## Conda/Pixi

[Install conda](https://docs.conda.io/projects/conda/en/latest/user-guide/install/index.html), then run

```
conda install -c bioconda lexicmap
```

Or use [mamba](https://mamba.readthedocs.io/en/latest/installation/mamba-installation.html), which is faster.

```
conda install -c conda-forge mamba
mamba install -c bioconda lexicmap
```

Or use [pixi](https://pixi.sh/), which is even faster.

```
pixi config channels add bioconda
pixi add lexicmap
```

Linux and MacOS (both x86 and arm CPUs) are supported.

## Binary files

Linux

1. Download the binary file.

   | OS | Arch | File |
   | --- | --- | --- |
   | Linux | **64-bit** | [**lexicmap\_linux\_amd64.tar.gz**](https://github.com/shenwei356/LexicMap/releases/download/v0.9.0/lexicmap_linux_amd64.tar.gz) |
   | Linux | arm64 | [**lexicmap\_linux\_arm64.tar.gz**](https://github.com/shenwei356/LexicMap/releases/download/v0.9.0/lexicmap_linux_arm64.tar.gz) |
2. Decompress it:

   ```
    tar -zxvf lexicmap_linux_amd64.tar.gz
   ```
3. If you have the root privilege, simply copy it to `/usr/local/bin`:

   ```
    sudo cp lexicmap /usr/local/bin/
   ```
4. If you don’t have the root privilege, copy it to any directory in the environment variable `PATH`:

   ```
    mkdir -p $HOME/bin/; cp lexicmap $HOME/bin/
   ```

   And optionally add the directory into the environment variable `PATH` if it’s not in.

   ```
    # bash
    echo export PATH=\$PATH:\$HOME/bin/ >> $HOME/.bashrc
    source $HOME/.bashrc # apply the configuration

    # zsh
    echo export PATH=\$PATH:\$HOME/bin/ >> $HOME/.zshrc
    source $HOME/.zshrc # apply the configuration
   ```

MacOS

1. Download the binary file.

   | OS | Arch | File |
   | --- | --- | --- |
   | macOS | 64-bit | [**lexicmap\_darwin\_amd64.tar.gz**](https://github.com/shenwei356/LexicMap/releases/download/v0.9.0/lexicmap_darwin_amd64.tar.gz) |
   | macOS | **arm64** | [**lexicmap\_darwin\_arm64.tar.gz**](https://github.com/shenwei356/LexicMap/releases/download/v0.9.0/lexicmap_darwin_arm64.tar.gz) |
2. Copy it to any directory in the environment variable `PATH`:

   ```
    mkdir -p $HOME/bin/; cp lexicmap $HOME/bin/
   ```

   And optionally add the directory into the environment variable `PATH` if it’s not in.

   ```
    # bash
    echo export PATH=\$PATH:\$HOME/bin/ >> $HOME/.bashrc
    source $HOME/.bashrc # apply the configuration

    # zsh
    echo export PATH=\$PATH:\$HOME/bin/ >> $HOME/.zshrc
    source $HOME/.zshrc # apply the configuration
   ```

FreeBSD

1. Download the binary file.

   | OS | Arch | File |
   | --- | --- | --- |
   | FreeBSD | **64-bit** | [**lexicmap\_freebsd\_amd64.tar.gz**](https://github.com/shenwei356/LexicMap/releases/download/v0.9.0/lexicmap_freebsd_amd64.tar.gz) |

Windows

1. Download the binary file.

   | OS | Arch | File |
   | --- | --- | --- |
   | Windows | **64-bit** | [**lexicmap\_windows\_amd64.exe.tar.gz**](https://github.com/shenwei356/LexicMap/releases/download/v0.9.0/lexicmap_windows_amd64.exe.tar.gz) |
2. Decompress it.
3. Copy `lexicmap.exe` to `C:\WINDOWS\system32`.

Others

* Please [open an issue](https://github.com/shenwei356/LexicMap/issues) to request binaries for other platforms.
* Or [compiling from the source](#compile-from-the-source).

## Compile from the source

1. [Install go](https://go.dev/doc/install) (go 1.22 or later versions).

   ```
    wget https://go.dev/dl/go1.26.1.linux-amd64.tar.gz

    tar -zxf go1.26.1.linux-amd64.tar.gz -C $HOME/

    # or
    #   echo "export PATH=$PATH:$HOME/go/bin" >> ~/.bashrc
    #   source ~/.bashrc
    export PATH=$PATH:$HOME/go/bin
   ```
2. Compile LexicMap.

   ```
    # ------------- the latest stable version -------------

    go install -v github.com/shenwei356/LexicMap/lexicmap@latest

    # The executable binary file is located in:
    #   ~/go/bin/lexicmap
    # You can also move it to anywhere in the $PATH
    mkdir -p $HOME/bin
    cp ~/go/bin/lexicmap $HOME/bin/

    # --------------- the latest stable/development version --------------

    git clone https://github.com/shenwei356/LexicMap

    # Optionally chose a version
    # git check v0.9.0

    cd LexicMap/lexicmap/
    go build

    # The executable binary file is located in:
    #   ./lexicmap
    # You can also move it to anywhere in the $PATH
    mkdir -p $HOME/bin
    cp ./lexicmap $HOME/bin/
   ```

## Shell-completion

Supported shell: bash|zsh|fish|powershell

Bash:

```
# generate completion shell
lexicmap autocompletion --shell bash

# configure if never did.
# install bash-completion if the "complete" command is not found.
echo "for bcfile in ~/.bash_completion.d/* ; do source \$bcfile; done" >> ~/.bash_completion
echo "source ~/.bash_completion" >> ~/.bashrc
```

Zsh:

```
# generate completion shell
lexicmap autocompletion --shell zsh --file ~/.zfunc/_kmcp

# configure if never did
echo 'fpath=( ~/.zfunc "${fpath[@]}" )' >> ~/.zshrc
echo "autoload -U compinit; compinit" >> ~/.zshrc
```

fish:

```
lexicmap autocompletion --shell fish --file ~/.config/fish/completions/lexicmap.fish
```

[*gdoc\_arrow\_left\_alt*
Introduction](/LexicMap/introduction/ "Introduction")

[Releases
*gdoc\_arrow\_right\_alt*](/LexicMap/releases/ "Releases")

Built with [Hugo](https://gohugo.io/) and

Back to top