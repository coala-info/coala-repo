Contents

Menu

Expand

Light mode

Dark mode

Auto light/dark, in light mode

Auto light/dark, in dark mode

[ ]
[ ]

[Skip to content](#furo-main-content)

[alevin-fry 0.11.0 documentation](index.html)

[![Logo](_static/logo.png)

alevin-fry 0.11.0 documentation](index.html)

Contents:

* [Overview](overview.html)
* [Other resources for alevin-fry](overview.html#other-resources-for-alevin-fry)
* Installing alevin-fry
* [Getting Started](getting_started.html)
* [alevin-fry commands](commands.html)[ ]
* [License](LICENSE.html)

Back to top

[View this page](_sources/installing.rst.txt "View this page")

# Installing alevin-fry[¶](#installing-alevin-fry "Link to this heading")

Alevin-fry can be installed using a package manager such as `conda`, or built from source.

## Installing with bioconda[¶](#installing-with-bioconda "Link to this heading")

Alevin-fry is available for both x86 linux and OSX platforms [using bioconda](https://anaconda.org/bioconda/alevin-fry).

With `bioconda` in the appropriate place in your channel list, you should simply be able to install via:

```
$ conda install alevin-fry
```

## Installing from source[¶](#installing-from-source "Link to this heading")

If you want to use features or fixes that may only be available in the latest develop branch (or want to build for a different
architecture), then you have to build from source. Luckily, `cargo` makes that easy; see below.

Alevin-fry is built and tested with the latest (major & minor) stable version of [Rust](https://www.rust-lang.org/). While it will likely compile fine with older versions of Rust, this is not a guarantee and is not a support priority. Unlike with C++, Rust has a frequent and stable release cadence, is designed to be installed and updated from user space, and is easy to keep up to date with [rustup](https://rustup.rs/). Thanks to cargo, building should be as easy as:

```
$ cargo build --release
```

subsequent you will want to place `alevin-fry` in your `PATH`. This can be done (in bash-like shells) using:

```
$ export PATH=`pwd`/target/release/:$PATH
```

To ensure that `alevin-fry` remains in your path between logins, you should make sure the path to `target/release/` shown above is set in the `PATH` variable in the appropriate file for your shell (e.g. in `~/.profile`, `~/.bashrc` etc.).

[Next

Getting Started](getting_started.html)
[Previous

Overview](overview.html)

Copyright © 2021-2024, Dongze He, Mohsen Zakeri, Hirak Sarkar, Charlotte Soneson, Avi Srivastava, Noor Pratap Singh, Rob Patro

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* Installing alevin-fry
  + [Installing with bioconda](#installing-with-bioconda)
  + [Installing from source](#installing-from-source)