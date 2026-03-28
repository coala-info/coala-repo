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

# Download the HEASOFT Software

## Current version [6.36.0 Release Notes](release_notes/RelNotes_6.36.0.html)

## Before downloading:

HEASOFT tasks may now be run remotely using
**[SciServer](/docs/sciserver)**
without having to install the software locally. SciServer provides
a quick way to use the software (along with access to archival data)
and is ideal for users who have limited or infrequent need to run the
HEASOFT tasks. More intensive users of HEASOFT are still encouraged to
install the software locally for best performance, or consider using
**[HEASoft in a Docker container](/lheasoft/docker.html)**.

Starting with HEASoft version 6.35, HEASoft and Xspec are also distributed
as **[conda packages](/docs/software/conda.html)**.
The packages are available from a custom channel hosted by the HEASARC and are built from the same source code available below.

A download containing all of the package selections can be around 5 Gb
in size when unpacked; the actual size will vary depending on the packages
you select and - if you choose a binary distribution - the architecture
selected. If large file sizes present problems for your connection, it
is possible to download the packages you want separately and unpack the
tar files on top of each other afterwards, though you may need to either
rename each tar file with a temporary name during the process or unpack
each file immediately upon downloading so that one tar file isn't
overwritten by the next.

Please use the interface below to make "a la carte" selections for your
source code or pre-compiled binary download. Alternatively, you may
choose the complete HEASoft source code via these direct tar file links,
one of the complete source code, and one which adds
[older Xspec model data files](xspec_modeldata_old.html):

* [Complete HEASoft source code (all mission & general-use software)](/FTP/software/lheasoft/lheasoft6.36/heasoft-6.36src.tar.gz) (4.4 Gb / 7 Gb unpacked);
  [md5 checksum](/FTP/software/lheasoft/lheasoft6.36/heasoft-6.36src.tar.gz.md5)
* [Complete HEASoft source code **plus older Xspec model data unneeded by most users**](/FTP/software/lheasoft/lheasoft6.36/heasoft-6.36src_plus_older_xspec_modeldata.tar.gz) (6 Gb / 13 Gb unpacked);
  [md5 checksum](/FTP/software/lheasoft/lheasoft6.36/heasoft-6.36src_plus_older_xspec_modeldata.tar.gz.md5)

## STEP 1 - Select the type of software:

### SOURCE CODE DISTRIBUTION (**Recommended**)

Please note that the source code distribution or our
**[pre-compiled conda packages](/docs/software/conda.html)**
are recommended due to portability issues that can affect the traditional
pre-compiled binaries below. A source code distribution or a
**[pre-compiled conda package](/docs/software/conda.html)**
is **required** for users who wish to use **local models in XSPEC / PyXspec**.

**Source Code**

**For project statistics purposes only:**
Although the source code is intended to be portable to most
PCs (Linux or WSL) or Macs,
to help us better serve our users, please indicate
the platform(s) on which you intend to try to compile the HEAsoft source code.
If you are uncertain about the version or flavor of your operating system,
see the file "/etc/issue" on Linux or use the *sw\_vers* command on
Macs. Please note that not all of the systems listed below are actively
supported. We have tried to note systems below that are known to be
unsupported or only partially supported.

