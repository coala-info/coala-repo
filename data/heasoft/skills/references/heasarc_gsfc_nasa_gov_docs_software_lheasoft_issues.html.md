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

# HEASoft v6.36 - Known Issues

If you are using HEASoft v6.35[.x] and don't want to upgrade to v6.36 just yet,
see the [HEASoft 6.35.2 Issues List](/ftools/ftools_bugs6.35.2.html).

### Several packages track issues separately from this page:

* [NICER](/docs/nicer/analysis_threads/common-errors/)
* [Swift](/docs/swift/analysis/bugs/index.html)
* [CALDB](/ftools/caldb/caltools_problems.html)
* [XSPEC](/docs/software/xspec/issues/issues.html)
* [XSTAR](/docs/software/xstar/xstar.html)
* [HEASP](/docs/software/lheasoft/headas/heasp/heasp_bugs.html)
* [XIMAGE](/docs/software/ximage/ximagebugs.html)
* [XRONOS](/docs/software/xronos/xronosbugs.html)

### The following is a list of known issues in HEASoft not covered by the above pages.

---

Last modified Tuesday, 10-Feb-2026 11:33:06 EST

---

* **numetrology**:

  The NuSTARDAS task **numetrology** may fail when built with the
  default Apple C compiler (clang) - e.g., while running
  **nupipeline** - with an error

  ```
  nupipeline_0.4.9: Error: running 'numetrology'
  ```

  Tests suggest that this error can be resolved by rebuilding numetrology
  with compiler optimization turned off, which may be accomplished in the
  following way: first, initialize heasoft and then edit the file

  ```
  heasoft-6.36/nustar/BUILD_DIR/hmakerc
  ```

  to change COPT (line 88) from **"-O2"** to **""**, then:

  ```
  cd nustar/tasks/numetrology
  hmake clean
  hmake all
  hmake install
  ```
