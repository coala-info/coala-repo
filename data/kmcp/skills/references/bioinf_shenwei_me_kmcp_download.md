[ ]
[ ]

[Skip to content](#download)

[![logo](../favicon.svg)](.. "KMCP - accurate metagenomic profiling and fast large-scale sequence/genome searching")

KMCP - accurate metagenomic profiling and fast large-scale sequence/genome searching

Download

Initializing search

[GitHub](https://github.com/shenwei356/kmcp/ "Go to repository")

[![logo](../favicon.svg)](.. "KMCP - accurate metagenomic profiling and fast large-scale sequence/genome searching")
KMCP - accurate metagenomic profiling and fast large-scale sequence/genome searching

[GitHub](https://github.com/shenwei356/kmcp/ "Go to repository")

* [Home](..)
* [ ]

  Download
  [Download](./)

  Table of contents
  + [SIMD instructions support](#simd-instructions-support)
  + [Current Version](#current-version)

    - [v0.9.4 - 2023-09-18](#v094-2023-09-18)
    - [Links](#links)
  + [Installation](#installation)

    - [Method 1: Install using conda](#method-1-install-using-conda)
    - [Method 2: Download binaries](#method-2-download-binaries)
    - [Method 3: Compile from source](#method-3-compile-from-source)
  + [Shell-completion](#shell-completion)
  + [Release History](#release-history)

    - [v0.9.3 - 2023-07-16](#v093-2023-07-16)
    - [v0.9.2 - 2023-05-16](#v092-2023-05-16)
    - [v0.9.1 - 2022-12-26](#v091-2022-12-26)
    - [v0.9.0 - 2022-09-28](#v090-2022-09-28)
    - [v0.8.3 - 2022-08-15](#v083-2022-08-15)
    - [v0.8.2 - 2022-03-26](#v082-2022-03-26)
    - [v0.8.1 - 2022-03-07](#v081-2022-03-07)
    - [v0.8.0 - 2022-02-24](#v080-2022-02-24)
    - [v0.7.1 - 2022-02-08](#v071-2022-02-08)
    - [v0.7.0 - 2022-01-24](#v070-2022-01-24)
    - [v0.6.0 - 2021-08-13](#v060-2021-08-13)
    - [v0.5.0 - 2021-06-24](#v050-2021-06-24)
    - [v0.4.0 - 2021-04-08](#v040-2021-04-08)
    - [v0.3.0 - 2021-03-16](#v030-2021-03-16)
    - [v0.2.1 - 2020-12-31](#v021-2020-12-31)
    - [v0.2.0 - 2020-12-30](#v020-2020-12-30)
    - [v0.1.0 - 2020-xx-xx](#v010-2020-xx-xx)
* [Databases](../database/)
* [Usage](../usage/)
* [ ]

  Tutorials

  Tutorials
  + [Taxonomic profiling](../tutorial/profiling/)
  + [Detecting specific pathogens](../tutorial/detecting-pathogens/)
  + [Detecting contaminated sequences](../tutorial/detecting-contaminated-seqs/)
  + [Sequence and genome searching](../tutorial/searching/)
* [ ]

  Benchmarks

  Benchmarks
  + [Taxonomic profiling](../benchmark/profiling/)
  + [Sequence and genome searching](../benchmark/searching/)
* [FAQs](../faq/)
* [More tools](https://github.com/shenwei356)

Table of contents

* [SIMD instructions support](#simd-instructions-support)
* [Current Version](#current-version)

  + [v0.9.4 - 2023-09-18](#v094-2023-09-18)
  + [Links](#links)
* [Installation](#installation)

  + [Method 1: Install using conda](#method-1-install-using-conda)
  + [Method 2: Download binaries](#method-2-download-binaries)
  + [Method 3: Compile from source](#method-3-compile-from-source)
* [Shell-completion](#shell-completion)
* [Release History](#release-history)

  + [v0.9.3 - 2023-07-16](#v093-2023-07-16)
  + [v0.9.2 - 2023-05-16](#v092-2023-05-16)
  + [v0.9.1 - 2022-12-26](#v091-2022-12-26)
  + [v0.9.0 - 2022-09-28](#v090-2022-09-28)
  + [v0.8.3 - 2022-08-15](#v083-2022-08-15)
  + [v0.8.2 - 2022-03-26](#v082-2022-03-26)
  + [v0.8.1 - 2022-03-07](#v081-2022-03-07)
  + [v0.8.0 - 2022-02-24](#v080-2022-02-24)
  + [v0.7.1 - 2022-02-08](#v071-2022-02-08)
  + [v0.7.0 - 2022-01-24](#v070-2022-01-24)
  + [v0.6.0 - 2021-08-13](#v060-2021-08-13)
  + [v0.5.0 - 2021-06-24](#v050-2021-06-24)
  + [v0.4.0 - 2021-04-08](#v040-2021-04-08)
  + [v0.3.0 - 2021-03-16](#v030-2021-03-16)
  + [v0.2.1 - 2020-12-31](#v021-2020-12-31)
  + [v0.2.0 - 2020-12-30](#v020-2020-12-30)
  + [v0.1.0 - 2020-xx-xx](#v010-2020-xx-xx)

# Download

KMCP is implemented in [Go](https://golang.org/) programming language,
statically-linked executable binary files are [freely available](https://github.com/shenwei356/kmcp/releases).

### SIMD instructions support

SIMD extensions including `AVX512`, `AVX2`, `SSE2` are sequentially detected and used
in two packages for better searching performance.

* [pand](https://github.com/shenwei356/pand),
  for accelerating searching on databases constructed with multiple hash functions.
* [pospop](https://github.com/shenwei356/pospop/tree/short-input3),
  for batch counting matched k-mers in bloom filters.

ARM architecture is supported, but `kmcp search` would be slower.

## Current Version

### [v0.9.4](https://github.com/shenwei356/kmcp/releases/tag/v0.9.4) - 2023-09-18 [![Github Releases (by Release)](https://img.shields.io/github/downloads/shenwei356/kmcp/v0.9.4/total.svg)](https://github.com/shenwei356/kmcp/releases/tag/v0.9.4)

* `kmcp merge`:
  + trim tailing tab in merged result, down-stream results are not affected. [#38](https://github.com/shenwei356/kmcp/issues/38)
* `kmcp profile`:
  + fix log of "xx% (yy/zz) reads matched", the numerator should be the number of matched reads instead of reads belonging to references.
  + early quit when no target detected.
  + slightly speedup.

### Links

| OS | Arch | File, 中国镜像 | Download Count |
| --- | --- | --- | --- |
| Linux | **64-bit** | [**kmcp\_linux\_amd64.tar.gz**](https://github.com/shenwei356/kmcp/releases/download/v0.9.4/kmcp_linux_amd64.tar.gz),   [中国镜像](http://app.shenwei.me/data/kmcp/kmcp_linux_amd64.tar.gz) | [![Github Releases (by Asset)](https://img.shields.io/github/downloads/shenwei356/kmcp/latest/kmcp_linux_amd64.tar.gz.svg?maxAge=3600)](https://github.com/shenwei356/kmcp/releases/download/v0.9.4/kmcp_linux_amd64.tar.gz) |
| Linux | arm64 | [**kmcp\_linux\_arm64.tar.gz**](https://github.com/shenwei356/kmcp/releases/download/v0.9.4/kmcp_linux_arm64.tar.gz),   [中国镜像](http://app.shenwei.me/data/kmcp/kmcp_linux_arm64.tar.gz) | [![Github Releases (by Asset)](https://img.shields.io/github/downloads/shenwei356/kmcp/latest/kmcp_linux_arm64.tar.gz.svg?maxAge=3600)](https://github.com/shenwei356/kmcp/releases/download/v0.9.4/kmcp_linux_arm64.tar.gz) |
| macOS | **64-bit** | [**kmcp\_darwin\_amd64.tar.gz**](https://github.com/shenwei356/kmcp/releases/download/v0.9.4/kmcp_darwin_amd64.tar.gz),   [中国镜像](http://app.shenwei.me/data/kmcp/kmcp_darwin_amd64.tar.gz) | [![Github Releases (by Asset)](https://img.shields.io/github/downloads/shenwei356/kmcp/latest/kmcp_darwin_amd64.tar.gz.svg?maxAge=3600)](https://github.com/shenwei356/kmcp/releases/download/v0.9.4/kmcp_darwin_amd64.tar.gz) |
| macOS | arm64 | [**kmcp\_darwin\_arm64.tar.gz**](https://github.com/shenwei356/kmcp/releases/download/v0.9.4/kmcp_darwin_arm64.tar.gz),   [中国镜像](http://app.shenwei.me/data/kmcp/kmcp_darwin_arm64.tar.gz) | [![Github Releases (by Asset)](https://img.shields.io/github/downloads/shenwei356/kmcp/latest/kmcp_darwin_arm64.tar.gz.svg?maxAge=3600)](https://github.com/shenwei356/kmcp/releases/download/v0.9.4/kmcp_darwin_arm64.tar.gz) |
| Windows | **64-bit** | [**kmcp\_windows\_amd64.exe.tar.gz**](https://github.com/shenwei356/kmcp/releases/download/v0.9.4/kmcp_windows_amd64.exe.tar.gz),   [中国镜像](http://app.shenwei.me/data/kmcp/kmcp_windows_amd64.exe.tar.gz) | [![Github Releases (by Asset)](https://img.shields.io/github/downloads/shenwei356/kmcp/latest/kmcp_windows_amd64.exe.tar.gz.svg?maxAge=3600)](https://github.com/shenwei356/kmcp/releases/download/v0.9.4/kmcp_windows_amd64.exe.tar.gz) |

*Notes:*

* please open an issue to request binaries for other platforms or [compile from the source](#method-3-compile-from-source).
* run `kmcp version` to check update !!!
* run `kmcp autocompletion` to update shell autocompletion script !!!

## Installation

#### Method 1: Install using conda [![Anaconda Cloud](https://anaconda.org/bioconda/kmcp/badges/version.svg)](https://anaconda.org/bioconda/kmcp) [![downloads](https://anaconda.org/bioconda/kmcp/badges/downloads.svg)](https://anaconda.org/bioconda/kmcp)

```
conda install -c bioconda kmcp
```

#### Method 2: Download binaries

[Download](https://github.com/shenwei356/kmcp/releases) the compressed
executable file of your operating system,
and decompress it with `tar -zxvf *.tar.gz` command or other tools.
And then:

* **For Linux-like systems**

  + If you have root privilege, simply copy it to `/usr/local/bin`:

    ```
    sudo cp kmcp /usr/local/bin/
    ```
  + Or copy to anywhere in the environment variable `PATH`:

    ```
    mkdir -p $HOME/bin/; cp kmcp $HOME/bin/
    ```
* **For Windows**, just copy `kmcp.exe` to `C:\WINDOWS\system32`.

#### Method 3: Compile from source

1. [Install go](https://go.dev/doc/install)

   ```
   wget https://go.dev/dl/go1.17.13.linux-amd64.tar.gz

   tar -zxf go1.17.13.linux-amd64.tar.gz -C $HOME/

   # or
   #   echo "export PATH=$PATH:$HOME/go/bin" >> ~/.bashrc
   #   source ~/.bashrc
   export PATH=$PATH:$HOME/go/bin
   ```
2. Compile KMCP

   ```
   # ------------- the latest stable version -------------

   go get -v -u github.com/shenwei356/kmcp/kmcp

   # The executable binary file is located in:
   #   ~/go/bin/kmcp
   # You can also move it to anywhere in the $PATH
   mkdir -p $HOME/bin
   cp ~/go/bin/kmcp $HOME/bin/

   # --------------- the development version --------------

   git clone https://github.com/shenwei356/kmcp
   cd kmcp/kmcp/
   go build

   # The executable binary file is located in:
   #   ./kmcp
   # You can also move it to anywhere in the $PATH
   mkdir -p $HOME/bin
   cp ./kmcp $HOME/bin/
   ```

## Shell-completion

Supported shell: bash|zsh|fish|powershell

Bash:

```
# generate completion shell
kmcp autocompletion --shell bash

# configure if never did.
# install bash-completion if the "complete" command is not found.
echo "for bcfile in ~/.bash_completion.d/* ; do source \$bcfile; done" >> ~/.bash_completion
echo "source ~/.bash_completion" >> ~/.bashrc
```

Zsh:

```
# generate completion shell
kmcp autocompletion --shell zsh --file ~/.zfunc/_kmcp

# configure if never did
echo 'fpath=( ~/.zfunc "${fpath[@]}" )' >> ~/.zshrc
echo "autoload -U compinit; compinit" >> ~/.zshrc
```

fish:

```
kmcp autocompletion --shell fish --file ~/.config/fish/completions/kmcp.fish
```

## Release History

### [v0.9.3](https://github.com/shenwei356/kmcp/releases/tag/v0.9.3) - 2023-07-16 [![Github Releases (by Release)](https://img.shields.io/github/downloads/shenwei356/kmcp/v0.9.3/total.svg)](https://github.com/shenwei356/kmcp/releases/tag/v0.9.3)

* `kmcp compute/split-genomes`:
  + fix a bug in chunk computation when splitting circular genomes (`--circular`).
* `kmcp search/merge`:

  + append simple stats to the search result as comment lines, including the number of input and matched queries. e.g.,

    ```
    # input queries: 930254
    # matched queries: 923820
    # matched percentage: 99.3084%
    ```
* `kmcp profile`:

  + fix metaphlan out format. [#34](https://github.com/shenwei356/kmcp/issues/34)
  + show stats of the number of input and matched queries in log. **It would be helpful to show whether the reference genomes cover all microorganisms in the sample**.

    ```
    20:00:55.295 [INFO] 99.3084% (923820/930254) reads matched
    20:00:55.295 [INFO] 100.0000% (923820/923820) matched reads belong to the 2 references in the profile
    ```
* new tutorials:

  + [Detecting specific pathogens](https://bioinf.shenwei.me/kmcp/tutorial/detecting-pathogens)
  + [Detecting contaminated sequences](https://bioinf.shenwei.me/kmcp/tutorial/detecting-contaminated-seqs)

### [v0.9.2](https://github.com/shenwei356/kmcp/releases/tag/v0.9.2) - 2023-05-16 [![Github Releases (by Release)](https://img.shields.io/github/downloads/shenwei356/kmcp/v0.9.2/total.svg)](https://github.com/shenwei356/kmcp/releases/tag/v0.9.2)

* `kmcp profile/cos2simi/filter/index-info/merge-regions/query-fpr`:
  + **rename/unify the long flag `--out-prefix` to `--out-file`**.
* `kmcp profile`:
  + fix the number of reads belonging to references in the profile when no matches are found, which should be 0 instead of 1.
* new command:
  + `kmcp utils index-density`: plotting the element density of bloom filters for an index file.
    An audience was concerned about it, but the results showed the elements (1s) are uniformly distributed in all BFs.

### [v0.9.1](https://github.com/shenwei356/kmcp/releases/tag/v0.9.1) - 2022-12-26 [![Github Releases (by Release)](https://img.shields.io/github/downloads/shenwei356/kmcp/v0.9.1/total.svg)](https://github.com/shenwei356/kmcp/releases/tag/v0.9.1)

* `kmcp search`
  + faster speed for ARM architectures.
  + fix compilation for ARM architectures.

### [v0.9.0](https://github.com/shenwei356/kmcp/releases/tag/v0.9.0) - 2022-09-28 [![Github Releases (by Release)](https://img.shields.io/github/downloads/shenwei356/kmcp/v0.9.0/total.svg)](https://github.com/shenwei356/kmcp/releases/tag/v0.9.0)

* `compute`:
  + smaller output files and faster speed.
  + more even genome splitting.
* `index`:
  + faster speed due to smaller input files.
* `search`:
  + ***more accurate and smaller query FPR following Theorem 2 in SBT paper, instead of the Chernoff bound***.
  + change the default value of `-f/--max-fpr` from 0.05 to 0.01.
  + ***10-20% speedup***.
* `profile`:
  + ***more accurate abundance estimation using EM algorithm***.
  + change the default value of `-f/--max-fpr` from 0.05 to 0.01.
  + mode 0: change the default value of `-H/--min-hic-ureads-qcov` from 0.55 to 0.7.
  + increase float width of reference coverage in KMCP profile format from 2 to 6.
* `util query-fpr`:
  + compute query FPR following Theorem 2 in SBT paper, instead of the Chernoff bound.
* new commands:
  + `utils split-genomes` for splitting genomes into chunks.
  + `utils ref-info` for printing information of reference (chunks), including the number of k-mers
    and the actual false-positive rate.

### [v0.8.3](https://github.com/shenwei356/kmcp/releases/tag/v0.8.3) - 2022-08-15 [![Github Releases (by Release)](https://img.shields.io/github/downloads/shenwei356/kmcp/v0.8.3/total.svg)](https://github.com/shenwei356/kmcp/releases/tag/v0.8.3)

* `kmcp`: fix compiling from source for ARM architectures.[#17](https://github.com/shenwei356/kmcp/issues/17)
* `search`:
  + fix searching with paired-end reads where the read2 is shorter than the value of `--min-query-len`. [#10](https://github.com/shenwei356/kmcp/issues/10)
  + fix the log. [#8](https://github.com/shenwei356/kmcp/issues/8)
  + a new flag `-f/--max-fpr`: maximum false positive rate of a query (default 0.05). It reduces the unnecessary output when searching with a low minimum query coverage (`-t/--min-query-cov`).
* `profile`:
  + recommend using the flag `--no-amb-corr` to disable ambiguous reads correction when >= 1000 candidates are detected.
  + fix logging when using `--level strain` and no taxonomy given.

### [v0.8.2](https://github.com/shenwei356/kmcp/releases/tag/v0.8.2) - 2022-03-26 [![Github Releases (by Release)](https://img.shields.io/github/downloads/shenwei356/kmcp/v0.8.2/total.svg)](https://github.com/shenwei356/kmcp/releases/tag/v0.8.2)

* `search`:
  + flag `-g/-