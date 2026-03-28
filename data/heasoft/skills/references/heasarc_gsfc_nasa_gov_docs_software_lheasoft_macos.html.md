[Skip to main content](#main-content)

[![NASA Logo, National Aeronautics and Space Administration](/docs/images/nasa-logo.svg)](https://www.nasa.gov)

###### [NASA |](https://www.nasa.gov/) [GSFC |](https://www.nasa.gov/goddard/) [Sciences and Exploration](https://science.gsfc.nasa.gov/)

###### [HEASARC](/)

###### [High Energy Astrophysics Science Archive Research Center](/)

Menu

![Close](/assets/uswds/img/usa-icons/close.svg)

* HEASARC
  + [About](/docs/HHP_heasarc_info.html)
  + [Help Desk](/cgi-bin/Feedback)
  + [Upcoming Meetings](/docs/heasarc/meetings.html)
  + [Archive Your Data](/docs/heasarc/heasarc_req.html)
  + [Archive Statistics](/docs/heasarc/stats/stats.html)
  + [LAMBDA Portal](https://lambda.gsfc.nasa.gov)
* Observatories
  + [Observatories](/docs/observatories.html)
  + [Active Missions](/docs/heasarc/missions/active.html)
  + [Past Missions](/docs/heasarc/missions/past.html)
  + [Upcoming Missions](/docs/heasarc/missions/upcoming.html)
  + [Comparison](/docs/heasarc/missions/comparison.html)
* Archive
  + [Archive](/docs/archive.html)
  + [Search Portal](/xamin/)
  + [Search APIs](/docs/archive/apis.html)
  + [Cloud](/docs/archive/cloud.html)
  + [SciServer](/docs/sciserver/)
  + [FTP Area](/FTP/)
* Calibration
  + [Calibration](/docs/heasarc/caldb/caldb_intro.html)
  + [Remote Access](/docs/heasarc/caldb/caldb_remote_access.html)
  + [Documentation](/docs/heasarc/caldb/caldb_doc.html)
  + [Keywords](/docs/heasarc/caldb/caldb_keywords.html)
  + [Cross Calibration](/docs/heasarc/caldb/caldb_xcal.html)
  + [Supported Missions](/docs/heasarc/caldb/caldb_supported_missions.html)
* Software
  + [Software](/docs/software/index.html)
  + [HEASoft](/docs/software/lheasoft/)
  + [FITSIO](/docs/software/fitsio/fitsio.html)
  + [Xspec](/docs/software/xspec/index.html)
  + [Xronos](/docs/software/xronos/xronos.html)
  + [Ximage](/docs/software/ximage/ximage.html)
  + [XSTAR](/docs/software/xstar/xstar.html)
* Web Tools
  + [Web Tools](/docs/tools.html)
  + [WebPIMMS](/cgi-bin/Tools/w3pimms/w3pimms.pl)
  + [WebSpec](/webspec/webspec.html)
  + [Viewing Tool](/cgi-bin/Tools/viewing/viewing.pl)
  + [nH Calculator](/cgi-bin/Tools/w3nh/w3nh.pl)
  + [Coordinates Converter](/cgi-bin/Tools/convcoord/convcoord.pl)
  + [Time Converter](/cgi-bin/Tools/xTime/xTime.pl)
  + [SkyView](https://skyview.gsfc.nasa.gov/)
* Help & Support
  + [Help Desk](/cgi-bin/Feedback)
  + [Proposal Submission](/RPS)
  + [Bibliography](/docs/heasarc/biblio/pubs/)
  + [Resources for Scientists](/docs/heasarc/resources.html)
  + [FAQ](/docs/faq.html)
  + [Outreach](/docs/outreach.html)

* [About](/docs/HHP_heasarc_info.html)
* [Sitemap](/docs/sitemap.html)
* [Help Desk](/cgi-bin/Feedback)
* [Archive Your Data](/docs/heasarc/heasarc_req.html)

Search

![Search](/assets/uswds/img/usa-icons-bg/search--white.svg)

[Come analyze HEASARC, IRSA, and MAST data in the cloud!](https://science.nasa.gov/astrophysics/programs/physics-of-the-cosmos/community/the-fornax-initiative/#beta-release)
The Fornax Initiative is now welcoming all interested beta users.

# Installing HEASoft on a Mac

This page includes instructions for installing [Source Code](#source) or [Pre-Compiled Binary](#binary) distributions.

See also the [video walkthrough](install-heasoft-mac-tutorial.html) describing the installation process.

## A. SOURCE CODE INSTALLATION

We have historically recommended installations from the source code over the
pre-compiled binaries due to portability issues, but are now offerring pre-compiled
installations via the conda (or mamba) package manager. Please see our
[conda](/docs/software/conda.html) page for more information.

Installations from the source code distribution (or
[conda](/docs/software/conda.html))
are required for users who wish to load local models in Xspec or use the Xspec
Python interface (PyXspec).

The default build mode of HEASoft on Silicon Macs is the native arm64 architecture. Previous HEASoft releases required use of the Rosetta binary translation utility on Apple Silicon hardware, but this restriction was lifted starting with HEASoft 6.31. The default build mode on an Intel Mac is the x86 architecture.

The instructions below assume that you have already [downloaded a HEASoft source code tar file](download.html) and have unpacked it (using e.g. tar zxf [tar file]) on your machine.

### A.1. Prerequisites

If they aren't installed already, you will need to install a few system-level packages required for building HEASoft from the source code distribution.

#### A.1.i. System

##### X11

[X11](https://xquartz.macosforge.org/) is required. We recommend [XQuartz](https://xquartz.macosforge.org/) but X11 is also available via the various Mac package managers.

##### Compilers: C, C++, Perl, Fortran

We recommend using the Apple XCode C compilers (/usr/bin/clang,clang++,perl).

Apple XCode

For best performance, we recommend using the native Apple C and Perl compilers provided by the [XCode](https://developer.apple.com/xcode/) Command Line Tools (CLT) (/usr/bin/clang, /usr/bin/clang++, /usr/bin/perl). Note that having out-of-date CLT can result in malfunctions in third-party software (such as the Fortran compiler). Ensure that they are up-to-date with your OS by running:

`xcode-select --install`

A Fortran compiler

A Fortran compiler is not provided by XCode but can
be installed using any of the various Mac package managers.
[MacPorts](https://www.macports.org) and
[Homebrew](https://brew.sh)
are the ones used and tested most at the
HEASARC and are therefore recommended above other options.
Note also that when updating your Mac OS or XCode version, it
is typically necessary to reinstall any third-party packages
for compatibility with the new system.

For example, install gfortran from the MacPorts gcc14 package
(after installing MacPorts itself):

```
sudo port install gcc14
```

This provides /opt/local/bin/gfortran-mp-14

Or, install gfortran from the Homebrew gcc@14 package
(after installing Homebrew itself):

```
brew install gcc@14
```

This provides /usr/local/bin/gfortran-14 (on an Intel Mac) or /opt/homebrew/bin/gfortran-14 (on a Silicon Mac).

##### PNG

If you'd like to use the PNG driver in PGPLOT (the plotting package in HEASoft used by fplot and others), you may also want to install the "libpng" package :

```
sudo port install libpng
```

or

```
brew install libpng
```

When configuring heasoft, you may then also need to use this configure
option, otherwise the PNG driver in PGPLOT will not be activated:

```
./configure --with-png=/opt/local
```

or

```
./configure --with-png=/opt/homebrew
```

#### A.1.ii. Python

Some tools and interfaces in HEASoft require Python, such as:

* [HEASoftPy](/docs/software/lheasoft/heasoftpy/)
* [PyXspec](/docs/software/lheasoft/software/xspec/python/html/index.html)
* [HEASP](/docs/software/lheasoft/headas/heasp/)
* [IXPE](/docs/software/lheasoft/help/ixpe.html)
* [NICER](/docs/nicer/index.html)

If you have no need of any of these HEASoft packages and did not include them in your download, you may forgo installing the Python prerequisites.

HEASoftPy and other packages require Python elements:

* Python 3.6 (or newer)
* pip
* AstroPy (v4.0.0 or newer)
* NumPy (v1.7.0 or newer)
* SciPy (v1.5.0 or newer)
* MatPlotLib

Users who prefer MacPorts may install the Python packages using the following:

```
sudo port install python312 py312-astropy py312-numpy py312-scipy py312-matplotlib py312-pip
```

Users who prefer a different Python environment (Miniconda, etc.) may choose to install the Python packages in that environment instead. The following commands install the required Python elements.

```
conda install astropy numpy scipy matplotlib pip
```

Note that the HEASoftPy installation uses pip and thus requires access to the internet while building.

#### A.1.iii. Environment Variables

While the configure script in the next step will try its best to find suitable choices, the safest way to ensure that the correct compilers are used by HEASoft is to set the standard environment variables:

* CC (C compiler)
* CXX (C++ compiler)
* PERL (Perl interpreter)
* FC (Fortran compiler)
* PYTHON (Python interpreter).

Replace these paths to the appropriate locations on your machine.

In Bourne shell variants (bash/sh/zsh):

```
export CC=/usr/bin/clang
export CXX=/usr/bin/clang++
export PERL=/usr/bin/perl
export FC=/opt/homebrew/bin/gfortran-14
export PYTHON=$HOME/miniconda3/bin/python3
```

In C-shell variants (tcsh/csh):

```
setenv CC /usr/bin/clang
setenv CXX /usr/bin/clang++
setenv PERL /usr/bin/perl
setenv FC /opt/homebrew/bin/gfortran-14
setenv PYTHON $HOME/miniconda3/bin/python3
```

If these variables are not used, the HEASoft configure script will
attempt to find the necessary items in one of the system directories
listed in your PATH environment variable, but success is not guaranteed.

External packages (e.g. Miniconda) may set compiler or other flags in the environment which can negatively impact a HEASoft build, so users are advised to unset all \*FLAGS variables. Additionally, Mac users are advised to put the XCode /usr/bin at the front of their PATH (i.e. ahead of any third-party packages that may have inserted themselves into the PATH)

In Bourne shell variants (bash/sh/zsh):

```
unset CFLAGS CXXFLAGS FFLAGS LDFLAGS build_alias host_alias
export PATH="/usr/bin:$PATH"
```

In C-shell variants (tcsh/csh):

```
unsetenv *FLAGS build_alias host_alias
setenv PATH "/usr/bin:$PATH"
```

Alternatively, users may alter their session to cancel any Miniconda or other package initialization by editing their profile or other shell resource files (.bashrc, .cshrc, etc.).

Other software packages (e.g. XMM-SAS) may change the DYLD\_LIBRARY\_PATH environment variable, and this can break a HEASoft build, so users are advised to check their DYLD\_LIBRARY\_PATH variable and remove any paths that aren't necessary. Typically none should be needed and this variable can remain empty when building HEASoft unless you are using a custom compiler suite for the build. More information about using other software packages such as CIAO and XMM-SAS can be found on the [HEASoft known issues page](issues.html).

### A.2. Configure

Before configuring HEASoft, you should commit to the location of the installed software prior to running the configure script. Once you have built the software, library paths are hard-coded into the executables and they will not function correctly if relocated. The default location of the installed executables are in an architecture-dependent directory underneath the top HEASoft directory. To specify another location for the installed files, use the --prefix option of the configure script.

To see more configure options, run:

```
./configure --help
```

Also note that the compiler settings described above will NOT pass to a sudo shell, so if you want to install HEASoft in a protected location (such as /usr/local), you should configure and build the software WITHOUT using sudo in a location writeable by you (e.g. your home directory), and use sudo only when performing the final make install step below.

After the prerequisite packages have been installed and the appropriate environment variables have been set, configure the software. While optional, it is a good idea for future troubleshooting to capture the screen output to text files as shown here.

In Bourne shell variants (bash/sh/zsh):

```
cd heasoft-6.36/BUILD_DIR/
./configure > config.txt 2>&1
```

In C-shell variants (tcsh/csh):

```
cd heasoft-6.36/BUILD_DIR/
./configure >& config.txt
```

The configure process may take several minutes to complete. If it is successful, the last line of output (in config.txt) should read "Finished". If it is not successful, do not proceed until any errors have been resolved. Check the [HEASoft known issues page](issues.html) for troubleshooting, or contact the [help desk](/cgi-bin/ftoolshelp).

### A.3. Build

If and only if the configure was successful, proceed to build the software.
Again, optionally capturing the screen output to a text file for
reference may be useful for future troubleshooting.

In Bourne shell variants (bash/sh/zsh):

```
make > build.txt 2>&1
```

In C-shell variants (tcsh/csh):

```
make >& build.txt
```

This process may take an hour or more to run, depending on your
hardware and HEASoft download selections. If it is successful, the
last line of output (in build.txt) should read "Finished make all".
If it is not successful, do not proceed until any errors
have been resolved. Check the [HEASoft known issues page](issues.html)
for troubleshooting, or contact the [help desk](/cgi-bin/ftoolshelp).

If the build (or the install in the next step) failed and
you find it necessary to change the configuration (e.g., by
switching compilers), you should run
make clean
to remove any compiled objects (\*.o, libraries, executables)
from the failed attempt, then re-run the configure script
before restarting make.

### A.4. Install

If 'make' was successful, proceed to install the software.
Again, optionally capturing the screen output to a text file for
reference may be useful for future troubleshooting.

In Bourne shell variants (bash/sh/zsh):

```
make install > install.txt 2>&1
```

In C-shell variants (tcsh/csh):

```
make install >& install.txt
```

This process may take 30-45 minutes to run, depending on your
hardware and HEASoft download selections. If it is successful, the
last line of output (in install.txt) should read "Finished make install".
If it is not successful, do not proceed until any errors
have been resolved. Check the [HEASoft known issues page](issues.html)
for troubleshooting, or contact the [help desk](/cgi-bin/ftoolshelp).

### A.5. Initialize

If the make install step was successful, you may proceed with
initializing the software. The following are example commands
which you will modify to be appropriate for your system:

In Bourne shell variants (bash/sh/zsh):

```
export HEADAS=/path/to/your/installed/heasoft-6.36/(PLATFORM)
source $HEADAS/headas-init.sh
```

In C-shell variants (tcsh/csh):

```
setenv HEADAS /path/to/your/installed/heasoft-6.36/(PLATFORM)
source $HEADAS/headas-init.csh
```

In these commands, /path/to/your/installed is a placeholder for the actual directory path on your system identifying the location in which you installed heasoft. By default, the installed location will be in the source code tree directly under the top level heasoft-6.36 folder, and (PLATFORM) is a placeholder for the platform-specific string denoting your machine's architecture, for example: x86\_64-apple-darwin21.6.0.

The initialization is silent and only generates a message if
there is an error. If it is successful, you may begin using
the software. For example, type fthelp ftools to see a full
listing of possible tools, or type xspec to start the Xspec
spectral analysis program.

## B. PRE-COMPILED BINARY INSTALLATION

Installations of the traditi