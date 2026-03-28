[![NASA Logo, National Aeronautics and Space Administration](/Images/portal_new/nasa_header_logo1.gif)](https://www.nasa.gov)

# [National Aeronautics and Space Administration](https://www.nasa.gov)

## [Goddard Space Flight Center](https://www.nasa.gov/goddard/)

### [Sciences and Exploration](https://science.gsfc.nasa.gov/)

### Search:

[[Advanced Search]](/cgi-bin/search/search.pl)

[HEASARC Quick Links](/docs/corp/goto_text.html)

---Quick Links---
---Archive Interfaces---
Argus: proposal info
Browse: search HEASARC archives
NVO DataScope
SkyView: virtual observatory
Xamin: powerful archive search
---Software & Tools---
CalDB: Calibration database
Coordinate Converter
Energy Converter
FITS: standard data format
FITSIO: FITS subroutine library
FTOOLS: general s/w for FITS files
fv: FITS file editor
HEXTErock
nH: Column Density
RPS proposal submission
RXTE ASM weather map
Time/Date Converter (xTime)
Timeline (RXTE, Swift, & HETE-2)
Viewing: possible obs. times
WebPIMMS: flux/count converter
WebSpec: spectral sims
Xanadu: data analysis suite
X-ray Background Tool
X-ray, Gamma-ray, EUV Source Finder
---Resources---
Bibliography
Contact Info
Deadlines (proposals & meeting regist.)
History of High-Energy Astronomy
Staff
Upcoming Meetings
Upcoming Summer Schools
What's New
---Education & Pub. Outreach---
APOD: Astronomy Picture of the Day
Ask an Astrophysicist
HEASARC Picture of the Week
Images, Spectra, Light Curves
Imagine the Universe!
StarChild (K-8 EPO)
WebStars: gen. astronomy info/news

[Skip Navigation (press 2)](#skipping "Skip Navigation")

* [HEASARC Home](/)
* [Observatories](/docs/observatories.html)
* [Archive](/docs/archive.html)
* [Calibration](/docs/heasarc/caldb/caldb_intro.html)
* [Software](/docs/software.html)
* [Tools](/docs/tools.html)
* [Students/Teachers/Public](/docs/outreach.html)

[![HEASARC: Software](/Images/portal_new/swbanner_new4.png)](/docs/software.html)

* [FITSIO](/docs/software/fitsio/fitsio.html)
* [FTOOLS](/docs/software/ftools/ftools_menu.html)
* [FV](/docs/software/ftools/fv/)
* [HEASoft](/docs/software/lheasoft/)
* [Maki](/docs/astroe/prop_tools/maki.html)
* [PIMMS](/docs/software/tools/pimms.html)
* [PROFIT](/docs/software/profit/)
* [Xanadu](/docs/xanadu/xanadu.html)
* [Xselect](/docs/software/lheasoft/ftools/xselect/xselect.html)
* [XSTAR](/docs/software/xstar/xstar.html)
* [ASTRO-Update](/docs/heasarc/astro-update/)
* [FITS](/docs/heasarc/fits.html)

|  |
| --- |
| [![next](next.png)](node1.html) ![up](up_g.png) ![previous](prev_g.png) [![contents](contents.png)](node1.html)    **Next:** [Contents](node1.html)    **[Contents](node1.html)**  **HEASP Guide**  Version 2.8  Keith A. Arnaud  HEASARC   Code 662   Goddard Space Flight Center   Greenbelt, MD 20771   USA  March 2025  ---     * [Contents](node1.html)* [Introduction](node2.html)* [Python module](node3.html)       + [Getting startedin](node4.html)+ [HEASP features not (yet) supported in Python](node5.html)+ [Spectrum example](node6.html)+ [Response example](node7.html)+ [Ancillary response file example](node8.html)+ [Table model example](node9.html)+ [Table model for spectropolarimetry example](node10.html)+ [An example combining heasp and pyxspec](node11.html) * [C++ classes and methods](node12.html)         + [Global defines](node13.html)+ [Spectra](node14.html)             - [Introduction and example](node15.html)- [pha class private members](node16.html)- [pha class public methods](node17.html)- [Public pha methods to get and set internal data](node18.html)- [Other pha routines](node19.html)- [phaII class private members](node20.html)- [phaII class public methods](node21.html)- [Public phaII methods to get and set internal data](node22.html)+ [Responses](node23.html)               - [Introduction and examples](node24.html)- [rmf class private members](node25.html)- [rmf class public methods](node26.html)- [Other rmf routines](node27.html)- [rmft class private members](node28.html)- [rmft class public methods](node29.html)- [Public rmft methods to get and set internal data](node30.html)- [arf class private members](node31.html)- [arf class public methods](node32.html)- [Public arf methods to get and set internal data](node33.html)- [Other arf routines](node34.html)- [arfII class private members](node35.html)- [arfII class public methods](node36.html)- [Public arfII methods to get and set internal data](node37.html)- [Other arfII routines](node38.html)+ [Table Models](node39.html)                 - [Introduction and example](node40.html)- [table class private members](node41.html)- [table class public methods](node42.html)- [Public table methods to get and set internal data](node43.html)- [tableParameter class private members](node44.html)- [tableParameter class public methods](node45.html)- [Public tableParameter methods to get and set internal data](node46.html)- [tableSpectrum class private members](node47.html)- [tableSpectrum class public methods](node48.html)- [Public tableSpectrum methods to get and set internal data](node49.html)+ [Grouping](node50.html)                   - [grouping class private members](node51.html)- [grouping class public methods](node52.html)- [Public grouping methods to get and set internal data](node53.html)- [Other grouping routines](node54.html)+ [Utility routines](node55.html)+ [I/O routines](node56.html) * [C interface](node57.html)           + [PHA files](node58.html)             - [PHA structure](node59.html)- [PHA routines](node60.html)+ [RMF files](node61.html)               - [RMF structure](node62.html)- [RMF routines](node63.html)+ [ARF files](node64.html)                 - [ARF structure](node65.html)- [ARF routines](node66.html)+ [Binning and utility](node67.html)                   - [BinFactors structure](node68.html)- [Binning and utility routines](node69.html) * [Building programs using heasp](node70.html)* [Ftools and Heasp](node71.html)* [Error Codes](node72.html)* [Change log](node73.html)                   + [v2.8](node74.html)                     - [General](node75.html)- [arf](node76.html)- [pha](node77.html)- [phaII](node78.html)- [grouping](node79.html)- [rmf](node80.html)+ [v2.7](node81.html)                       - [General](node82.html)- [grouping](node83.html)- [pha](node84.html)- [rmf](node85.html)+ [v2.6](node86.html)                         - [arf](node87.html)- [pha](node88.html)- [rmf](node89.html)+ [v2.5](node90.html)                           - [General](node91.html)- [arf](node92.html)- [pha](node93.html)- [rmf](node94.html)+ [v2.4](node95.html)                             - [General](node96.html)- [grouping](node97.html)- [pha](node98.html)- [rmf](node99.html)- [table](node100.html)+ [v2.3](node101.html)                               - [General](node102.html)- [grouping](node103.html)- [pha](node104.html)- [rmf](node105.html)- [table](node106.html)+ [v2.2](node107.html)                                 - [General](node108.html)- [arf](node109.html)- [grouping](node110.html)- [pha](node111.html)- [rmf](node112.html)- [table](node113.html)+ [v2.1](node114.html)                                   - [General](node115.html)- [arf](node116.html)- [arfII](node117.html)- [grouping](node118.html)- [pha](node119.html)- [rmf](node120.html)- [table](node121.html)+ [v2.00](node122.html)                                     - [General](node123.html)- [rmf](node124.html)- [grouping](node125.html)+ [v1.20](node126.html)                                       - [General](node127.html)- [pha, phaII](node128.html)- [rmf](node129.html)- [table](node130.html)- [grouping](node131.html)+ [v1.10](node132.html)                                         - [General](node133.html)- [pha, phaII](node134.html)- [rmf](node135.html)- [arf and arfII](node136.html)- [table](node137.html)- [grouping](node138.html)+ [v1.03](node139.html)                                           - [General](node140.html)- [rmf](node141.html)+ [v1.02](node142.html)                                             - [General](node143.html)- [pha, phaII](node144.html)- [rmf](node145.html)- [arf](node146.html)+ [v1.01](node147.html)                                               - [General](node148.html)- [pha, phaII](node149.html)- [rmf](node150.html)- [table](node151.html) * [About this document ...](node152.html)     ---    ---  [HEASARC Home](/) | [Observatories](/docs/observatories.html) | [Archive](/docs/archive.html) | [Calibration](/docs/heasarc/caldb/caldb_intro.html) | [Software](/docs/software.html) | [Tools](/docs/tools.html) | [Students/Teachers/Public](/docs/outreach.html) ---  Last modified: Friday, 14-Mar-2025 15:41:22 EDT |

|  |
| --- |
| A service of the [Astrophysics Science Division](https://science.gsfc.nasa.gov/astrophysics) at [NASA/](http://www.nasa.gov/)[GSFC](http://www.nasa.gov/goddard). |

[![NASA Logo, National Aeronautics and Space Administration](/Images/portal_new/nasa_header_logo1.gif)](http://www.nasa.gov)

[![Goddard Space Flight Center Signature Logo](/Images/portal_new/goddardsignature2.png)](http://www.nasa.gov/goddard/)

* HEASARC Director: Vacant
* NASA Official: Ryan Smallcomb
* Web Curator: J.D. Myers
* Last Modified: 14-Mar-2025

* [NASA Astrophysics](http://science.nasa.gov/astrophysics/)
* [FAQ/Comments/Feedback](/docs/faq.html)
* [Education Resources](/docs/outreach.html)
* [Find helper applications like Adobe Acrobat](/docs/plugins.html)
* [Privacy Policy & Important Notices](http://www.nasa.gov/about/highlights/HP_Privacy.html)