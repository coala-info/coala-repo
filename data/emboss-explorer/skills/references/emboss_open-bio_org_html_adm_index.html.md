| EMBOSS Administrators Guide | | |
| --- | --- | --- |
|  |  | [Next](pr01.html) |

---

# [EMBOSS Administrators Guide](http://www.cambridge.org/gb/knowledge/isbn/item5979238/?site_locale=en_GB)

## Bioinformatics Software Management

### Dr. Alan Bleasby

Senior Scientific Officer
EMBL European Bioinformatics Institute

EMBL-EBI, Wellcome Trust Genome Campus, Hinxton, Cambridge, CB10 1SD, UK

`<ajb@ebi.ac.uk>`

### Dr. Jon Ison

Senior Scientific Officer
EMBL European Bioinformatics Institute

EMBL-EBI, Wellcome Trust Genome Campus, Hinxton, Cambridge, CB10 1SD, UK

`<jison@ebi.ac.uk>`

### Mr. Peter Rice

Group Leader
EMBL European Bioinformatics Institute

EMBL-EBI, Wellcome Trust Genome Campus, Hinxton, Cambridge, CB10 1SD, UK

`<pmr@ebi.ac.uk>`

| **Revision History** | | |
| --- | --- | --- |
|  | August 2009 | The EMBOSS Developers |
| Version 1 | | |

---

**Table of Contents**

