### Navigation

* [index](../genindex.html "General Index")
* [next](examples.html "A few examples") |
* [previous](index.html "The khmer user documentation") |
* [khmer 3.0.0a1+98.gfe0ce11 documentation](../index.html) »
* [The khmer user documentation](index.html) »

## Contents

* Installing and running khmer
  + [Build requirements](#build-requirements)
  + [Prerequisites](#prerequisites)
    - [OS X](#os-x)
    - [Linux](#linux)
  + [Create a virtual environment](#create-a-virtual-environment)
    - [Anaconda Python](#anaconda-python)
    - [System/Homebrew Python](#system-homebrew-python)
  + [Installing khmer](#installing-khmer)

#### Previous topic

[The khmer user documentation](index.html "previous chapter")

#### Next topic

[A few examples](examples.html "next chapter")

### This Page

* [Show Source](../_sources/user/install.rst.txt)

1. [Docs](../index.html)
2. [The khmer user documentation](index.html)
3. Installing and running khmer

# Installing and running khmer[¶](#installing-and-running-khmer "Permalink to this headline")

## Build requirements[¶](#build-requirements "Permalink to this headline")

You’ll need a 64-bit operating system, internet access, a C++11 compatible compiler (e.g. GCC 4.8 or greater), GNU Make, and Python version 3.3 or greater.

Note

The khmer package is no longer compatible with Python 2!

Note

If you are running khmer in a HPC environment or for other reasons do not have administrative privileges, we strongly suggest installing khmer in a virtual environment.
See the relevant instructions below.

## Prerequisites[¶](#prerequisites "Permalink to this headline")

### OS X[¶](#os-x "Permalink to this headline")

1. Start by installing the Xcode command line tools if they are not already installed.

   > xcode-select –install
2. If it’s not already installed, install Python version 3 using [Homebrew](http://brew.sh/) or Anaconda <https://www.anaconda.com/download/>.

### Linux[¶](#linux "Permalink to this headline")

1. Use your Linux distribution’s package manager to install Python 3 and essential build tools such as `Make` and `g++`.

   * On recent versions of Debian and Ubuntu this can be done with:

     ```
     sudo apt-get install python3-dev python3-venv build-essential
     ```
   * For recent versions of Red Hat, Fedora, and CentOS you can invoke:

     ```
     sudo yum install -y python3-devel gcc-c++ make
     ```

## Create a virtual environment[¶](#create-a-virtual-environment "Permalink to this headline")

### Anaconda Python[¶](#anaconda-python "Permalink to this headline")

If you are using the Anaconda Python distribution:

```
conda create --name khmerEnv python=3.6
source activate khmerEnv
```

The first command *creates* the virtual environment in a dedicated location in your home directory and only needs to be invoked once.
The second command *activates* the environment and must be invoked every time you begin a new terminal session.
The *activate* command can be invoked from any directory in your system.

### System/Homebrew Python[¶](#system-homebrew-python "Permalink to this headline")

If you are using the system or Homebrew Python distribution:

```
python3 -m venv khmerEnv
source khmerEnv/bin/activate
```

The first command *creates* the virtual environment in your current directory and only needs to be invoked once.
The second command *activates* the environment and must be invoked every time you begin a new terminal session.
The *activate* command will only work if you provide the correct relative or absolute path of the *activate* file.

## Installing khmer[¶](#installing-khmer "Permalink to this headline")

Once the virtual environment is created and activated, you can use pip to install khmer and its dependencies.

> pip install khmer

Please enable JavaScript to view the [comments powered by Disqus.](http://disqus.com/?ref_noscript)
[comments powered by Disqus](http://disqus.com)

[The khmer user documentation](index.html "previous chapter (use the left arrow)")

[A few examples](examples.html "next chapter (use the right arrow)")

### Navigation

* [index](../genindex.html "General Index")
* [next](examples.html "A few examples") |
* [previous](index.html "The khmer user documentation") |
* [khmer 3.0.0a1+98.gfe0ce11 documentation](../index.html) »
* [The khmer user documentation](index.html) »

© Copyright 2010-2014 the authors.. Created using [Sphinx](http://sphinx.pocoo.org/).