|  |  |
| --- | --- |
| [ ]  PC - Linux - Arch | [ ]  Mac Silicon - Darwin 25.x (macOS 16.x) |
| [ ]  PC - Linux - Bluewhite64 | [ ]  Mac Intel - Darwin 25.x (macOS 16.x) |
| [ ]  PC - Linux - CentOS | [ ]  Mac Silicon - Darwin 24.x (macOS 15.x) |
| [ ]  PC - Linux - Debian | [ ]  Mac Intel - Darwin 24.x (macOS 15.x) |
| [ ]  PC - Linux - Fedora | [ ]  Mac Silicon - Darwin 23.x (macOS 14.x) |
| [ ]  PC - Linux - Gentoo | [ ]  Mac Intel - Darwin 23.x (macOS 14.x) |
| [ ]  PC - Linux - Mageia | [ ]  Mac Silicon - Darwin 22.x (macOS 13.x) |
| [ ]  PC - Linux - Mandriva | [ ]  Mac Intel - Darwin 22.x (macOS 13.x) |
| [ ]  PC - Linux - Manjaro | [ ]  Mac Silicon - Darwin 21.x (macOS 12.x) |
| [ ]  PC - Linux - MEPIS | [ ]  Mac Intel - Darwin 21.x (macOS 12.x) |
| [ ]  PC - Linux - Mint | [ ]  Mac Silicon - Darwin 20.x (macOS 11.x) |
| [ ]  PC - Linux - openSUSE | [ ]  Mac Intel - Darwin 20.x (macOS 11.x) |
| [ ]  PC - Linux - Oracle | [ ]  Mac Intel - Darwin 19.x (macOS 10.15.x) |
| [ ]  PC - Linux - PCLinuxOS | [ ]  Mac Intel - Darwin 18.x (macOS 10.14.x) |
| [ ]  PC - Linux - Red Hat | [ ]  Mac Intel - Darwin 17.x (macOS 10.13.x) |
| [ ]  PC - Linux - Rocky | [ ]  Mac Intel - Darwin 16.x (macOS 10.12.x) |
| [ ]  PC - Linux - Scientific |
| [ ]  PC - Linux - Slackware |
| [ ]  PC - Linux - Solus |
| [ ]  PC - Linux - Turbo |
| [ ]  PC - Linux - Vine |
| [ ]  PC - Linux - Ubuntu |  |
| [ ]  PC - Linux - Xandros |  |
| [ ]  PC - Microsoft Windows WSL (Windows Subsystem For Linux) |
| [ ]  PC - Cygwin [**no longer supported**] |
| [ ]  PC - Microsoft Windows [**only partially supported with CMake**] |
| [ ]  PC - OpenSolaris |
| [ ]  BSD (Free/Net/Open) |
| [ ]  Sparc - Solaris/SunOS |
| |  | | --- | | [ ]  Other.... Please specify: | |

### PRE-COMPILED BINARY DISTRIBUTIONS (**May experience portability issues**):

Please note that the source code distribution above or our
**[pre-compiled conda packages](/docs/software/conda.html)**
are recommended due to [Perl](perl.html) (and other) portability issues
that can affect the traditional pre-compiled binaries offered here.
Additionally, a source code distribution or a
**[pre-compiled conda package](/docs/software/conda.html)**
is **required** for users who wish to use **local models in XSPEC / PyXspec**.
Note that the pre-compiled **[conda packages](/docs/software/conda.html)**
are installable on both **Silicon** and **Intel** Macs unlike the binaries offered here. Lastly, please note that we plan to discontinue providing these traditional pre-compiled binaries following the release of HEASoft 6.36.

|  |  |
| --- | --- |
| **PC - Ubuntu Linux 22.04** | **Mac INTEL (macOS 14 Sonoma, or newer)** |
| **PC - Fedora Linux 42** |
| **PC - Red Hat Enterprise Linux 8.10** |

## STEP 2 - Download the desired packages:

Selecting an individual mission package will
automatically select a set of recommended general-use tools.

