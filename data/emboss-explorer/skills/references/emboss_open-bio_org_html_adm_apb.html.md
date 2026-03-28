| Appendix B. EMBOSS Frequently Asked Questions | | |
| --- | --- | --- |
| [Prev](apas01.html) |  |  |

---

## Appendix B. EMBOSS Frequently Asked Questions

EMBOSS maintains a list of frequently asked questions (FAQs) with answers in the file `FAQ` in the EMBOSS distribution, e.g.

|  |
| --- |
| `/auser/emboss/emboss/FAQ` |

The FAQ is given below and organised as follows:

[Q & A B.1, “General”](apb.html#FAQGeneral "General")
:   General EMBOSS issues, licensing, availability etc or any areas not covered by other FAQs.

[Q & A B.2, “Getting Started”](apb.html#FAQGettingStarted "Getting Started")
:   Hardware and software requirements, downloading etc.

[Q & A B.3, “Administration (installation and compilation)”](apb.html#FAQAdministrationInstall "Administration (installation and compilation)")
:   Installation and compilation.

[Q & A B.4, “Databases”](apb.html#FAQDatabases "Databases")
:   Databases configuration.

[Q & A B.5, “Administration (other)”](apb.html#FAQAdministrationOther "Administration (other)")
:   Post-installation setup and other administration issues not covered elsewhere.

[Q & A B.6, “Features”](apb.html#FAQFeatures "Features")
:   EMBOSS key features for biologist end-users, how to request features etc,

[Q & A B.7, “Sequence Files and Formats”](apb.html#FAQSequenceFiles "Sequence Files and Formats")
:   Hardware and software requirements, downloading, installing and compiling, post-compilation setup etc.

[Q & A B.8, “Help and Support”](apb.html#FAQSupport "Help and Support")
:   EMBOSS support, mailing lists, reporting bugs, requesting features, training courses etc.

[Q & A B.9, “Documentation”](apb.html#FAQDocumentation "Documentation")
:   EMBOSS documentation.

[Q & A B.10, “Applications”](apb.html#FAQApps "Applications")
:   Using the applications

[Q & A B.11, “EMBASSY”](apb.html#FAQEMBASSY "EMBASSY")
:   EMBASSY packages and applications.

[Q & A B.12, “ACD”](apb.html#FAQACD "ACD")
:   ACD syntax and files.

[Q & A B.13, “Interfaces”](apb.html#FAQInterfaces "Interfaces")
:   Use of EMBOSS interfaces.

[Q & A B.14, “Graphics”](apb.html#FAQGraphics "Graphics")
:   Graphics.

[Q & A B.15, “Internals”](apb.html#FAQInternals "Internals")
:   EMBOSS internals and core features for software developers.

[Q & A B.16, “Software Development”](apb.html#FAQSoftwareDevelopment "Software Development")
:   EMBOSS software development, programming libraries etc.

B.1. [General](apb.html#FAQGeneral)
:   Q: [Citation: Is there a reference I can cite for EMBOSS?](apb.html#d0e13025)

B.2. [Getting Started](apb.html#FAQGettingStarted)
:   Q: [Can I get the latest code via CVS ?](apb.html#d0e13035)

B.3. [Administration (installation and compilation)](apb.html#FAQAdministrationInstall)
:   Q: [How do I compile EMBOSS?](apb.html#d0e13087)

    Q: [I have a Linux system and compilation ends prematurely saying that it can't find the lX11 libraries ... but I know I have X11 installed.](apb.html#d0e13152)

    Q: [I'm trying to compile EMBOSS with PNG support](apb.html#d0e13197)

    Q: [When installing EMBOSS recently I get a load of errors due to libraries not found. The main problem is that I have an old version of libz but no libgd in my system libraries and EMBOSS looks there first to try to locate these libraries. I have the correct versions installed elsewhere. Are there any suggestions for setting the library search path or am I missing something really obvious?](apb.html#d0e13337)

    Q: [How do I compile the CVS (developers) version?](apb.html#d0e13374)

    Q: [Can you give an example of how to install an EMBASSY package?](apb.html#d0e13432)

    Q: [I have EMBOSS installed on our development server and I'm preparing a dispatch which will send it out to about 20 remote sites. I ran the configure with the --prefix option to install to a private directory. I also collected all the data files (rebase, transfac etc.) to another directory and extracted the information from them with the relevant programs.](apb.html#d0e13598)

    Q: [I have downloaded the EMBOSS source and installed it for use at XYZ University without any difficulty. I've had some advice on configuring the software using emboss.default, and seen some examples for allowing access to SRS indexes. That appears to be done via the program getz, which is not part of the EMBOSS package.](apb.html#d0e13666)

    Q: [I am not getting full static files even when I configure with --disable-shared](apb.html#d0e13701)

B.4. [Databases](apb.html#FAQDatabases)
:   Q: [Where are the test databases?](apb.html#d0e13728)

B.5. [Administration (other)](apb.html#FAQAdministrationOther)
:   Q: [How do I use my own private data file?](apb.html#d0e13741)

    Q: [Can I alter the location of the ACD files?](apb.html#d0e13851)

B.6. [Features](apb.html#FAQFeatures)
:   Q: [I would like to know if EMBOSS can perform nucleotide contig assembly similar to the function that GCG gelproject / gelview has. And if yes, is there any size restriction on the number of base pair and the number of contigs?](apb.html#d0e13877)

B.7. [Sequence Files and Formats](apb.html#FAQSequenceFiles)
:   Q: [How do you write sequences to different files instead of writing them all to one file?](apb.html#d0e13893)

    Q: [What sequence formats are supported?](apb.html#d0e13909)

    Q: [What is the difference between "TEXT" and "RAW" formats?](apb.html#d0e13916)

    Q: [What is "ASIS" format?](apb.html#d0e13928)

    Q: [I have some very short protein sequences that EMBOSS thinks are nucleic sequences. How do I force EMBOSS to treat them as nucleic acid sequences? For example: %cat seq1 A %cat seq2 I % water seq1 seq2 -stdout -auto Smith-Waterman local alignment. An error has been found: Sequence is not nucleic Here, water automatically (and wrongly) thinks that A is adenosine instead of alanine and fails when it reads in seq2 and expects to find another nucleic acid sequence - but I is not a valid base and so it fails.](apb.html#d0e13939)

B.8. [Help and Support](apb.html#FAQSupport)
:   Q: [How do I report bugs?](apb.html#d0e14019)

    Q: [How do I contact the core development team?](apb.html#d0e14028)

    Q: [Are there any mailing lists about EMBOSS?](apb.html#d0e14041)

    Q: [Is there a tutorial?](apb.html#d0e14079)

B.9. [Documentation](apb.html#FAQDocumentation)
:   Q: [Where's the documentation?](apb.html#d0e14096)

    Q: [Where's the application documentation?](apb.html#d0e14107)

    Q: [Is there a quick guide?](apb.html#d0e14133)

    Q: [Is there a table of substitutes for GCG programs?](apb.html#d0e14143)

B.10. [Applications](apb.html#FAQApps)
:   Q: [Plotting with pepwheel gives interesting output. pepwheel -turns=8 -send=30 sw:p77837 -auto](apb.html#d0e14157)

    Q: [In prettyplot, how do you specify an output file name for the plot file?](apb.html#d0e14176)

    Q: [I'm using the editor mse, but I don't know how to save my edited sequences at the end of the editing session.](apb.html#d0e14201)

B.11. [EMBASSY](apb.html#FAQEMBASSY)
:   Q: [What benefits do I gain from using the associated (EMBASSY) versions of software.](apb.html#d0e14220)

B.12. [ACD](apb.html#FAQACD)
:   Q: [What is an ACD files?](apb.html#d0e14233)

B.13. [Interfaces](apb.html#FAQInterfaces)
:   Q: [What types of interface are available?](apb.html#d0e14243)

B.14. [Graphics](apb.html#FAQGraphics)
:   Q: [What Graphics options are available?](apb.html#d0e14253)

    Q: [Plotters and pen colours.](apb.html#d0e14322)

    Q: [Browsing the Gnu site I came across libplot, libxmi and plot utils. Would these be a suitable replacement for PLPLOT?](apb.html#d0e14364)

    Q: [I get error messages when I try to display X11 on my PC. I am running the Hummingbird Exceed X11 emulator.](apb.html#d0e14383)

B.15. [Internals](apb.html#FAQInternals)
:   Q: [Is there a maximum size for sequences?](apb.html#d0e14411)

    Q: [GCG has a somewhat arbitrary fragment length limit of 2500 bp for gel\*. Is there a similar limit for mse under EMBOSS?](apb.html#d0e14434)

    Q: [I am trying to write a web interface for an emboss program and run apache. The program complains that there is no HOME directory set.](apb.html#d0e14450)

B.16. [Software Development](apb.html#FAQSoftwareDevelopment)
:   Q: [I am thinking of contributing software - how do I proceed?](apb.html#d0e14477)

|  |  |
| --- | --- |
| B.1. General | |
| Q: [Citation: Is there a reference I can cite for EMBOSS?](apb.html#d0e13025) | |
| **Q:** | Citation: Is there a reference I can cite for EMBOSS? |
| **A:** | Rice P., Longden I. and Bleasby A. EMBOSS: The European Molecular Biology Open Software Suite. Trends in Genetics. 2000 16(6):276-277 |
| B.2. Getting Started | |
| Q: [Can I get the latest code via CVS ?](apb.html#d0e13035) | |
| **Q:** | Can I get the latest code via CVS ? |
| **A:** | Yes. Here is the information you will need. Make sure you have cvs on your system. Then log into the cvs server at `open-bio.org` as: user `cvs` with password `cvs`.   |  | | --- | | **`cvs -d :pserver:cvs@cvs.open-bio.org:/home/repository/emboss login`** |   The password is `cvs` To checkout the EMBOSS source code tree, put yourself in a local directory just above where you want to see the EMBOSS directory created. For example if you wanted EMBOSS to be seen as `/home/joe/src/emboss...` then cd into `/home/joe/src` then checkout the repository by typing:   |  | | --- | | **`cvs -d :pserver:cvs@cvs.open-bio.org:/home/repository/emboss checkout emboss`** |   Or if you want to update a previously checked-out source code tree:   |  | | --- | | **`cvs -d :pserver:cvs@cvs.open-bio.org:/home/repository/emboss update`** |   You can logout from the CVS server with:   |  | | --- | | **`cvs -d :pserver:cvs@cvs.open-bio.org:/home/repository/emboss logout`** |   This is a read only server. |
| B.3. Administration (installation and compilation) | |
| Q: [How do I compile EMBOSS?](apb.html#d0e13087)  Q: [I have a Linux system and compilation ends prematurely saying that it can't find the lX11 libraries ... but I know I have X11 installed.](apb.html#d0e13152)  Q: [I'm trying to compile EMBOSS with PNG support](apb.html#d0e13197)  Q: [When installing EMBOSS recently I get a load of errors due to libraries not found. The main problem is that I have an old version of libz but no libgd in my system libraries and EMBOSS looks there first to try to locate these libraries. I have the correct versions installed elsewhere. Are there any suggestions for setting the library search path or am I missing something really obvious?](apb.html#d0e13337)  Q: [How do I compile the CVS (developers) version?](apb.html#d0e13374)  Q: [Can you give an example of how to install an EMBASSY package?](apb.html#d0e13432)  Q: [I have EMBOSS installed on our development server and I'm preparing a dispatch which will send it out to about 20 remote sites. I ran the configure with the --prefix option to install to a private directory. I also collected all the data files (rebase, transfac etc.) to another directory and extracted the information from them with the relevant programs.](apb.html#d0e13598)  Q: [I have downloaded the EMBOSS source and installed it for use at XYZ University without any difficulty. I've had some advice on configuring the software using emboss.default, and seen some examples for allowing access to SRS indexes. That appears to be done via the program getz, which is not part of the EMBOSS package.](apb.html#d0e13666)  Q: [I am not getting full static files even when I configure with --disable-shared](apb.html#d0e13701) | |
| **Q:** | How do I compile EMBOSS? |
| **A:** | If this is the first time trying to compile all you need to do is:   |  | | --- | | **`./configure`** | | **`make`** |   The above will produce the EMBOSS programs in the `emboss` subdirectory and you can set your `PATH` variable to point there. This method is suitable for EMBOSS developers. For system-wide installations we recommend installing the EMBOSS programs into a different directory from the source code (e.g. in the directory tree `/usr/local/emboss`). To do this type (e.g.):   |  | | --- | | **`./configure --prefix=/usr/local/emboss`** | | **`make`** [to make sure there are no errors, then] | | **`make install`** [if there are no errors] |   You should then add (e.g.) `/usr/local/emboss/bin` to your `PATH` variable:   |  | | --- | | **`set path=(/usr/local/emboss/bin $path)`** [`csh/tcsh` shells] | | **`export PATH="$PATH:/usr/local/emboss/bin"`** [`sh/bash` shells] |   If you wish to re-compile the code at any stage then you should type **`make clean`** and then configure and make source again as appropriate. |
| **Q:** | I have a Linux system and compilation ends prematurely saying that it can't find the **lX11** libraries ... but I know I have **X11** installed. |
| **A:** | This should not happen with versions of EMBOSS later than 6.1.0 as the configuration will inform you of missing files and terminate at that stage. If you have a version of EMBOSS less than or equal to 6.1.0 then the problem is that you probably have the **X11** server installed but you haven't installed the **X11** development files. For example, on RPM distributions, you need to install:   |  | | --- | | `xorg-x11-proto-devel` (xorg-based **X11** distros) or | | `XFree86-devel` (XFree86-based **X11** distros) |   After installing those system files you will need to:   |  | | --- | | **`make clean`** |   and re-perform the **`./configure`** command from the top EMBOSS source directory. |
| **Q:** | I'm trying to compile EMBOSS with PNG support |
| **A:** | Your system will need to have **zlib** (*[http://www.zlib.net](www.zlib.net)*: current version is 1.2.3), **libpng** (*[http://www.libpng.org](www.libpng.org)*: current version is 1.2.35) and **gd** (*[http://www.libgd.org](www.libgd.org)*: current version is 2.0.35). The version of **gd** must be >= 2.0.28 if it is to be used with EMBOSS.  Note that the above packages often come with your operating system distribution but may not be installed by default i.e. they are optional packages which you can install at a later date. Also note that, as well as having the above system libraries installed, you must also have installed their associated development files (these typically have `devel` in the package names on Linux systems). So, on Linux RPM systems you would need to make sure that packages called names similar to **gd** and `gd-devel` are installed.  MacOSX users can often find the above packages available on the MacPorts site (*[http://www.macports.org](www.macports.org)*). However, for some operating systems, there may be no freeware sites where you can find pre-compiled versions of **zlib** / **libpng** / **gd** and you may have to compile one or more of them from their source distributions (URLs given above).  You can unpack the `tar.gz` or `tar.bz2` files in any directory, and install them in a common area. By default everything (including EMBOSS) installs in `/usr/local`. To i