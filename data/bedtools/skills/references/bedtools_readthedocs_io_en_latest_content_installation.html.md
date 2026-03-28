### Navigation

* [index](../genindex.html "General Index")
* [next](quick-start.html "Quick start") |
* [previous](overview.html "Overview") |
* [bedtools v2.31.0](../index.html) »

# Installation[¶](#installation "Permalink to this headline")

`bedtools` is intended to run in a “command line” environment on UNIX, LINUX
and Apple OS X operating systems. Installing `bedtools` involves either
downloading the source code and compiling it manually, or installing stable
release from package managers such as
[homebrew (for OS X)](http://mxcl.github.com/homebrew/).

## Installing stable releases[¶](#installing-stable-releases "Permalink to this headline")

### Downloading a pre-compiled binary[¶](#downloading-a-pre-compiled-binary "Permalink to this headline")

Note

1. The following approach will only work for Linux (non-OSX) systems.

Starting with release 2.28.0, we provide statically-linked binaries thast should work
right away on Linux systems. Go to the [releases](https://github.com/arq5x/bedtools2/releases)
page and look for the static binary named bedtools.static.binary. Right click on it, get the URL, then download it
with wget or curl and you should be good to go.

As an example. First, download bedtools.static.binary from the latest release [here](https://github.com/arq5x/bedtools2/releases)

```
mv bedtools.static.binary bedtools
chmod a+x bedtools
```

### Compiling from source via Github[¶](#compiling-from-source-via-github "Permalink to this headline")

Stable, versioned releases of bedtools are made available on Github at the
[bedtools2 repository](https://github.com/arq5x/bedtools2/) under
the [releases](https://github.com/arq5x/bedtools2/releases) tab.
The following commands will install `bedtools` in a local directory on an UNIX or OS X machine.

Note

1. The bedtools Makefiles utilize the GCC compiler. One should edit the
Makefiles accordingly if one wants to use a different compiler.

```
$ wget https://github.com/arq5x/bedtools2/releases/download/v2.29.1/bedtools-2.29.1.tar.gz
$ tar -zxvf bedtools-2.29.1.tar.gz
$ cd bedtools2
$ make
```

At this point, one should copy the binaries in ./bin/ to either
`usr/local/bin/` or some other repository for commonly used UNIX tools in
your environment. You will typically require administrator (e.g. “root” or
“sudo”) privileges to copy to `usr/local/bin/`. If in doubt, contact you
system administrator for help.

### Installing with package managers[¶](#installing-with-package-managers "Permalink to this headline")

In addition, stable releases of `bedtools` are also available through package
managers such as [homebrew (for OS X)](http://mxcl.github.com/homebrew/),
`apt-get` and `yum`.

**Fedora/Centos**. Adam Huffman has created a Red Hat package for bedtools so
that one can easily install the latest release using “yum”, the Fedora
package manager. It should work with Fedora 13, 14 and EPEL5/6 (
for Centos, Scientific Linux, etc.).

```
yum install BEDTools
```

**Debian/Ubuntu.** Charles Plessy also maintains a Debian package for bedtools
that is likely to be found in its derivatives like Ubuntu. Many thanks to
Charles for doing this.

```
apt-get install bedtools
```

**Homebrew**. Carlos Borroto has made BEDTools available on the bedtools
package manager for OSX.

```
brew tap homebrew/science
brew install bedtools
```

**MacPorts**. Alternatively, the MacPorts ports system can be used to install BEDTools on OSX.

```
port install bedtools
```

## Development versions[¶](#development-versions "Permalink to this headline")

The development version of bedtools is maintained in a Github
[repository](https://www.github.com/arq5x/bedtools2). Bug fixes are addressed
in this repository prior to release, so there may be situations where you will
want to use a development version of bedtools prior to its being promoted to
a stable release. One would either clone the repository with `git`, as
follows and then compile the source code as describe above:

```
git clone https://github.com/arq5x/bedtools2.git
```

or, one can download the source code as a `.zip` file using the Github
website. Once the zip file is downloaded and uncompressed with the `unzip`
command, one can compile and install using the instructions above.

> ![../_images/github-zip-button.png](../_images/github-zip-button.png)

Please enable JavaScript to view the [comments powered by Disqus.](http://disqus.com/?ref_noscript)
[comments powered by Disqus](http://disqus.com)

[![Logo](../_static/bedtools.swiss.png)](../index.html)

### [Table of Contents](../index.html)

* Installation
  + [Installing stable releases](#installing-stable-releases)
    - [Downloading a pre-compiled binary](#downloading-a-pre-compiled-binary)
    - [Compiling from source via Github](#compiling-from-source-via-github)
    - [Installing with package managers](#installing-with-package-managers)
  + [Development versions](#development-versions)

#### Previous topic

[Overview](overview.html "previous chapter")

#### Next topic

[Quick start](quick-start.html "next chapter")

### This Page

* [Show Source](../_sources/content/installation.rst.txt)

### Quick search

### Navigation

* [index](../genindex.html "General Index")
* [next](quick-start.html "Quick start") |
* [previous](overview.html "Overview") |
* [bedtools v2.31.0](../index.html) »

© Copyright 2009 - 2023, Aaron R. Quinlan.
Last updated on May 29, 2023.