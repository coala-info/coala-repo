| EMBOSS Users Guide | | |
| --- | --- | --- |
|  |  | [Next](pr01.html) |

---

# [EMBOSS Users Guide](http://www.cambridge.org/gb/knowledge/isbn/item5979294/?site_locale=en_GB)

## Practical Bioinformatics

### Mr. Peter Rice

Group Leader
EMBL European Bioinformatics Institute

EMBL-EBI, Wellcome Trust Genome Campus, Hinxton, Cambridge, CB10 1SD, UK

`<pmr@ebi.ac.uk>`

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

### Lisa Mullan

### Guy Bottu

| **Revision History** | | |
| --- | --- | --- |
|  | August 2009 | The EMBOSS Developers |
| Version 1 | | |

---

**Table of Contents**

[Acknowledgements](pr01.html)
:   [1. EMBOSS Acknowledgements](pr01s01.html)
    :   [1.1. Funding Bodies](pr01s01.html#d0e127)

        [1.2. Contributors](pr01s01.html#d0e139)

    [2. *EMBOSS Users Guide* Acknowledgements](pr01s02.html)

[Preface](pr02.html)
:   [1. Introduction to EMBOSS](pr02s01.html)

    [2. Using EMBOSS](pr02s02.html)

    [3. About the Authors](pr02s03.html)

    [4. How To Cite EMBOSS](pr02s04.html)

[Conventions used in the Manual](pr03.html)
:   [1. Command Line Sessions and Commands](pr03s01.html)

    [2. Program Listings and Code](pr03s02.html)

    [3. Other Conventions](pr03s03.html)

    [4. Special Text Blocks](pr03s04.html)

[Welcome to the *EMBOSS Users Manual*](pr04.html)
:   [1. Chapter 1. Background to EMBOSS](pr04s01.html)

    [2. Chapter 2. Basic Set-up and Maintenance](pr04s02.html)

    [3. Chapter 3. Getting Started](pr04s03.html)

    [4. Chapter 4. Tutorial](pr04s04.html)

    [5. Chapter 5. File Formats](pr04s05.html)

    [6. Chapter 6. The EMBOSS Command Line](pr04s06.html)

    [7. Chapter 7. Interfaces](pr04s07.html)

    [8. Chapter 8. Using EMBOSS under **wEMBOSS**](pr04s08.html)

    [9. Chapter 9. Using EMBOSS under **Jemboss**](pr04s09.html)

    [10. Appendix A. File Format Reference](pr04s10.html)

    [11. Appendix B. Application Reference](pr04s11.html)

    [12. Appendix C. Command-line Qualifier Reference](pr04s12.html)

    [13. Appendix D. Resources](pr04s13.html)

[1. Background to EMBOSS](ch01.html)
:   [1.1. History](ch01s01.html)

    [1.2. EMBOSS Developers](ch01s02.html)

    [1.3. Key Features](ch01s03.html)
    :   [1.3.1. General Features](ch01s03.html#d0e989)
        :   [1.3.1.1. Open source](ch01s03.html#d0e992)

            [1.3.1.2. Stable licensing](ch01s03.html#d0e1016)

            [1.3.1.3. UNIX command line](ch01s03.html#d0e1036)

            [1.3.1.4. Command line validation](ch01s03.html#d0e1060)

            [1.3.1.5. Data in any common format](ch01s03.html#d0e1075)

            [1.3.1.6. No sequence length limit](ch01s03.html#d0e1093)

            [1.3.1.7. Availability and distribution](ch01s03.html#d0e1111)

            [1.3.1.8. Quality assurance](ch01s03.html#d0e1129)

        [1.3.2. Features for Users of EMBOSS](ch01s03.html#d0e1145)
        :   [1.3.2.1. Simple site configuration](ch01s03.html#d0e1148)

            [1.3.2.2. Support for local databases](ch01s03.html#d0e1167)

            [1.3.2.3. Remote data servers](ch01s03.html#d0e1197)

            [1.3.2.4. Support for users of EMBOSS](ch01s03.html#d0e1209)

            [1.3.2.5. Functionality and integration](ch01s03.html#d0e1239)

            [1.3.2.6. Interfaces](ch01s03.html#d0e1272)

[2. Basic Set-up and Maintenance](ch02.html)
:   [2.1. Supported Platforms](ch02s01.html)

    [2.2. Hardware Requirements](ch02s02.html)

    [2.3. Software Requirements](ch02s03.html)
    :   [2.3.1. GNU Tools](ch02s03.html#d0e1429)

        [2.3.2. EMBOSS Dependencies](ch02s03.html#d0e1458)

        [2.3.3. EMBASSY Dependencies](ch02s03.html#d0e1499)

    [2.4. Software Releases](ch02s04.html)
    :   [2.4.1. Stable Releases](ch02s04.html#d0e1730)
        :   [2.4.1.1. EMBOSS Stable Release](ch02s04.html#d0e1739)

            [2.4.1.2. EMBASSY Stable Releases](ch02s04.html#d0e1755)

            [2.4.1.3. Release Dates and Version Numbers](ch02s04.html#d0e1849)

            [2.4.1.4. Log File of Changes](ch02s04.html#d0e1857)

        [2.4.2. Developers (CVS) Release](ch02s04.html#d0e1871)

    [2.5. Downloading the Stable Release](ch02s05.html)
    :   [2.5.1. Downloading via the EMBOSS Website](ch02s05.html#d0e1909)

        [2.5.2. Downloading via Anonymous FTP](ch02s05.html#d0e1919)
        :   [2.5.2.1. Unpacking EMBOSS and EMBASSY Packages](ch02s05.html#d0e2045)

    [2.6. Package Structure](ch02s06.html)
    :   [2.6.1. Major Components](ch02s06.html#d0e2101)

        [2.6.2. Sub-components](ch02s06.html#d0e2191)

        [2.6.3. Differences between CVS and Stable Versions](ch02s06.html#d0e2316)

    [2.7. Installation](ch02s07.html)
    :   [2.7.1. Overview of the Installation Process](ch02s07.html#d0e2382)

        [2.7.2. Configuration](ch02s07.html#d0e2411)

        [2.7.3. Compilation](ch02s07.html#d0e2476)

        [2.7.4. Setting your `PATH`](ch02s07.html#d0e2574)

        [2.7.5. Testing all is Well](ch02s07.html#d0e2673)

        [2.7.6. Database Setup](ch02s07.html#d0e2690)

        [2.7.7. Installing EMBASSY Packages](ch02s07.html#d0e2782)
        :   [2.7.7.1. Stable Release](ch02s07.html#d0e2803)

    [2.8. Maintenance](ch02s08.html)
    :   [2.8.1. Using CVS to Update](ch02s08.html#d0e2986)

        [2.8.2. Bug-fix Replacement Files](ch02s08.html#d0e3040)

        [2.8.3. Patch Files](ch02s08.html#d0e3082)

        [2.8.4. Automated Installation of EMBOSS and EMBASSY](ch02s08.html#d0e3195)

        [2.8.5. Automated Database Updating](ch02s08.html#d0e3219)

[3. Getting Started](ch03.html)
:   [3.1. Application Documentation](ch03s01.html)
    :   [3.1.1. Online Documentation](ch03s01.html#d0e3280)
        :   [3.1.1.1. Application Groups](ch03s01.html#d0e3300)

            [3.1.1.2. EMBASSY Packages](ch03s01.html#d0e3308)

            [3.1.1.3. Applications](ch03s01.html#d0e3316)

        [3.1.2. AJAX Command Definition (ACD) Language](ch03s01.html#d0e3343)

        [3.1.3. Interfaces](ch03s01.html#d0e3354)

    [3.2. Navigating the Application Documentation](ch03s02.html)
    :   [3.2.1. Navigating the Tabular Documentation](ch03s02.html#d0e3405)

        [3.2.2. Sections in the Application Documentation](ch03s02.html#d0e3425)

    [3.3. How to Contribute](ch03s03.html)
    :   [3.3.1. EMBOSS Coordination Meetings](ch03s03.html#d0e3602)

        [3.3.2. Collaborations](ch03s03.html#d0e3625)

    [3.4. Project Mailing Lists](ch03s04.html)
    :   [3.4.1. User Mailing List](ch03s04.html#d0e3655)

        [3.4.2. Developer Mailing List](ch03s04.html#d0e3668)

        [3.4.3. Announcements Mailing List](ch03s04.html#d0e3687)

        [3.4.4. Mail Archives](ch03s04.html#d0e3700)
        :   [3.4.4.1. User Mailing List Archive](ch03s04.html#d0e3705)

            [3.4.4.2. Developer Mailing List Archive](ch03s04.html#d0e3716)

    [3.5. How to Get Help](ch03s05.html)
    :   [3.5.1. EMBOSS Documentation](ch03s05.html#d0e3766)

        [3.5.2. EMBOSS Frequently Asked Questions](ch03s05.html#d0e3793)

        [3.5.3. Asking for Help](ch03s05.html#d0e3805)
        :   [3.5.3.1. Before you Send a Request for Support](ch03s05.html#d0e3831)

            [3.5.3.2. How to Write a Request for Support](ch03s05.html#d0e3868)

        [3.5.4. Suggesting New Features and Applications](ch03s05.html#d0e3915)

    [3.6. Reporting Bugs and Problems](ch03s06.html)
    :   [3.6.1. Where to Send a Bug Report](ch03s06.html#d0e3959)

        [3.6.2. Before you Send a Bug Report](ch03s06.html#d0e3979)

        [3.6.3. How to Write a Bug Report](ch03s06.html#d0e3993)

    [3.7. EMBOSS Training](ch03s07.html)
    :   [3.7.1. EMBOSS Tutorial](ch03s07.html#d0e4063)

        [3.7.2. EMBOSS Developers Course](ch03s07.html#d0e4071)

        [3.7.3. EMBOSS Workshops](ch03s07.html#d0e4082)

[4. EMBOSS User Tutorial](ch04.html)
:   [4.1. How this Tutorial is Organised](ch04s01.html)
    :   [4.1.1. **[wossname](http://emboss.open-bio.org/rel/dev/apps/wossname.html)**: a first EMBOSS Application](ch04s01.html#HelpTutorial4)

        [4.1.2. Exercise: **`wossname`**](ch04s01.html#HelpTutorial5)

    [4.2. Working with Sequences](ch04s02.html)
    :   [4.2.1. Retrieving Sequences from Databases](ch04s02.html#HelpTutorial6)

        [4.2.2. Exercise: **`showdb`**](ch04s02.html#HelpTutorial7)

        [4.2.3. **`seqret`**](ch04s02.html#HelpTutorial8)

        [4.2.4. Exercise: **`seqret`**](ch04s02.html#HelpTutorial9)

        [4.2.5. Reading Sequences from Files](ch04s02.html#HelpTutorial10)

        [4.2.6. **`infoseq`**](ch04s02.html#HelpTutorial12)

        [4.2.7. Sequence Annotation](ch04s02.html#HelpTutorial13)

        [4.2.8. Using Multiple Sequences](ch04s02.html#HelpTutorial14)

        [4.2.9. Listfiles](ch04s02.html#HelpTutorial15)

    [4.3. Working with Alignments](ch04s03.html)
    :   [4.3.1. Pairwise Sequence Alignment](ch04s03.html#PairwiseSequenceAlignment)

        [4.3.2. Dotplots](ch04s03.html#HelpTutorial16)

        [4.3.3. Exercise: Making a Dotplot](ch04s03.html#HelpTutorial17)

        [4.3.4. Exercise: Examining Dotplot Parameters](ch04s03.html#HelpTutorial18)

        [4.3.5. Global Alignment](ch04s03.html#HelpTutorial19)

        [4.3.6. Exercise: **`needle`**](ch04s03.html#HelpTutorial20)

        [4.3.7. Local Alignment](ch04s03.html#HelpTutorial21)

        [4.3.8. Exercise: **`water`**](ch04s03.html#HelpTutorial22)

    [4.4. Protein Analysis](ch04s04.html)
    :   [4.4.1. Identifying the ORF](ch04s04.html#HelpTutorial23)

        [4.4.2. Exercise: **`plotorf`**](ch04s04.html#HelpTutorial24)

        [4.4.3. Exercise: **`getorf`**](ch04s04.html#HelpTutorial25)

        [4.4.4. Translating the Sequence](ch04s04.html#HelpTutorial26)

        [4.4.5. Exercise: **`transeq`**](ch04s04.html#HelpTutorial28)

        [4.4.6. USA for Partial Sequences](ch04s04.html#HelpTutorial29)

    [4.5. Secondary Structure Prediction](ch04s05.html)
    :   [4.5.1. pepinfo](ch04s05.html#HelpTutorial32)

        [4.5.2. Exercise: **`pepinfo`**](ch04s05.html#HelpTutorial33)

        [4.5.3. Predicting Transmembrane Regions](ch04s05.html#HelpTutorial34)

        [4.5.4. Exercise: **`tmap`**](ch04s05.html#HelpTutorial35)

    [4.6. Patterns, Profiles and Multiple Sequence Alignment](ch04s06.html)
    :   [4.6.1. Pattern Matching](ch04s06.html#HelpTutorial36)

        [4.6.2. Exercise: **`patmatmotifs`**](ch04s06.html#HelpTutorial37)

        [4.6.3. Protein Fingerprints](ch04s06.html#HelpTutorial39)

        [4.6.4. Exercise: **`pscan`**](ch04s06.html#HelpTutorial40)

        [4.6.5. Multiple Sequence Analysis](ch04s06.html#HelpTutorial41)

        [4.6.6. Exercise: Retrieving a Set of Sequences](ch04s06.html#HelpTutorial42)

        [4.6.7. Exercise: **`emma`**](ch04s06.html#HelpTutorial43)

        [4.6.8. Exercise: **`prettyplot`**](ch04s06.html#HelpTutorial44)

        [4.6.9. Profiles](ch04s06.html#HelpTutorial45)

        [4.6.10. Exercise: **`prophecy`**](ch04s06.html#HelpTutorial46)

        [4.6.11. Exercise: **`prophet`**](ch04s06.html#HelpTutorial47)

    [4.7. Report Formats](ch04s07.html)

    [4.8. Conclusions](ch04s08.html)
    :   [4.8.1. Exercise: **`tfm`**](ch04s08.html#HelpTutorial48)

[5. File Formats](ch05.html)
:   [5.1. Introduction](ch05s01.html)

    [5.2. Introduction to Sequence Formats](ch05s02.html)
    :   [5.2.1. What is a Sequence Format?](ch05s02.html#d0e5870)

        [5.2.2. Supported Sequence Formats](ch05s02.html#d0e5958)

        [5.2.3. Contents of a Sequence Entry](ch05s02.html#d0e7546)
        :   [5.2.3.1. Identification](ch05s02.html#d0e7558)

            [5.2.3.2. Bibliographic Information](ch05s02.html#d0e7623)

            [5.2.3.3. Annotation and Features](ch05s02.html#d0e7664)

            [5.2.3.4. The Sequence](ch05s02.html#d0e7682)

        [5.2.4. Specifying Sequences on the Command Line](ch05s02.html#d0e7705)

        [5.2.5. Applications for Basic Sequence Manipulation](ch05s02.html#d0e7731)

    [5.3. Introduction to Feature Formats](ch05s03.html)
    :   [5.3.1. What is a Feature?](ch05s03.html#d0e7918)

        [5.3.2. Supported Feature Formats](ch05s03.html#d0e7926)

        [5.3.3. How are Features Stored ?](ch05s03.html#d0e8139)

        [5.3.4. Applications for Features](ch05s03.html#d0e8183)

        [5.3.5. Specifying Features on the Command line](ch05s03.html#d0e8239)

    [5.4. Introduction to Alignment Formats](ch05s04.html)
    :   [5.4.1. What is an Alignment Format?](ch05s04.html#d0e8303)

        [5.4.2. Supported Alignment Formats](ch05s04.html#d0e8364)

        [5.4.3. Contents of an Alignment File](ch05s04.html#d0e8778)

        [5.4.4. Specifying Alignments on the Command Line](ch05s04.html#d0e8824)

        [5.4.5. Applications for Sequence Alignment](ch05s04.html#d0e8866)

    [5.5. Introduction to Report Formats](ch05s05.html)
    :   [5.5.1. What is a Report Format?](ch05s05.html#d0e9194)

        [5.5.2. Supported Report Formats](ch05s05.html#d0e9202)

        [5.5.3. Inside a Report](ch05s05.html#d0e9573)

        [5.5.4. Specifying Reports on the Command line](ch05s05.html#d0e9663)

        [5.5.5. Applications that use Reports](ch05s05.html#d0e9682)

[6. The EMBOSS Command Line](ch06.html)
:   [6.1. Introduction to the EMBOSS Command Line](ch06s01.html)
    :   [6.1.1. Finding and Running EMBOSS Applications](ch06s01.html#d0e9893)

        [6.1.2. Application Options](ch06s01.html#d0e9919)

        [6.1.3. Parameters and Qualifiers](ch06s01.html#d0e10032)

        [6.1.4. Datatype-specific Qualifiers](ch06s01.html#d0e10169)
        :   [6.1.4.1. Multiple Qualifiers](ch06s01.html#CmdLineIntroMultipleQualifiers)

            [6.1.4.2. Numbering Qualifiers](ch06s01.html#CmdLineIntroNumberingQualifiers)

        [6.1.5. Global Qualifiers](ch06s01.html#d0e10327)

        [6.1.6. Command line Styles](ch06s01.html#d0e10340)

        [6.1.7. Environment Variables](ch06s01.html#d0e10392)

    [6.2. Specifying Values for Application Options](ch06s02.html)
    :   [6.2.1. General Rules](ch06s02.html#d0e10432)

        [6.2.2. Simple ACD Datatypes](ch06s02.html#d0e10522)
        :   [6.2.2.1. Primitive Datatypes](ch06s02.html#d0e10527)

            [6.2.2.2. Other Simple Datatypes](ch06s02.html#d0e10645)

        [6.2.3. Input ACD Datatypes](ch06s02.html#d0e10735)
        :   [6.2.3.1. Sequence Input](ch06s02.html#d0e10743)

            [6.2.3.2. Feature Input](ch06s02.html#d0e10811)

            [6.2.3.3. Files and Directories](ch06s02.html#d0e10833)

            [6.2.3.4. Data Files](ch06s02.html#d0e10907)

            [6.2.3.5. Datatypes for **phylipnew** EMBASSY Package](ch06s02.html#d0e10981)

            [6.2.3.6. Other Biological Inputs](ch06s02.html#d0e11092)

        [6.2.4. Output ACD Datatypes](ch06s02.html#d0e11229)
   