* **SAOImage DS9 on MacOS**:

  [As noted on the SAOImage download page](https://sites.google.com/cfa.harvard.edu/saoimageds9/download), please be aware that the
  DS9 **Aqua** application does not allow for runtime command line
  options, as required by e.g., **xselect**, so we recommend installing
  the **Darwin X11** version of ds9 instead.
* **Xspec on older Macs**:

  Compilation of Xspec may fail under older macOS with the error:

  ```
  'timespec_get' was not declared in this scope
  ```

  Users should be able to get past this by editing lines 47-51 of

  ```
       heasoft-6.36/Xspec/src/XSutil/Utils/TimeUtility.cxx
  ```

  to change this code block:

  ```
       # if defined(__APPLE__)
           timespec_get(&tnow, TIME_UTC);
       #else
           clock_gettime(CLOCK_REALTIME, &tnow);
       #endif
  ```

  to just this:

  ```
       clock_gettime(CLOCK_REALTIME, &tnow);
  ```
* **Ubuntu (22.04) and pip version 22.0.2**:

  When running "make install" on Ubuntu (22.04 only?), users may need to update the default pip version (22.0.2) to avoid errors installing **HEASoftPy**:

  ```
  Building wheels for collected packages: UNKNOWN
  ...
  HEASoftPy not found under heasoft-6.36/heacore/heasoftpy/build
  ```

  To update **pip** to a newer version (e.g., 24.0):

  ```
  sudo pip install --upgrade pip
  ```
* **FV in Virtual Machines**:

  When used on Virtual Desktops (e.g. VirtualBox), FV windows may appear blank. This issue may be mitigated by disabling "3D acceleration" in the display options.
* **IXPE & MatPlotLib**:

  The IXPE task **ixpeplot\_polarization** may fail with a cryptic and
  unhelpful error message when using **MatPlotLib** older than version
  3.7.0. To fix this issue, update to version 3.7.0 (or newer).
* **IXPE & AstroPy**:

  Due to a bug in certain 5.x versions of **AstroPy**, some files
  (such as the IXPE Level 1 event files) containing variable-length
  arrays may trigger in several IXPE tools a "ValueError" with the
  message "the heapsize limit for 'P' format has been reached. Please
  consider using the 'Q' format for your file.", even if the file is
  already formatted with the "Q" format.
  Affected versions of AstroPy appear to be
  **5.0.5, 5.0.6, 5.1.1, 5.2, 5.2.1**, and **5.2.2**,
  so users encountering this issue are advised to update to v5.3.0
  or newer.
* **Mac "Configure failed"**:

  The HEASoft configure script may fail with
  "C compiler cannot create executables",
  "Configure failed in the AST package!", or
  "configure failed for heacore component fftw!",
  and one of the config.logs may show

  ld: library not found for -lSystem

  This error typically implies that third-party compiler suites (e.g.
  Homebrew or MacPorts, needed in order to provide a Fortran compiler)
  are out-of-synch with the Apple (XCode) Command Line Tools (CLT),
  for example if you updated the CLT but did not reinstall MacPorts or
  Homebrew after doing so. Since these third-party compilers use the
  CLT, they must typically be rebuilt/reinstalled whenever XCode/CLT
  are updated.

  For example, some users have worked their way past this by
  [uninstalling
  the CLT](https://mac.install.guide/commandlinetools/6.html) and then
  [reinstalling
  the CLT](https://mac.install.guide/commandlinetools/7.html), then uninstalling and reinstalling the Homebrew compilers.

  Other compiler-related failures during the configure stage
  can typically be resolved by putting **/usr/bin** at the
  front of your **PATH** environment variable (as recommended in
  [our Mac installation guide](macos.html)), e.g. to
  put the Apple assembler and other system utilities ahead of third-party
  versions in order of preference.
* **WSL and Windows PATH variables**:

  Some users of WSL on Windows may have PATH environment variables that
  contain directory paths containing double quotes ("). The HEASoft
  initialization will fail as a result, so users need to modify their
  PATH variable to remove the offending characters.
* **CentOS 7.x compilers**:

  Note for users of **CentOS 7.x**: On CentOS 7, the default GNU
  compiler suite is v4.8, which is not supported for building HEASoft.
  CentOS 7 users may install a newer 'devtoolset' compiler suite for use
  in building HEASoft, in the following way (for example):

  ```
      sudo yum -y install devtoolset-9
      scl enable devtoolset-9 bash

      Locate the devtoolset-9 installed directories:

      gcc -print-search-dirs
      /opt/rh/devtoolset-9/root/usr/lib/gcc/x86_64-redhat-linux/9

      In the next step, set the compiler variables accordingly (for example):

      export CC=/opt/rh/devtoolset-9/root/usr/bin/gcc
      export CXX=/opt/rh/devtoolset-9/root/usr/bin/g++
      export FC= /opt/rh/devtoolset-9/root/usr/bin/gfortran

      You will likely also need to update your LD_LIBRARY_PATH to include
      the path to the libraries needed by these compilers (for example):

      export LD_LIBRARY_PATH=/opt/rh/devtoolset-9/root/usr/lib
  ```
* **Using "sudo" or "screen"**:

  Since configuring HEASoft typically works best when setting environment
  variables to point to specific compilers, using **sudo** at the
  configure stage is not recommended since sudo spawns a new shell that
  does not automatically inherit current environment settings. The sudo
  command should not be needed for configuring in any case; it should
  only be necessary when running "make install", and only then if you
  are writing to a root-protected area (e.g. /usr/local or /Applications).

  Similarly, the **screen** command does not inherit all environment
  variables, so if you spawn a **screen** session before running the
  configure script, be sure to check or set environment variables
  **after** starting the screen utility.
* **"Developer cannot be verified" or "unidentified developer" error on Macs**:

  Some Mac users have reported problems configuring and/or running
  pre-compiled HEASoft binaries. To free HEASoft binaries from
  the Apple quarantine, use the **xattr** utility, e.g.:

  ```
  $ cd heasoft-6.36/x86_64-apple-darwin23.6.0
  $ xattr -r -d com.apple.quarantine BUILD_DIR/configure lib/* bin/*
  ```
* **Fortran compiler requirements**:

  HEASoft now includes a new dependency on the **FGSL** library which
  requires a Fortran 2008 feature (c\_loc for targeted arrays); therefore
  GNU Fortran compilers older than version ~5.x are unsupported.
* **Perl symbol lookup error, "undefined symbol: Perl\_Gthr\_key\_ptr"**:

  If running a HEASoft Perl script generates an error similar to the above,
  it may result from a [**Perl version incompatibility**](perl.html)
  (common when using the pre-compiled binaries), but it may also occur if
  you have the **VERSIONER\_PERL\_PREFER\_32\_BIT** environment variable set
  to "yes". If "echo VERSIONER\_PERL\_PREFER\_32\_BIT" returns "yes", then
  unset it:

  ```
     unset VERSIONER_PERL_PREFER_32_BIT
  ```

  or, in C-shell:

  ```
     unsetenv VERSIONER_PERL_PREFER_32_BIT
  ```
* **MacPorts "unexpected token" linker issue**:

  If you are using MacPorts compilers in your build, 'make' may fail when
  building the HEASoft source code distribution with an error referring to
  a new Xcode linker ("ld") format ("tbd"), e.g.:

  ```
  ld: in '/System/Library/PrivateFrameworks/CoreEmoji.framework/Versions/A/CoreEmoji.tbd', unexpected token: !tapi-tbd-v2 ...
  ```

  The underlying issue is discussed [here](https://trac.macports.org/ticket/49273)
  and [here](https://www.nntp.perl.org/group/perl.perl5.porters/2015/10/msg231811.html);
  it appears that when new versions of the XCode command line tools are released,
  problems such as this may affect MacPorts compilers until they catch up with
  Apple's changes. Users should be able to get around the error in our build by
  installing the MacPorts 'xcode' variant of the linker ld64 as a temporary measure:

  ```
   sudo port install ld64 +ld64_xcode
  ```

  and when MacPorts eventually supports the latest XCode command line tools, you
  can switch back to the latest ld64 with the following:

  ```
   sudo port install ld64 +ld64_latest
  ```
* **Mac "suffix or operands invalid for 'movq'" Fortran compiler issue**:

  When using the gnu.org
  [gfortran binaries](https://gcc.gnu.org/wiki/GFortranBinaries#MacOS)
  note [their recommendation](https://gcc.gnu.org/wiki/GFortranBinariesMacOS)
  that when installing new versions of the compiler you should remove
  the previous gfortran installation first:

  ```
     $ sudo rm -r /usr/local/gfortran /usr/local/bin/gfortran
  ```

  Failure to do so may result in a corrupted compiler installation,
  leading to the "suffix or operands invalid for 'movq'" error.
* **Ubuntu ds9 & HEASoft**:

  After initializing HEASoft on Ubuntu Linux, the **ds9** GUI (if installed) may
  fail to start up (mentioning "can't find package xml", "can't find package uri 1.1", or "package require base64"").
  This results from incompatibilities between the Tcl/Tk included with HEASoft and
  the Ubuntu system libraries. Until a more elegant solution can be devised, we
  recommend that users try one of the following options, depending on the file type
  of your ds9 (shell script or compiled executable - check the output from
  "**file `which ds9`**" to determine which it is):

  ```
  1) If ds9 is the shell script version, edit it to change the line

       exec wish8.6 -f ${DS9_HOME-/usr/share/saods9}/library/ds9.tcl $*

     to

       exec /usr/bin/env -u LD_LIBRARY_PATH /usr/bin/wish8.6 -f ${DS9_HOME-/usr/share/saods9}/library/ds9.tcl $*

  or

  2) If ds9 is the compiled executable version, create a new file
     "$HEADAS/bin/ds9" containing the following lines:

       #!/bin/sh
       exec /usr/bin/env -u LD_LIBRARY_PATH /usr/bin/ds9 "$@"

     (Note this assumes that `which ds9` = /usr/bin/ds9)

     To make the new script executable, run the following command:

       $ chmod +x $HEADAS/bin/ds9

     Then, as long as $HEADAS/bin is ahead of /usr/bin in your PATH, you
     should now be able to successfully run ds9 from the command line:

       $ rehash
       $ ds9
  ```
* **"relocation R\_X86\_64\_32 against `.rodata' can not be used when making a shared object"**:

  Users building HEASoft from the source code distribution may run into this
  error which refers to a "Bad value" in the file heacore/wcslib/C/cel.o, from
  which the linker "could not read symbols". It also suggests that you
  "recompil