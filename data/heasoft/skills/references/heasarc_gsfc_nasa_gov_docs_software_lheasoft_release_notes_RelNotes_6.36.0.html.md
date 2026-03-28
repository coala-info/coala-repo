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

[Download HEASoft](/docs/software/lheasoft/download.html)

```
********************************************************************************
                       RELEASE NOTES FOR HEASOFT 6.36
                              September 26, 2025
********************************************************************************

The HEASoft 6.36 release is driven by new and updated mission-specific
data analysis software (XRISM, IXPE, MAXI, BurstCube, et al.), but as
usual includes other enhancements and fixes.

Configuration-related changes throughout the package mean that users
who already have HEASoft installed will need to completely replace
their software installation; there is no clean way to simply overlay
this new release or to update an existing installation.

Please note that in favor of distributing pre-built HEASoft installations
via the conda package manager, we plan to discontinue distributing our
traditional pre-compiled binary downloads after the 6.36 release.

********************************************************************************
                                    CFITSIO
********************************************************************************

Version 4.6.3:

 - For greater C23 compatibility, updated cfortran.h file and
   removed old-style function declarations.

 - Cleanup of multiple compiler warnings.

 - Updated 'speed' utility to use higher precision total time.

 - Fixes for FreeBSD and OpenBSD build issues.

 - Added RPM support file cfitsio.spec, and packaging helper file
   ax_cfitsio.m4.

 - Added files portfile.cmake and vcpkg.json.

 - Fixed possible memory leaks in certain error exit conditions.

 - Fix to minor truncation error in ffgthd.

********************************************************************************
                                     HEASP
********************************************************************************

pha:

  Added += and -= operator overloads to add/subtract a number or vector
  of numbers to/from the spectrum.  Added add and subtract methods to
  add and substract pha with control over whether operation is in counts
  or rate and how the exposure, background scaling, and area scaling are
  handled.  Added multiply and divide methods to multiply and divide pha
  with control over whether operation is in counts or rate and how the
  exposur eis handled.

rmf:

  Corrected the use of the I and J format when writing an output file.
  They were used the wrong way round leading to problems when there were
  more than 32768 channels.

SPio:

  Added SPwriteHistoryKeywords and SPwriteCommentKeywords to write history
  and comment keywords to the specified filename and extension.

********************************************************************************
                                   ATTITUDE
********************************************************************************

- prefilter: Updated GEOMAG library for IGRF version 14 (2020- data
  affected); Fixed XTE-style orbit interpolation: previously it could
  leave strange extra samples if tabulated orbit samples were > 120 sec
  but < 240 sec apart

********************************************************************************
                                   CALTOOLS
********************************************************************************

- caldbinfo: Fixed nicaldbver INDEF issue

********************************************************************************
                                    HEAGEN
********************************************************************************

- barycen: Updated to use JPL DE440 ephemeris when the reference frame
  is ICRS.  Fixed bug that blocked application of ICRS frame.  XRISM
  added to list of valid missions

- barycorr: Added support for NICER FPM_SEL and filter files with
  extraneous time samples

- burstt90t50: Improved detection of file+ext; added statistics for
  higher chatter; burst T90 T50 interval method adjustments, adds
  two parameters ('usenegative' and 'uselast') to increase
  flexibility in how to select the points from the light curve that
  are included in the calculation

- hpextract: (NEW) HEALPixel event combiner tool

- xrtraytrace: Additional updates to fix and enable remote CalDB
  usage with xrtraytrace and xaarfgen ("timeout" interval extended
  for reading large CalDB files).

********************************************************************************
                                    HEASARC
********************************************************************************

- extractor:

  When writing output files Changed the checking of keyword matches when
  deleting duplicates so that a match is defined by having the same keyword
  even if values differ. A warning message will be written if there are
  multiple instances of the same keyword with different values.

  Trapped a potential seg fault if there are no valid GTIs.

********************************************************************************
                                   HEASPTOOLS
********************************************************************************

- ftaddspec: (NEW) Tool intended to replace addspec and addascaspec;
  adds spectrum files and, optionally, associated files

- ftmathpha: (NEW) Tool intended to replace mathpha; performs
  mathematical operations on spectrum files

- ftmarfrmf: If warnings are generated when reading the rmf, these
  are written out and the tool now conditions instead of failing.

********************************************************************************
                                    XSELECT
********************************************************************************

- Replaced spaces by underscores in the session name.  If the current
  directory path includes spaces, generate a warning.

********************************************************************************
                                     XSPEC
********************************************************************************

Xspec version 12.15.1

New models

- fekblor, bfekblor, zbfekblor: four Lorentzian high-resolution model
  for the Fe Kbeta line.

- rsapec, rsvapec, rsvvapec: apec models with line broadening and
  resonance scattering out of the beam.

- rsgauss: a gaussian model with a resonance scattering
  optical depth parameter - mainly for testing purposes.

- rsrnei, rsvrnei, rsvvrnei:
  versions of the rnei model with resonance scattering out of the beam.

Modifications to models

- In the NEI models, the eigenvector file which is used to calculate
  ion fractions can be changed using xset APECEIGENFILE. (Note that
  NEIAPECROOT and NEIVERS now do the same thing and the former is
  preferred).

- Updated xilconv to use version of 5 of the xillver file and added
  option to set the version number.

- Added option to set model data directory in the Xspec.init file
  with e.g. MDATADIR: /my/directory/path

- Use the Xspec.init information to set APECROOT, SPEXROOT, and
  NEIAPECROOT.

- Simplified the general code to calculate line shapes to avoid
  some occasional problems - now no longer uses the input crtLevel
  or the xset LINECRITLEVEL value.

Other

- Added tclout xset name option to get the values of any model
  strings set by xset.

- Clarified questions asked by fakeit command.

- Replaced the use of cfortran.h with modern f90 to link C and Fortran.
  This may require changes in local models written in Fortran to
  add "use xsfortran" and/or "use xsfortfuncwrappers".

- Added Planck's constant and the classical electron radius (in cgs)
  to Numerics.h - required to calculate resonant scattering.
  Modified BinarySearch.cxx so that the input y array does not have
  to be in ascending order (although the routine will run faster if
  it is).

- New "latest" option for the Xspec.init settings for ATOMDB_VERSION,
  SPEX_VERSION, NEI_VERSION. Setting these to "latest" ensures Xspec
  will select the most recent atomdb files.

Fixes

- All fixes that were included with patch releases 12.5.0a-f

- An array access error in the "ismdust" model.

- NaNs appearing for a corner-case of background subtraction.

PyXspec

- New method Xset.getModelString() to return the value of a particular
  key string stored in XSPEC's internal model string database.

********************************************************************************
                                     XSTAR
********************************************************************************

- Changes to fix bug that affected multi-pass runs

********************************************************************************
                                   BURSTCUBE
********************************************************************************

New tasks for BurstCube (v1.0):

- bcfindloc: Calculate the BURSTCUBE likelihood source position from
  multiple detectors simulated rate and create a localization map

- bcoccult: Calculate a full-sky map to show the sky occulted by the
  earth within a time interval

- bcprod: Create light curves and spectra for a given burst from time
  dependent spectral array data and GTI

- bcrebevt: Rebin event data by time and channels to output a time
  dependent spectral array file or prepare time-dependent spectral
  array file for subsequent analysis and plot the results

- bctimebst: Calculate a light curve and determine a burst time
  interval based upon Bayesian block analysis

- bcversion: Report version string for BURSTCUBE package

********************************************************************************
                                     IXPE
********************************************************************************

Changes to the IXPE Python Tools:

- ixpeaspcorr:

  Implemented bounded fitting with scipy.optimize_curve_fit() for
  finding the centroid of an image peak using a Gaussian model.
  This largely eliminates bad fits.

  Changed the time binning to be more deterministic and avoid a bug
  in which several valid data points were being dropped from the
  final position analysis.

  Increased the reporting of interim aspect correction fits, and
  removed a bug which masked differences in solutions between the
  two optical heads of the star tracker.

- ixpecalcarf:

  "weight" parameter changed to default to "1" or NEFF weighting,
  which matches the help file documentation.

- ixpeexpmap:

  Changed definition of "GrayBadFlag" values so they do not overlap
  any of the "BadFlag" values.  These have not yet been used in any
  IXPE produced data, so there should be no noticeable effect.

- ixpemkxspec:

  It was found that the outputs this tool produces are compatible
  with xspec, but not with pyxspec.  Additional output files were
  added that are specifically formatted to work with pyxspec.  The
  documentation was updated to describe the both outputs and naming
  conventions.

- ixpepolarization:

  Removed an annoyance bug in which the default values for the
  polarization output file would be "-.fits".  The new default is
  "ixpepolarization_out.fits".  The documentation was updated to
  describe the outputs more clearly.

- ixpeproduct (NEW):

  This is the initial release of this tool for preparing event data
  for analysis with xspec (or pyxspec).  It produces spectrum files,
  light curve files, polarization files, ixpemkxspec output files,
  and optionally produces pointing map files from an IXPE observation
  data set.

********************************************************************************
                                     MAXI
********************************************************************************

New tasks:

- mxauxlist: Make an FITS list files for ISS attitude, solar panel
  angles, and GSC housekeeping files

- mxevtfilter: Separate event files by voltages, source and background
  regions