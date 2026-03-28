# [BEDOPS v2.4.41](../index.html%20)

* ←
  [1. Overview](overview.html "Previous document")
* [3. Revision history](revision-history.html "Next document")
  →

* [Home](../index.html)

# 2. Installation[¶](#installation "Permalink to this headline")

BEDOPS is available to users as [pre-built binaries](#installation-via-packages) and [source code](#installation-via-source-code).

## 2.1. Via pre-built packages[¶](#via-pre-built-packages "Permalink to this headline")

Pre-built binaries offer the easiest and fastest installation option for users of BEDOPS. At this time, we offer binaries for 64-bit versions of Linux and OS X (Intel) platforms. 32-bit binaries can be built via source code by adjusting compile-time variables.

### 2.1.1. Linux[¶](#linux "Permalink to this headline")

1. Download the current 64-bit package for Linux from [Github BEDOPS Releases](https://github.com/bedops/bedops/releases).
2. Extract the package to a location of your choice. In the case of 64-bit Linux:

   ```
   $ tar jxvf bedops_linux_x86_64-vx.y.z.tar.bz2
   ```

   Replace `x`, `y` and `z` with the version number of BEDOPS you have downloaded.
3. Copy the extracted binaries to a location of your choice which is in your environment’s `PATH`, *e.g.* `/usr/local/bin`:

   ```
   $ cp bin/* /usr/local/bin
   ```

   Change this destination folder, as needed.

### 2.1.2. Mac OS X[¶](#mac-os-x "Permalink to this headline")

1. Download the current Mac OS X package for BEDOPS from [Github BEDOPS Releases](https://github.com/bedops/bedops/releases).
2. Locate the installer package (usually located in `~/Downloads` – this will depend on your web browser configuration):

   ![../_images/bedops_macosx_installer_icon.png](../_images/bedops_macosx_installer_icon.png)
3. Double-click to open the installer package. It will look something like this:

   [![../_images/bedops_macosx_installer_screen_v2.png](../_images/bedops_macosx_installer_screen_v2.png)](../_images/bedops_macosx_installer_screen_v2.png)
4. Follow the instructions to install BEDOPS and library dependencies to your Mac. (If you are upgrading from a previous version, components will be overwritten or removed, as needed.)

## 2.2. Via source code[¶](#via-source-code "Permalink to this headline")

### 2.2.1. Linux[¶](#installation-via-source-code-on-linux "Permalink to this headline")

Compilation of BEDOPS on Linux requires GCC 4.8.2 (both `gcc` and `g++` and related components) or greater, which includes support for [C++11](http://en.wikipedia.org/wiki/C%2B%2B11) features required by core BEDOPS tools. Other tools may be required as described in the installation documentation that follows.

1. If you do not have GCC 4.8.2 or greater installed (both `gcc` and `g++`), first install these tools. You can check the state of your GCC installation with `gcc --version` and `g++ --version`, *e.g.*:

   ```
   $ gcc --version
   gcc (GCC) 4.8.2 20140120 (Red Hat 4.8.2-15)
   ...
   ```

   If you lack a compiler or have a compiler that is older than 4.8.2, use your favorite package manager to install or upgrade the newer package. For example, in Ubuntu, you might run the following:

   ```
   $ sudo apt-get install gcc-4.8
   $ sudo apt-get install g++-4.8
   $ sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 50
   $ sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.8 50
   ```

   Alternatively, in a Fedora, CentOS- or RH-like environment:

   ```
   $ sudo yum update
   $ sudo yum install "Development Tools"
   $ sudo yum install gcc-c++
   ```

   You may also need to install static libraries. In a Fedora/CentOS/RH-like environment:

   ```
   $ sudo yum install libstdc++-static
   $ sudo yum install glibc-static
   ```

   In Ubuntu, you might instead do:

   ```
   $ sudo apt-get install libc6-dev
   $ sudo apt-get install build-essentials
   ```

   The specifics of this process will depend on your distribution and what you want to install. Please check with your system administration or support staff if you are unsure what your options are.
2. Install a `git` client of your choice, if you do not already have one installed. Github offers an [installation guide](https://help.github.com/articles/set-up-git#platform-all).

   Alternatively, use `apt-get` or another package manager to install one, *e.g.* in Ubuntu:

   ```
   $ sudo apt-get install git
   ```

   And in CentOS:

   ```
   $ sudo yum install git
   ```
3. Clone the BEDOPS Git repository in an appropriate local directory:

   ```
   $ git clone https://github.com/bedops/bedops.git
   ```
4. Enter the top-level of the local copy of the BEDOPS repository and run `make` to begin the build process:

   ```
   $ cd bedops
   $ make
   ```

   Running `make` on its own will build so-called “typical” BEDOPS binaries, which make assumptions about line length for most usage scenarios.

   Use `make megarow` or `make float128` to build support for longer-length rows, or BED data which requires statistical or measurement operations with [bedmap](reference/statistics/bedmap.html#bedmap) with 128-bit precision floating point support.

   If you want all build types, run `make all`.

Tip

BEDOPS supports parallel builds, which speeds up compilation considerably. If you are compiling on a multicore or multiprocessor workstation, edit the `JPARALLEL` variable in the top-level Makefile, or override it, specifying the number of cores or processors you wish to use to compile.

5. Once the build is complete, install compiled binaries and scripts to a local `bin` directory:

   ```
   $ make install
   ```

   If you ran `make megarow` or `make float128`, instead use `make install_megarow` or `make install_float128`, respectively, to install those binaries.

   If you ran `make all`, use `make install_all` to install all binaries of the three types (typical, megarow, and float128) to the `./bin` directory. You can use the `switch-BEDOPS-binary-type` script to switch symbolic links to one of the three binary types.
6. Copy the extracted binaries to a location of your choice that is in your environment’s `PATH`, *e.g.* `/usr/local/bin`:

   ```
   $ cp bin/* /usr/local/bin
   ```

   Change this destination folder, as needed.

### 2.2.2. Mac OS X[¶](#installation-via-source-code-on-mac-os-x "Permalink to this headline")

In Mac OS X, you have a few options to install BEDOPS via source code: Compile the code manually, or use the Bioconda or Homebrew package manager to manage installation.

Compilation of BEDOPS on Mac OS X requires Clang/LLVM 3.5 or greater, which includes support for [C++11](http://en.wikipedia.org/wiki/C%2B%2B11) features required by core BEDOPS tools. Other tools may be required as described in the installation documentation that follows. GNU GCC is no longer required for compilation on OS X hosts.

#### 2.2.2.1. Manual compilation[¶](#manual-compilation "Permalink to this headline")

1. If you do not have Clang/LLVM 3.5 or greater installed, first do so. You can check this with `clang -v`, *e.g.*:

   ```
   $ clang -v
   Apple LLVM version 8.0.0 (clang-800.0.42.1)
   ...
   ```

   For Mac OS X users, we recommend installing [Apple Xcode](https://developer.apple.com/xcode/) and its Command Line Tools, via the `Preferences > Downloads` option within Xcode. At the time of this writing, Xcode 8.2.1 (8C1002) includes the necessary command-line tools to compile BEDOPS.
2. Install a `git` client of your choice, if you do not already have one installed. Github offers an [installation guide](https://help.github.com/articles/set-up-git#platform-all).
3. Clone the BEDOPS Git repository in an appropriate local directory:

   ```
   $ git clone https://github.com/bedops/bedops.git
   ```
4. Run `make` in the top-level of the local copy of the BEDOPS repository:

   ```
   $ cd bedops
   $ make
   ```

   Running `make` on its own will build so-called “typical” BEDOPS binaries, which make assumptions about line length for most usage scenarios.

   Use `make megarow` or `make float128` to build support for longer-length rows, or BED data which requires statistical or measurement operations with [bedmap](reference/statistics/bedmap.html#bedmap) with 128-bit precision floating point support.

   If you want all build types, run `make all`.

Tip

BEDOPS supports parallel builds, which speeds up compilation considerably. If you are compiling on a multicore or multiprocessor workstation, edit the `JPARALLEL` variable in the top-level Makefile, or override it, specifying the number of cores or processors you wish to use to compile.

5. Once the build is complete, install compiled binaries and scripts to a local `bin` folder:

   ```
   $ make install
   ```

   If you ran `make megarow` or `make float128`, instead use `make install_megarow` or `make install_float128`, respectively, to install those binaries.

   If you ran `make all`, use `make install_all` to install all binaries of the three types (typical, megarow, and float128) to the `./bin` directory.

   You can use the `switch-BEDOPS-binary-type` script to switch symbolic links to one of the three binary types.
6. Copy the extracted binaries to a location of your choice that is in your environment’s `PATH`, *e.g.* `/usr/local/bin`:

   ```
   $ cp bin/* /usr/local/bin
   ```

   Change this destination folder, as needed.

#### 2.2.2.2. Installation via Bioconda[¶](#installation-via-bioconda "Permalink to this headline")

Bioconda is a bioinformatics resource that extends the Conda package manager with scientific software packages, including BEDOPS. We aim to keep the recipe concurrent with the present release; occasionally, it may be a minor version behind.

What follows are steps taken from the [Bioconda installation page](https://bioconda.github.io/). Use this guide for the most current set of instructions, which we briefly cover here:

1. Follow the instructions on [Conda’s website](http://conda.pydata.org/miniconda.html) to install the Miniconda package, which installs the `conda` command-line tool.
2. If you have not already done so, add the Conda channels that Bioconda depends upon:

   ```
   $ (conda config --add channels r)
   $ conda config --add channels defaults
   $ conda config --add channels conda-forge
   $ conda config --add channels bioconda
   ```
3. Install the BEDOPS package:

   ```
   $ conda install bedops
   ```

[Other recipes](https://bioconda.github.io/recipes.html#recipes) are available for installation, as well.

#### 2.2.2.3. Installation via Homebrew[¶](#installation-via-homebrew "Permalink to this headline")

Homebrew is a popular package management toolkit for Mac OS X. It facilitates easy installation of common scientific and other packages. Homebrew can usually offer a version of BEDOPS concurrent with the present release; occasionally, it may be one or two minor versions behind.

1. If you do not have Clang/LLVM 3.5 or greater installed, first do so. You can check this with `clang -v`, *e.g.*:

   ```
   $ clang -v
   Apple LLVM version 8.0.0 (clang-800.0.42.1)
   ...
   ```

   For Mac OS X users, we recommend installing [Apple Xcode](https://developer.apple.com/xcode/) and its Command Line Tools, via the `Preferences > Downloads` option within Xcode. At the time of this writing, Xcode 8.2.1 (8C1002) includes the necessary command-line tools to compile BEDOPS.
2. Follow the instructions listed on the [Homebrew site](http://brew.sh) to install the basic package manager components.
3. Run the following command:

   ```
   $ brew install bedops
   ```

### 2.2.3. Docker[¶](#docker "Permalink to this headline")

[Docker](https://www.docker.com/what-docker) containers wrap up a piece of software (such as BEDOPS) in a complete, self-contained VM.

To set up a CentOS 7-based Docker container with BEDOPS binaries, you can use the following steps:

> ```
> $ git clone https://github.com/bedops/bedops.git
> $ cd bedops
> $ make docker
> ...
> $ docker run -i -t bedops
> ```

The following then generates a set of RPMs using the CentOS 7 image, which can run in CentOS 6 and Fedora 21 containers:

> ```
> $ make rpm
> ```

Thanks go to Leo Comitale for his efforts here.

### 2.2.4. Cygwin[¶](#cygwin "Permalink to this headline")

1. Make sure you are running a 64-bit version of Cygwin. Compilation of BEDOPS on 32-bit versions of Cygwin is not supported.

   To be sure, open up your Cywin installer application (separate from the Cygwin terminal application) and look for the **64 bit** marker next to the setup application version number:

   [![../_images/bedops_cygwin_installer_screen.png](../_images/bedops_cygwin_installer_screen.png)](../_images/bedops_cygwin_installer_screen.png)

   For instance, this Cygwin installer is version 2.831 and is 64-bit.
2. Check that you have GCC 4.8.2 or greater installed. You can check this by opening the Cygwin terminal window (note that this is not the same as the Cygwin installer application) and typing `gcc --version`, *e.g.*:

   ```
   $ gcc --version
   gcc (GCC) 4.8.2
   ...
   ```

   If you do not have `gcc` installed, then open the Cygwin (64-bit) installer application again, navigate through the current setup options, and then mark the GCC 4.8.\* packages for installation:

   [![../_images/bedops_cygwin_installer_gcc_screen.png](../_images/bedops_cygwin_installer_gcc_screen.png)](../_images/bedops_cygwin_installer_gcc_screen.png)

   If it helps, type in `gcc` into the search field to filter results to GCC-related packages. Make sure to mark the following packages for installation, at least:

   * **gcc-core**
   * **gcc-debuginfo**
   * **gcc-g++**
   * **gcc-tools-xyz**
   * **libgcc1**

   Click “Next” to follow directives to install those and any other selected package items. Then run `gcc --version` as before, to ensure you have a working GCC setup.
3. Install a `git` client of your choice. You can compile one or use the precompiled `git` package available through the Cygwin (64-bit) installer:

   [![../_images/bedops_cygwin_installer_git_screen.png](../_images/bedops_cygwin_installer_git_screen.png)](../_images/bedops_cygwin_installer_git_screen.png)

   If it helps, type in `git` into the search field to filter results to Git-related packages. Make sure to install the following package, at least:

   * **git**
4. In a Cygwin terminal window, clone the BEDOPS Git repository to an appropriate local directory:

   ```
   $ git clone https://github.com/bedops/bedops.git
   ```

4. Enter the top-level of the local copy of the BEDOPS repository and run `make` to begin the build process:

   ```
   $ cd bedops
   $ make
   ```

Tip

BEDOPS now supports parallel builds. If you are compiling on a multicore or multiprocessor workstation, use `make -j N` where `N` is `2`, `4` or however many cores or processors you have, in order to parallelize and speed up the build process.

5. Once the build is complete, install compiled binaries and scripts to a local `bin` folder:

   ```
  