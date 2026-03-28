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

# Uninstalling HEASoft

The HEASoft configuration is based on the GNU model and does not have a built-in uninstall mechanism. The installed files, created during the "hmake install" step of the build, are co-located with the source code by default. In order to uninstall HEASoft from a computer, the heasoft directory may simply be removed.

`rm -rf /path/to/heasoft-6.36`

## Prefix option

When configuring HEASoft, one of the possible options is "--prefix". This places the installed files, which are created during the "hmake install" step of the build, in a location specified by the user. This may be in a separate location from the source code.

`cd /path/to/heasoft-6.36/BUILD_DIR
./configure --prefix=/software/heasoft-6.36`

In this case, the installed directory should also be removed.

`rm -rf /path/to/heasoft-6.36
rm -rf /software/heasoft-6.36`

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
* Last Updated: 30-Sep-2025

A service of the
[Astrophysics Science Division](https://science.gsfc.nasa.gov/astrophysics)
at [NASA/GSFC](https://www.nasa.gov/goddard/)