[Acknowledgements](pr01.html)
:   [1. EMBOSS Acknowledgements](pr01s01.html)
    :   [1.1. Funding Bodies](pr01s01.html#d0e120)

        [1.2. Contributors](pr01s01.html#d0e132)

    [2. *EMBOSS Administrators Guide* Acknowledgements](pr01s02.html)

[Preface](pr02.html)
:   [1. Introduction to EMBOSS](pr02s01.html)

    [2. Administration of EMBOSS](pr02s02.html)

    [3. About the Authors](pr02s03.html)

    [4. How To Cite EMBOSS](pr02s04.html)

[Conventions](pr03.html)
:   [1. Command Line Sessions and Commands](pr03s01.html)

    [2. Program Listings and Code](pr03s02.html)

    [3. Other Conventions](pr03s03.html)

    [4. Special Text Blocks](pr03s04.html)

[Welcome to the *EMBOSS Administrators Manual*](pr04.html)
:   [1. Chapter 1. Building EMBOSS](pr04s01.html)

    [2. Chapter 2. Building EMBASSY](pr04s02.html)

    [3. Chapter 3. Building **Jemboss**](pr04s03.html)

    [4. Chapter 4. Databases](pr04s04.html)

    [5. Appendix A. Resources](pr04s05.html)

    [6. Appendix B. Frequently Asked Questions (FAQ)](pr04s06.html)

[1. Building EMBOSS](ch01.html)
:   [1.1. Downloading EMBOSS](ch01s01.html)
    :   [1.1.1. Downloading with a Web Browser](ch01s01.html#d0e764)

        [1.1.2. Downloading by Anonymous FTP](ch01s01.html#d0e792)
        :   [1.1.2.1. Interactive FTP](ch01s01.html#d0e795)

            [1.1.2.2. FTP using `wget`](ch01s01.html#d0e974)

        [1.1.3. Unpacking the Source Code](ch01s01.html#UnpackingSourceCode)

    [1.2. Building EMBOSS](ch01s02.html)

    [1.3. Configuring EMBOSS](ch01s03.html)
    :   [1.3.1. A Simple Configuration](ch01s03.html#d0e1185)

        [1.3.2. Configuring EMBOSS to use Graphics](ch01s03.html#d0e1293)

        [1.3.3. Configuring with PNG Graphics](ch01s03.html#ConfiguringWithPNG)

        [1.3.4. Configuring with PDF Graphics](ch01s03.html#ConfiguringWithPDF)

        [1.3.5. Configuration, Ensembl and SQL](ch01s03.html#d0e1548)

        [1.3.6. If you need to Configure Again](ch01s03.html#d0e1585)

        [1.3.7. Advanced Configuration Options](ch01s03.html#d0e1623)

        [1.3.8. Configuration Options to Avoid](ch01s03.html#d0e1650)

        [1.3.9. Configuration Options to Use](ch01s03.html#d0e1730)

    [1.4. Compiling EMBOSS](ch01s04.html)
    :   [1.4.1. Reporting Compilation Errors](ch01s04.html#d0e2144)

    [1.5. Installing the Libraries and Applications](ch01s05.html)

    [1.6. Post-installation of EMBOSS](ch01s06.html)
    :   [1.6.1. Testing the EMBOSS Installation](ch01s06.html#d0e2341)
        :   [1.6.1.1. Common Errors During Testing](ch01s06.html#d0e2358)

        [1.6.2. Post-installation of Data Files](ch01s06.html#d0e2444)
        :   [1.6.2.1. REBASE](ch01s06.html#d0e2449)

            [1.6.2.2. AAINDEX](ch01s06.html#d0e2478)

            [1.6.2.3. PRINTS](ch01s06.html#d0e2498)

            [1.6.2.4. PROSITE](ch01s06.html#d0e2518)

            [1.6.2.5. JASPAR](ch01s06.html#d0e2543)

        [1.6.3. Deleting the EMBOSS Package](ch01s06.html#DeletingTheEMBOSSPackage)

        [1.6.4. Keeping EMBOSS Up To Date](ch01s06.html#d0e2622)

        [1.6.5. Installing a New Version of EMBOSS](ch01s06.html#d0e2698)

        [1.6.6. EMBOSS Configuration Files](ch01s06.html#d0e2707)
        :   [1.6.6.1. Syntax of `emboss.default` and `.embossrc` Files](ch01s06.html#d0e2739)

            [1.6.6.2. Configuring EMBOSS for Different Groups of Users](ch01s06.html#d0e2814)

        [1.6.7. EMBOSS Environment Variables](ch01s06.html#d0e2844)
        :   [1.6.7.1. Global Qualifiers](ch01s06.html#d0e3728)

            [1.6.7.2. Logging](ch01s06.html#d0e3821)

            [1.6.7.3. Environment Variables File (`variables.standard`)](ch01s06.html#d0e3859)

        [1.6.8. EMBOSS Data Files](ch01s06.html#d0e3874)

    [1.7. EMBOSS Installation: Platform-specific Concerns](ch01s07.html)
    :   [1.7.1. Linux RPM Distributions](ch01s07.html#d0e4010)
        :   [1.7.1.1. General Prerequisites](ch01s07.html#d0e4030)

            [1.7.1.2. PNG prerequisites](ch01s07.html#d0e4088)

            [1.7.1.3. PDF prerequisites](ch01s07.html#d0e4138)

            [1.7.1.4. Java](ch01s07.html#d0e4169)

        [1.7.2. Linux Debian Distributions](ch01s07.html#d0e4231)
        :   [1.7.2.1. General Prerequisites](ch01s07.html#d0e4242)

            [1.7.2.2. PNG prerequisites](ch01s07.html#d0e4262)

            [1.7.2.3. PDF prerequisites](ch01s07.html#d0e4306)

            [1.7.2.4. Java](ch01s07.html#d0e4313)

        [1.7.3. MacOSX](ch01s07.html#d0e4319)
        :   [1.7.3.1. General Prerequisites](ch01s07.html#d0e4344)

            [1.7.3.2. PNG prerequisites](ch01s07.html#d0e4367)

            [1.7.3.3. PDF prerequisites](ch01s07.html#d0e4578)

            [1.7.3.4. Java](ch01s07.html#d0e4585)

        [1.7.4. IRIX](ch01s07.html#d0e4603)
        :   [1.7.4.1. General Prerequisites](ch01s07.html#d0e4606)

            [1.7.4.2. PNG prerequisites](ch01s07.html#d0e4692)

            [1.7.4.3. PDF prerequisites](ch01s07.html#d0e4713)

            [1.7.4.4. Java](ch01s07.html#d0e4720)

        [1.7.5. Tru64](ch01s07.html#d0e4737)
        :   [1.7.5.1. General Prerequisites](ch01s07.html#d0e4740)

            [1.7.5.2. PNG prerequisites](ch01s07.html#d0e4783)

            [1.7.5.3. PDF prerequisites](ch01s07.html#d0e4802)

            [1.7.5.4. Java](ch01s07.html#d0e4809)

        [1.7.6. Solaris](ch01s07.html#d0e4824)
        :   [1.7.6.1. General Prerequisites](ch01s07.html#d0e4829)

            [1.7.6.2. PNG prerequisites](ch01s07.html#d0e4932)

            [1.7.6.3. PDF prerequisites](ch01s07.html#d0e5003)

            [1.7.6.4. Java](ch01s07.html#d0e5010)

    [1.8. Troubleshooting EMBOSS Installations](ch01s08.html)

    [1.9. PNG support: Installing from Source Code](ch01s09.html)
    :   [1.9.1. LIBPNG Compilation](ch01s09.html#d0e5322)

        [1.9.2. **gd** Compilation](ch01s09.html#d0e5437)

    [1.10. PDF support: Installing from Source Code](ch01s10.html)

    [1.11. **Ncurses** Support: Installing from Source Code](ch01s11.html)
    :   [1.11.1. **Ncurses** Compilation](ch01s11.html#d0e5790)

[2. Building EMBASSY](ch02.html)
:   [2.1. Introduction to EMBASSY](ch02s01.html)

    [2.2. Downloading the EMBASSY Packages](ch02s02.html)
    :   [2.2.1. Unpacking the Source Code](ch02s02.html#d0e6029)

    [2.3. Building the EMBASSY Packages](ch02s03.html)

    [2.4. Configuring the EMBASSY Packages](ch02s04.html)
    :   [2.4.1. A Simple Configuration](ch02s04.html#d0e6176)
        :   [2.4.1.1. **CBSTOOLS**](ch02s04.html#d0e6266)

            [2.4.1.2. **DOMAINATRIX**](ch02s04.html#d0e6302)

            [2.4.1.3. **DOMALIGN**](ch02s04.html#d0e6308)

            [2.4.1.4. **DOMSEARCH**](ch02s04.html#d0e6314)

            [2.4.1.5. **EMNU**](ch02s04.html#d0e6320)

            [2.4.1.6. **ESIM4**](ch02s04.html#d0e6339)

            [2.4.1.7. **HMMER**](ch02s04.html#d0e6348)

            [2.4.1.8. **IPRSCAN**](ch02s04.html#d0e6357)

            [2.4.1.9. **MEME**](ch02s04.html#d0e6375)

            [2.4.1.10. **MIRA**](ch02s04.html#d0e6384)

            [2.4.1.11. **MSE**](ch02s04.html#d0e6393)

            [2.4.1.12. **MYEMBOSS**](ch02s04.html#d0e6407)

            [2.4.1.13. **MYEMBOSSDEMO**](ch02s04.html#d0e6413)

            [2.4.1.14. **PHYLIP**](ch02s04.html#d0e6419)

            [2.4.1.15. **SIGNATURE**](ch02s04.html#d0e6425)

            [2.4.1.16. **STRUCTURE**](ch02s04.html#d0e6431)

            [2.4.1.17. **TOPO**](ch02s04.html#d0e6437)

            [2.4.1.18. **VIENNA**](ch02s04.html#d0e6443)

    [2.5. Compiling the EMBASSY Packages](ch02s05.html)
    :   [2.5.1. Reporting Compilation Errors](ch02s05.html#d0e6487)

    [2.6. Installing the EMBASSY Packages](ch02s06.html)

    [2.7. Post-installation of the EMBASSY Packages](ch02s07.html)
    :   [2.7.1. Testing an EMBASSY Installation](ch02s07.html#d0e6614)

        [2.7.2. Deleting an EMBASSY Package](ch02s07.html#d0e6635)

        [2.7.3. Keeping EMBASSY up to Date](ch02s07.html#d0e6650)

        [2.7.4. Reinstallation of EMBASSY and EMBOSS](ch02s07.html#d0e6661)

    [2.8. EMBASSY Installation: Platform-specific Concerns](ch02s08.html)
    :   [2.8.1. Linux RPM Distributions](ch02s08.html#d0e6684)
        :   [2.8.1.1. General Prerequisites](ch02s08.html#d0e6701)

            [2.8.1.2. **Ncurses** prerequisites](ch02s08.html#d0e6708)

        [2.8.2. Linux Debian Distributions](ch02s08.html#d0e6745)
        :   [2.8.2.1. General Prerequisites](ch02s08.html#d0e6756)

            [2.8.2.2. **Ncurses** prerequisites](ch02s08.html#d0e6763)

        [2.8.3. MacOSX](ch02s08.html#d0e6789)
        :   [2.8.3.1. General Prerequisites](ch02s08.html#d0e6797)

            [2.8.3.2. **Ncurses** prerequisites](ch02s08.html#d0e6804)

        [2.8.4. IRIX](ch02s08.html#d0e6812)
        :   [2.8.4.1. General Prerequisites](ch02s08.html#d0e6815)

            [2.8.4.2. **Ncurses** prerequisites](ch02s08.html#d0e6822)

        [2.8.5. Tru64](ch02s08.html#d0e6868)
        :   [2.8.5.1. General Prerequisites](ch02s08.html#d0e6871)

            [2.8.5.2. **Ncurses** prerequisites](ch02s08.html#d0e6878)

        [2.8.6. Solaris](ch02s08.html#d0e6895)
        :   [2.8.6.1. General Prerequisites](ch02s08.html#d0e6900)

            [2.8.6.2. **Ncurses** prerequisites](ch02s08.html#d0e6907)

[3. Building Jemboss](ch03.html)
:   [3.1. Introduction to **Jemboss**](ch03s01.html)
    :   [3.1.1. **Jemboss** as a Client/Server](ch03s01.html#d0e6955)

        [3.1.2. **Jemboss** as a standalone GUI](ch03s01.html#d0e6973)

    [3.2. Installing as a Standalone GUI](ch03s02.html)
    :   [3.2.1. Prerequisites](ch03s02.html#d0e7005)

        [3.2.2. Current Software Versions](ch03s02.html#d0e7033)

        [3.2.3. Compiling EMBOSS for use with the Standalone Jemboss](ch03s02.html#d0e7049)

        [3.2.4. Post-installation of the Standalone GUI](ch03s02.html#d0e7066)

    [3.3. Installing as an Authenticating Client Server](ch03s03.html)
    :   [3.3.1. Prerequisites](ch03s03.html#d0e7093)

        [3.3.2. Current Software Versions](ch03s03.html#d0e7156)

        [3.3.3. Client-Server Installation](ch03s03.html#AdmJEMBOSSClientServerAddingEMBASSY)
        :   [3.3.3.1. Setting-up EMBASSY Packages](ch03s03.html#d0e7178)

            [3.3.3.2. Installing Tomcat and Axis](ch03s03.html#d0e7228)

            [3.3.3.3. Adding EMBASSY Packages to the Server (post-installation)](ch03s03.html#d0e7665)

    [3.4. Installing as a Non-authenticating Client Server](ch03s04.html)

    [3.5. Technical Details of Authentication](ch03s05.html)

    [3.6. Starting and Stopping the **Jemboss** Server](ch03s06.html)
    :   [3.6.1. Creating a Web Launch Page for the **Jemboss** Authenticating Server](ch03s06.html#CreatingWebLaunchPage)

    [3.7. What to do if your Certificates Expire](ch03s07.html)

    [3.8. The `jemboss.properties` File](ch03s08.html)

    [3.9. Setting up Jemboss to use Batch Queuing Software](ch03s09.html)

    [3.10. Setting up the Clients](ch03s10.html)

    [3.11. Troubleshooting JEMBOSS Installation](ch03s11.html)

    [3.12. **Jemboss** Installation: Platform-specific Concerns](ch03s12.html)
    :   [3.12.1. MacOSX](ch03s12.html#d0e8804)
        :   [3.12.1.1. General Prerequisites](ch03s12.html#d0e8815)

            [3.12.1.2. When Running the Script](ch03s12.html#d0e8847)

        [3.12.2. IRIX](ch03s12.html#d0e8911)
        :   [3.12.2.1. General Prerequisites](ch03s12.html#d0e8914)

            [3.12.2.2. When Running the Script](ch03s12.html#d0e8925)

[4. Databases](ch04.html)
:   [4.1. General Database Configuration](ch04s01.html)
    :   [4.1.1. Sequence Database Support](ch04s01.html#d0e8993)
        :   [4.1.1.1. Query Levels, Access Methods and Attributes](ch04s01.html#d0e9085)

        [4.1.2. Configuring EMBOSS to work with Databases](ch04s01.html#d0e9143)

        [4.1.3. Example Database Definition File (`emboss.default.template`)](ch04s01.html#d0e9287)

        [4.1.4. Test Databases](ch04s01.html#d0e9304)

        [4.1.5. Testing your Database Definitions](ch04s01.html#d0e9437)

    [4.2. Database Attributes](ch04s02.html)
    :   [4.2.1. Introduction](ch04s02.html#d0e9665)

        [4.2.2. Description of Attributes](ch04s02.html#d0e9931)
        :   [4.2.2.1. `method, methodall, methodentry, methodquery`](ch04s02.html#d0e9934)

            [4.2.2.2. `format, formatentry, formatquery, formatall`](ch04s02.html#d0e9961)

            [4.2.2.3. `type`](ch04s02.html#d0e9991)

            [4.2.2.4. `fields`](ch04s02.html#d0e10016)

            [4.2.2.5. `directory`](ch04s02.html#d0e10103)

            [4.2.2.6. `filename`](ch04s02.html#d0e10145)

            [4.2.2.7. `exclude`](ch04s02.html#d0e10191)

            [4.2.2.8. `indexdirectory`](ch04s02.html#d0e10229)

            [4.2.2.9. `url`](ch04s02.html#d0e10291)

            [4.2.2.10. `proxy`](ch04s02.html#d0e10329)

            [4.2.2.11. `httpversion`](ch04s02.html#d0e10368)

            [4.2.2.12. `app, appentry, appquery, appall`](ch04s02.html#d0e10404)

            [4.2.2.13. `dbalias`](ch04s02.html#d0e10454)

            [4.2.2.14. `comment`](ch04s02.html#d0e10488)

            [4.2.2.15. `release`](ch04s02.html#d0e10501)

            [4.2.2.16. `hasaccession`](ch04s02.html#d0e10534)

            [4.2.2.17. `caseidmatch`](ch04s02.html#d0e10544)

    [4.3. Database Access Methods](ch04s03.html)
    :   [4.3.1. Introduction](ch04s03.html#d0e10581)

        [4.3.2. Description of Database Access Methods](ch04s03.html#DescriptionOfDatabaseAccessMethods)
        :   [4.3.2.1. `EMBOSS`](ch04s03.html#d0e10758)

            [4.3.2.2. `EMBLCD`](ch04s03.html#d0e10844)

            [4.3.2.3. `SRS`](ch04s03.html#d0e10955)

            [4.3.2.4. `SRSFASTA`](ch04s03.html#d0e11039)

            [4.3.2.5. `SRSWWW`](ch04s03.html#d0e11114)

            [4.3.2.6. `BLAST`](ch04s03.html#d0e11170)

            [4.3.2.7. `EMBOSSGCG`](ch04s03.html#d0e11318)

            [4.3.2.8. `GCG`](ch04s03.html#d0e11385)

            [4.3.2.9. `DIRECT`](ch04s03.html#d0e11476)

            [4.3.2.10. `URL`](ch04s03.html#d0e11529)

            [4.3.2.11. `APP`](ch04s03.html#d0e11551)

        [4.3.3. Mixed Acces