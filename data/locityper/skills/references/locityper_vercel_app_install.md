[Locityper](/)[AboutAbout](/about)[GitHubGitHub (opens in a new tab)](https://github.com/tprodanov/locityper)

* [Introduction](/)
* [Installation](/install)
* [Test dataset](/test_dataset)
* [Commands](/commands)
* [Input/Output](/input_output)
* [Method description](/descr)
* [Avalable data](/available_data)

Light

On This Page

* [Conda](#conda)
* [Docker and Singularity](#docker-and-singularity)
* [Manual installation](#manual-installation)
* [Compiling without GCC](#compiling-without-gcc)
* [Compiling with ILP solvers](#compiling-with-ilp-solvers)
* [Compiling Locityper without internet](#compiling-locityper-without-internet)
* [System requirements](#system-requirements)

[Report bug/Ask question (opens in a new tab)](https://github.com/tprodanov/locityper/issues)Scroll to top

Installation

## Conda

As mentioned in the introduction, Locityper can be installed using `conda`/`mamba`:

```
conda install -c bioconda locityper
```

During installation, please check that the [latest release version (opens in a new tab)](https://github.com/tprodanov/locityper/releases)
is being installed.

## Docker and Singularity

First, please clone the repository with

```
git clone https://github.com/tprodanov/locityper
cd locityper
```

To create Locityper container, run the following commands:

singularitydocker

```
# Without sudo
singularity build --fakeroot locityper.sif containers/locityper.def
# Or with sudo
sudo singularity build locityper.sif containers/locityper.def
```

Next, to run Locityper containers, please use

singularitydocker

```
./locityper.sif command [args]
# If needed, you can execute dependencies with
./locityper.sif jellyfish/minimap2/strobealign [args]
# You can also explicitely run singularity
singularity exec locityper.sif ...
```

## Manual installation

For manual installation, you need the following software:

* [Rust ≥ 1.70 (opens in a new tab)](https://www.rust-lang.org/),
* [GCC ≥ 4.9.0 (opens in a new tab)](https://gcc.gnu.org/), optional, see [here](/install#wo_gcc),
* [Samtools (opens in a new tab)](https://www.htslib.org/),
* [Jellyfish (opens in a new tab)](https://github.com/gmarcais/Jellyfish/),
* [Minimap2 (opens in a new tab)](https://github.com/lh3/minimap2) if you plan to genotype long-read data,
* [Strobealign ≥ 1.12 (opens in a new tab)](https://github.com/ksahlin/strobealign) if you plan to genotype short-read data.

Next, please follow the next steps:

```
git clone https://github.com/tprodanov/locityper
cd locityper
git clone https://github.com/smarco/WFA2-lib WFA2
cargo build --release
cargo install
```

### Compiling without GCC

It is possible to reduce the number of dependencies by sacrificing some functionality.
In particular, one can compile `locityper` without the `WFA` library and the `GCC` compiler:

```
git clone https://github.com/tprodanov/locityper
cd locityper
cargo build --release --no-default-features
cargo install
```

In such configuration, locityper [align](/commands#align) command will be unavailable.

### Compiling with ILP solvers

By default, ILP solvers are turned off, instead, stochastic optimization is used.
To turn ILP solvers on, you should compile the code with

```
cargo build --release --features highs
# OR
cargo build --release --features gurobi
```

Please follow [instruction here (opens in a new tab)](https://lib.rs/crates/grb)
to link [Gurobi (opens in a new tab)](https://gurobi.com) library. In addition, one can apply for an academic Gurobi license
[here (opens in a new tab)](http://www.gurobi.com/downloads/licenses/license-center).

### Compiling Locityper without internet

On many academic servers, access to internet is restricted.
In such cases, conda/docker/singularity installation is recommended.
Nevertheless, it is possible to compile Locityper in offline mode.

For that, please run `cargo vendor` in the Locityper directory on the machine with internet access,
and then copy `vendor`, `locityper` and `locityper/WFA2` directories to the server.
Then, follow [source replacement (opens in a new tab)](https://doc.rust-lang.org/cargo/reference/source-replacement.html)
instructions and compile the tool with

```
cargo build --release --offline
```

## System requirements

As Locityper can be installed with Docker, it can be run on any system
with installed Docker ([FAQ here (opens in a new tab)](https://docs.docker.com/engine/faq/)).

Installation from source was tested on Arch Linux and CentOS Linux 7.
The process should take between 3 and 10 minutes,
depending on the internet speed, desktop specifications and installation method.
It is recommended to have at least 16 Gb RAM (preferably 32 Gb) to run Locityper.

[Introduction](/ "Introduction")[Test dataset](/test_dataset "Test dataset")

Light

---

[Timofey Prodanov. Locityper documentation (2024).](https://github.com/tprodanov/locityper-docs)

[Created using the Nextra theme.](https://nextra.site)