|  |  |  |  |  |
| --- | --- | --- | --- | --- |
|  | Mission-Specific Tools | | | |
|  | [ ]  [ASCA](/docs/software/ftools/asca.html) | [ ]  [BurstCube](help/burstcube.html) | [ ]  [CALET](help/calet.html) | [ ]  [Einstein](/docs/software/ftools/einstein.html) | [ ]  [EXOSAT](/docs/software/ftools/exosat.html) | [ ]  [CGRO](/docs/software/ftools/gro.html) | [ ]  [HEAO-1](/docs/software/ftools/heao1.html) | [ ]  [Hitomi](help/hitomi.html) | [ ]  [INTEGRAL](help/integral.html) | [ ]  [IXPE](help/ixpe.html) |
|  | [ ]  [MAXI](help/maxi.html) | [ ]  [NICER](help/nicer.html) | [ ]  [NuSTAR](help/nustar.html) | [ ]  [OSO-8](/docs/software/ftools/oso8.html) | [ ]  [ROSAT](/docs/software/ftools/rosat.html) | [ ]  [Suzaku](help/suzaku.html) | [ ]  [Swift](help/swift.html) | [ ]  [Vela](/docs/software/ftools/vela5b.html) | [ ]  [XRISM](help/xrism.html) | [ ]  [XTE](/docs/software/ftools/xte.html) |  |  |
|  | [General-Use FTOOLS](/docs/software/ftools/ftools_subpacks.html) | | | |
|  | [ ]  [Attitude](help/attitude_pkg.html) | [ ]  [Caltools](/docs/software/ftools/caldb/caltools.html) | [ ]  [Futils](/docs/software/ftools/futils.html) | [ ]  [Fimage](/docs/software/ftools/fimage.html) | [ ]  [HEASARC](/docs/software/ftools/heasarc.html) | [ ]  [HEASim](help/heasim.html) | [ ]  [HEASPtools](help/heasptools.html) |
|  | [ ]  [HEATools](help/heatools.html) | [ ]  [HEAGen](help/heagen.html) | [ ]  [FV](/docs/software/ftools/fv/fv.html) | [ ]  [Time](/docs/software/ftools/time.html) |  |
| [ ] | [Ximage](/docs/software/ximage/ximage.html) | | | |
| [ ] | [Xronos](/docs/software/xronos/xronos.html) | | | |
| [ ] | [Xspec \*](/docs/software/xspec/index.html) | | | |
| [ ] | [Xstar](/docs/software/xstar/xstar.html) | | | |
|  | | | | |

**Please click SUBMIT only once, and be patient while a tar file containing your selections is assembled and retrieved.**

### \* Xspec Notes

HEASOFT 6.36 includes
[Xspec v12.15.1](/docs/software/xspec/index.html).
Please see the [Xspec issues web page](/docs/software/xspec/issues/issues.html)
to apply the latest patches **after** building Xspec (source code
distribution required).

Older Xspec model data ([file list here](xspec_modeldata_old.html)) is available in a separate tar file:

[Older Xspec model data](/FTP/software/lheasoft/lheasoft6.36/xspec-older-model-data.tar.gz) (1.7Gb / 6.6Gb unpacked)

After installing and initializing HEASoft, unpack this tar file in the directory above $HEADAS:

```
$ cd $HEADAS/..
$ tar zxf xspec-older-model-data.tar.gz
```

Users who wish to link **Xspec models** into their own program are advised to
download the Xspec source code distribution and configure heasoft using the option "--enable-xs-models-only".

## STEP 3 - Install the software:

* Visit the [known issues page](issues.html) for notifications
  about any problems (and relevant patches) identified after HEAsoft 6.36
  was released.
* Un-gzip and un-tar the file created for you (either
  *heasoft-6.36**src**.tar.gz* or
  *heasoft-6.36**<platform>**.tar.gz* depending on which type of
  distribution you selected) in a clean directory and follow the instructions
  in our installation guides for the following platforms:

  + [PC Linux](linux.html)
  + [macOS](macos.html)
* See our recommendations for [batch processing and good scripting practices](scripting.html)
  when writing your own scripts to run HEASoft tasks.

  * Optional: download and run the [hwrap script](hwrap.html)
    to create an alternate runtime environment for HEASOFT to help avoid
    conflicts with other software packages (e.g. XMM-SAS or CIAO).

Return to top

* [HEASARC](/docs/)
* [Observatories](/docs/observatories.html)
* [Archive](/docs/archive.html)
* [Calibration](/docs/heasarc/caldb/caldb_intro.html)
* [Software](/docs/software.html)
* [Web Tools](/docs/tools.html)
* [Help & Support](/cgi-bin/Feedback)

![NASA logo](/docs/images/nasa-logo.svg)

* [About NASA](https://www.nasa.gov/about/)
* [Accessibility](https://www.nasa.gov/accessibility/)
* [FOIA](https://www.nasa.gov/foia/)

* [No FEAR Act](https://www.nasa.gov/odeo/no-fear-act/)
* [Privacy Policy](https://www.nasa.gov/privacy/)
* [Vulnerability Disclosure Policy](https://www.nasa.gov/vulnerability-disclosure-policy/)

* Responsible Official: Ryan Smallcomb
* Site Editor: Kristen Killingsworth
* Last Updated: 20-Jan-2026

A service of the
[Astrophysics Science Division](https://science.gsfc.nasa.gov/astrophysics)
at [NASA/GSFC](https://www.nasa.gov/goddard/)