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

# Installing HEASoft on Linux

This page includes instructions for installing [Source Code](#source) or [Pre-Compiled Binary](#binary) distributions.

See also the [video walkthrough](install-heasoft-mac-tutorial.html) describing the installation process. The video was created using a Mac, but many of the steps are the same.

## A. SOURCE CODE INSTALLATION

We have historically recommended installations from the source code over the
pre-compiled binaries due to portability issues, but are now offerring pre-compiled
installations via the conda (or mamba) package manager. Please see our
[conda](/docs/software/conda.html) page for more information.

Installations from the source code distribution (or
[conda](/docs/software/conda.html))
are required for users who wish to load local models in Xspec or use the Xspec
Python interface (PyXspec).

The instructions below assume that you have already [downloaded a HEASoft source code tar file](download.html) and have unpacked it (using e.g. tar zxf [tar file]) on your machine.

### A.1. Prerequisites

If they aren't installed already, you will need to install a few system-level packages required for building HEASoft from the source code distribution.

#### A.1.i. System

For [Debian-based](https://en.wikipedia.org/wiki/List_of_Linux_distributions#Debian-based) Linux (e.g. Ubuntu), use the "apt-get" utility:

```
sudo apt-get -y install libreadline-dev
sudo apt-get -y install libncurses5-dev     # or "libncurses-dev"
sudo apt-get -y install ncurses-dev
sudo apt-get -y install curl
sudo apt-get -y install libcurl4
sudo apt-get -y install libcurl4-gnutls-dev
sudo apt-get -y install xorg-dev
sudo apt-get -y install make
sudo apt-get -y install gcc g++ gfortran
sudo apt-get -y install perl-modules
sudo apt-get -y install libdevel-checklib-perl
sudo apt-get -y install libfile-which-perl
sudo apt-get -y install python3-dev         # or "python-dev"
sudo apt-get -y install python3-pip
sudo apt-get -y install python3-setuptools
sudo apt-get -y install python3-astropy     # needed for IXPE
sudo apt-get -y install python3-numpy       # needed for IXPE
sudo apt-get -y install python3-scipy       # needed for IXPE
sudo apt-get -y install python3-matplotlib  # needed for IXPE
sudo pip install --upgrade pip              # NOT needed in Ubuntu 24.04
sudo /usr/bin/python3 -m pip install --upgrade pip
```

Or, in a single copy-and-pastable line (apt-get command only, excludes the pip command):

```
sudo apt-get -y install libreadline-dev libncurses5-dev ncurses-dev curl \
libcurl4 libcurl4-gnutls-dev xorg-dev make gcc g++ gfortran perl-modules \
libdevel-checklib-perl libfile-which-perl python3-dev python3-pip python3-setuptools \
python3-astropy python3-numpy python3-scipy python3-matplotlib
```

For [RPM-based](https://en.wikipedia.org/wiki/List_of_Linux_distributions#RPM-based) Linux (e.g. Fedora), use the "dnf" (formerly "yum") utility:

```
sudo dnf -y install redhat-rpm-config
sudo dnf -y install readline-devel
sudo dnf -y install ncurses-devel
sudo dnf -y install zlib-devel
sudo dnf -y install libcurl-devel
sudo dnf -y install libXt-devel
sudo dnf -y install make
sudo dnf -y install gcc gcc-c++
sudo dnf -y install gcc gcc-gfortran        # or "gcc gcc-fortran"
sudo dnf -y install perl-devel
sudo dnf -y install perl-Devel-CheckLib
sudo dnf -y install perl-DirHandle
sudo dnf -y install perl-Env
sudo dnf -y install perl-ExtUtils-MakeMaker
sudo dnf -y install perl-File-Which
sudo dnf -y install python3-devel           # or "python-devel"
sudo dnf -y install python3-astropy         # needed for IXPE
sudo dnf -y install python3-numpy           # needed for IXPE
sudo dnf -y install python3-matplotlib      # needed for IXPE
sudo pip3 install --only-binary=:all: scipy --upgrade
```

Or, in a single copy-and-pastable line (dnf command only, excludes the pip3 command):

```
sudo dnf -y install redhat-rpm-config readline-devel ncurses-devel \
zlib-devel libcurl-devel libXt-devel make gcc gcc-c++ gcc gcc-gfortran \
perl-devel perl-Devel-CheckLib perl-DirHandle perl-Env perl-ExtUtils-MakeMaker \
perl-File-Which python3-devel python3-astropy python3-numpy python3-matplotlib
```

#### A.1.ii. Python

Some tools and interfaces in HEASoft require Python, such as:

* [HEASoftPy](/docs/software/lheasoft/heasoftpy/)
* [PyXspec](/docs/software/xspec/python/html/index.html)
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

If you prefer to use a different Python environment (Miniconda, etc.), you may choose to install the Python packages (AstroPy, NumPy, SciPy, MatPlotLib) in that environment instead. The following commands install the required Python elements.

In Bourne shell variants (bash/sh/zsh):

```
conda install astropy numpy scipy matplotlib pip
export PYTHON=$HOME/miniconda3/bin/python3
```

In C-shell variants (tcsh/csh):

```
conda install astropy numpy scipy matplotlib pip
setenv PYTHON $HOME/miniconda3/bin/python3
```

Note that the heasoftpy installation uses pip and thus requires access to the internet while building.

#### A.1.iii. Environment Variables

While the configure script in the next step will try its best to find suitable choices, the safest way to ensure that the correct compilers are used by HEASoft is to set the standard environment variables:

* CC (C compiler)
* CXX (C++ compiler)
* FC (Fortran compiler)
* PERL (Perl interpreter)
* PYTHON (Python interpreter)

In Bourne shell variants (bash/sh/zsh):

```
export CC=/usr/bin/gcc
export CXX=/usr/bin/g++
export FC=/usr/bin/gfortran
export PERL=/usr/bin/perl
export PYTHON=/usr/bin/python3
```

In C-shell variants (tcsh/csh):

```
setenv CC /usr/bin/gcc
setenv CXX /usr/bin/g++
setenv FC /usr/bin/gfortran
setenv PERL /usr/bin/perl
setenv PYTHON /usr/bin/python3
```

If these variables are not used, the HEASoft configure script will
attempt to find the necessary items in one of the system directories
listed in your PATH environment variable, but success is not guaranteed.

External packages (e.g. Miniconda) may set compiler or other flags in the environment which can negatively impact a HEASoft build, so users are advised to unset all \*FLAGS and conda alias variables.

In Bourne shell variants (bash/sh/zsh):

```
unset CFLAGS CXXFLAGS FFLAGS LDFLAGS build_alias host_alias
export PATH="/usr/bin:$PATH"
```

In C-shell variants (tcsh/csh):

```
unsetenv *FLAGS build_alias host_alias
setenv PATH="/usr/bin:$PATH"
```

Alternatively, users may alter their session to cancel any Miniconda or other package initialization by editing their profile or other shell resource files (.bashrc, .cshrc, etc.).

Other software packages (e.g. XMM-SAS) may change the LD\_LIBRARY\_PATH environment variable, and this can break a HEASoft build, so users are advised to check their LD\_LIBRARY\_PATH variable and remove any paths that aren't necessary. Typically none should be needed and this variable can remain empty when building HEASoft unless you are using a custom compiler suite for the build. More information about using other software packages such as CIAO and XMM-SAS can be found on the [HEASoft known issues page](issues.html).

### A.2. Configure

Before configuring HEASoft, you should commit to the location of the installed software prior to running the configure script. Once you have built the software, library paths are hard-coded into the executables and they will not function correctly if relocated. The default location of the installed executables are in an architecture-dependent directory underneath the top HEASoft directory. To specify another location for the installed files, use the --prefix option of the configure script.

To see more configure options, run:

`./configure --help`

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

In these commands, /path/to/your/installed is a placeholder for the actual directory path on your system identifying the location in which you installed heasoft. By default, the installed location will be in the source code tree directly under the top level heasoft-6.36 folder, and (PLATFORM) is a placeholder for the platform-specific string denoting your machine's architect