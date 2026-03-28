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

# Applying The 6.35.2 Patch To Your Existing 6.35[.1] Installation

See the [HEASOFT 6.35.2 Release Notes](RelNotes_6.35.2.html)
for more information about this patch.

* For users of the **source code installation:**

  A patch installer script is available to aid you in updating your existing
  6.35 **source code installation**. To use it, simply
  [download the script,](https://heasarc.gsfc.nasa.gov/FTP/software/lheasoft/lheasoft6.35/updates/hdpatch_6.35.2)
  save it in the directory **containing** your existing heasoft-6.35[.1]
  source code folder, initialize HEASOFT, and then run it:

  ```
    sh hdpatch_6.35.2
  ```

  This script will retrieve the necessary patch file (requires **wget**),
  then rebuild and re-install all relevant components. Note that any
  components not included in your original download will be ignored.
  It may take a while to finish, so please be patient while it runs.

* For users of a **pre-compiled binary installation:**

  Choose the appropriate tar file from the list below and unpack it
  **under** your existing heasoft-6.35[.1] binary folder.

  [PC - Ubuntu Linux](https://heasarc.gsfc.nasa.gov/FTP/software/lheasoft/lheasoft6.35/updates/heasoft-6.35.2_ubuntu_patch.tar.gz)

  [PC - Fedora Linux](https://heasarc.gsfc.nasa.gov/FTP/software/lheasoft/lheasoft6.35/updates/heasoft-6.35.2_fedora_patch.tar.gz)

  [PC - Red Hat Enterprise Linux](https://heasarc.gsfc.nasa.gov/FTP/software/lheasoft/lheasoft6.35/updates/heasoft-6.35.2_rhel_patch.tar.gz)

If successful, the task **fversion** should report **v6.35.2**,
**nicerversion** should report **2025-06-11\_V014**,
**Xspec** should report **v12.15.0d** and the task **extractor**
should report **v6.19**.

If you have any questions about the information above, please write to
us at the [FTOOLS help desk](/cgi-bin/ftoolshelp).

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
* Last Updated: 25-Jun-2025

A service of the
[Astrophysics Science Division](https://science.gsfc.nasa.gov/astrophysics)
at [NASA/GSFC](https://www.nasa.gov/goddard/)