| EMBOSS Developers Guide | | |
| --- | --- | --- |
|  |  | [Next](pr01.html) |

---

# [EMBOSS Developers Guide](http://www.cambridge.org/gb/knowledge/isbn/item5979293/?site_locale=en_GB)

## Bioinformatics Programming

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

### Dr. Alan Bleasby

Senior Scientific Officer
EMBL European Bioinformatics Institute

EMBL-EBI, Wellcome Trust Genome Campus, Hinxton, Cambridge, CB10 1SD, UK

`<ajb@ebi.ac.uk>`

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

    [2. *EMBOSS Developers Guide* Acknowledgements](pr01s02.html)

[Preface](pr02.html)
:   [1. Introduction to EMBOSS](pr02s01.html)

    [2. Developing EMBOSS](pr02s02.html)

    [3. Key Features for Developers](pr02s03.html)
    :   [3.1. Support for developers](pr02s03.html#d0e466)

        [3.2. C programming library development](pr02s03.html#d0e527)

    [4. About the Authors](pr02s04.html)

    [5. How To Cite EMBOSS](pr02s05.html)

[Conventions](pr03.html)
:   [1. Command Line Sessions and Commands](pr03s01.html)

    [2. Program Listings and Code](pr03s02.html)

    [3. Other Conventions](pr03s03.html)

    [4. Special Text Blocks](pr03s04.html)

[Welcome to the *EMBOSS Developers Manual*](pr04.html)
:   [1. Chapter 1. Getting Started](pr04s01.html)

    [2. Chapter 2. Your First EMBOSS Application](pr04s02.html)

    [3. Chapter 3. Software Development under EMBOSS](pr04s03.html)

    [4. Chapter 4. ACD File Development](pr04s04.html)

    [5. Chapter 5. C Programming](pr04s05.html)

    [6. Chapter 6. Programming with AJAX](pr04s06.html)

    [7. Chapter 7. Quality Assurance](pr04s07.html)

    [8. Chapter 8. Application Documentation](pr04s08.html)

    [9. Chapter 9. A Complete Application](pr04s09.html)

    [10. Chapter 10. Incorporating Third-party Applications](pr04s10.html)

    [11. Appendix A. ACD Syntax Reference](pr04s11.html)

    [12. Appendix B. Libraries Reference](pr04s12.html)

    [13. Appendix C. C Coding Standards](pr04s13.html)

    [14. Appendix D. Code Documentation Standards](pr04s14.html)

    [15. Appendix E. Resources](pr04s15.html)

[1. Getting Started](ch01.html)
:   [1.1. Licence Information](ch01s01.html)
    :   [1.1.1. GPL](ch01s01.html#d0e972)

        [1.1.2. LGPL](ch01s01.html#d0e985)

        [1.1.3. Licensing under EMBASSY](ch01s01.html#d0e990)

    [1.2. Installation of CVS (Developers) Release](ch01s02.html)
    :   [1.2.1. Downloading via CVS](ch01s02.html#d0e1082)

        [1.2.2. Keeping up-to-date with CVS](ch01s02.html#d0e1185)

        [1.2.3. Configuration](ch01s02.html#d0e1197)

        [1.2.4. Compilation](ch01s02.html#d0e1388)
        :   [1.2.4.1. Static and Dynamic Compilation](ch01s02.html#d0e1472)

        [1.2.5. Setting your `PATH`](ch01s02.html#d0e1524)

        [1.2.6. Testing all is Well](ch01s02.html#d0e1608)

        [1.2.7. Database Setup](ch01s02.html#d0e1624)

        [1.2.8. EMBASSY Packages](ch01s02.html#d0e1716)

    [1.3. Developer Documentation](ch01s03.html)
    :   [1.3.1. Application Documentation](ch01s03.html#d0e1875)

        [1.3.2. Library Documentation](ch01s03.html#d0e1896)
        :   [1.3.2.1. AJAX Library Documentation](ch01s03.html#d0e1903)

            [1.3.2.2. NUCLEUS Library Documentation](ch01s03.html#d0e1924)

        [1.3.3. Navigating the Libraries](ch01s03.html#d0e1946)
        :   [1.3.3.1. Library File Documentation](ch01s03.html#d0e2001)

            [1.3.3.2. Function Documentation](ch01s03.html#d0e2057)

            [1.3.3.3. Object (C data Structure) Documentation](ch01s03.html#d0e2157)

        [1.3.4. The Source Code](ch01s03.html#d0e2236)
        :   [1.3.4.1. Navigating the Source Code using SRS](ch01s03.html#d0e2255)

        [1.3.5. Demonstration Applications](ch01s03.html#d0e2651)

        [1.3.6. Programming Guides](ch01s03.html#d0e2674)

        [1.3.7. AJAX Command Definition (ACD) Developers Guide and Syntax](ch01s03.html#d0e2682)

        [1.3.8. C Coding Standards and Guidelines](ch01s03.html#d0e2694)

        [1.3.9. Quality Assurance Guidelines](ch01s03.html#d0e2702)

        [1.3.10. Code and Application Documentation Standards](ch01s03.html#d0e2712)

        [1.3.11. EMBOSS Software Development Course](ch01s03.html#d0e2722)

    [1.4. Project Mailing Lists](ch01s04.html)
    :   [1.4.1. User Mailing List](ch01s04.html#d0e2753)

        [1.4.2. Developer Mailing List](ch01s04.html#d0e2766)

        [1.4.3. Announcements Mailing List](ch01s04.html#d0e2785)

        [1.4.4. Mail Archives](ch01s04.html#d0e2798)
        :   [1.4.4.1. User Mailing List Archive](ch01s04.html#d0e2803)

            [1.4.4.2. Developer Mailing List Archive](ch01s04.html#d0e2814)

    [1.5. Contributing Software to EMBOSS](ch01s05.html)
    :   [1.5.1. Please Submit your Code!](ch01s05.html#d0e2850)

        [1.5.2. Types of Code Submission](ch01s05.html#d0e2872)

        [1.5.3. Known Required Developments](ch01s05.html#d0e2900)
        :   [1.5.3.1. EMBOSS Feature Requests and Bug Reports](ch01s05.html#d0e2913)

[2. Your First EMBOSS Application](ch02.html)
:   [2.1. **helloworld** in C](ch02s01.html)

    [2.2. **helloworld** in EMBOSS](ch02s02.html)
    :   [2.2.1. Planning and Design](ch02s02.html#d0e3137)

        [2.2.2. Writing the ACD File](ch02s02.html#d0e3157)

        [2.2.3. Testing the ACD file](ch02s02.html#d0e3234)

        [2.2.4. Writing the Source Code](ch02s02.html#d0e3283)

        [2.2.5. Integration (Adding the Application to EMBOSS)](ch02s02.html#d0e3551)

        [2.2.6. Compilation](ch02s02.html#d0e3689)

        [2.2.7. Debugging](ch02s02.html#d0e3750)

        [2.2.8. Testing](ch02s02.html#d0e3758)

        [2.2.9. Documentation](ch02s02.html#d0e3766)

    [2.3. Modifying **helloworld**](ch02s03.html)
    :   [2.3.1. Modifying the ACD File](ch02s03.html#d0e3801)

        [2.3.2. Modifying the C Source Code](ch02s03.html#d0e3832)

        [2.3.3. Running the Program](ch02s03.html#d0e3922)

        [2.3.4. Qualifiers and Parameters](ch02s03.html#d0e3972)

        [2.3.5. Adding an Integer](ch02s03.html#d0e3999)

        [2.3.6. Parameters and Qualifiers Revisited](ch02s03.html#d0e4022)

    [2.4. Modifying **matcher**](ch02s04.html)
    :   [2.4.1. Planning](ch02s04.html#d0e4102)

        [2.4.2. Editing the ACD Files](ch02s04.html#d0e4178)

        [2.4.3. Editing the C Source File](ch02s04.html#d0e4443)

        [2.4.4. Compilation](ch02s04.html#d0e4577)

        [2.4.5. Testing All Is Well](ch02s04.html#d0e4599)

        [2.4.6. Further Developments](ch02s04.html#d0e4648)

    [2.5. String Handling](ch02s05.html)
    :   [2.5.1. `stringplay.acd`](ch02s05.html#d0e4731)

        [2.5.2. `stringplay.c`](ch02s05.html#d0e4877)

        [2.5.3. Compilation and Testing](ch02s05.html#d0e4894)

        [2.5.4. Adding Functionality](ch02s05.html#d0e4921)
        :   [2.5.4.1. String Memory Management](ch02s05.html#d0e4981)

[3. Software Development under EMBOSS](ch03.html)
:   [3.1. EMBOSS Programming](ch03s01.html)
    :   [3.1.1. Introduction](ch03s01.html#d0e5075)

        [3.1.2. Inbuilt Functionality](ch03s01.html#DevSoftwareDevelopmentInbuiltFunctionality)
        :   [3.1.2.1. Support for Biological Datatypes](ch03s01.html#d0e5105)

            [3.1.2.2. Support for Common File Formats](ch03s01.html#d0e5112)

            [3.1.2.3. Simple Database Configuration](ch03s01.html#d0e5120)

            [3.1.2.4. Command Line Handling](ch03s01.html#d0e5128)

            [3.1.2.5. Command Line Qualifiers](ch03s01.html#d0e5136)

            [3.1.2.6. Sequence and Sequence Feature Specification](ch03s01.html#d0e5150)

        [3.1.3. Before you start Coding](ch03s01.html#d0e5159)

        [3.1.4. Basic Steps to Development](ch03s01.html#d0e5236)

        [3.1.5. Project Management](ch03s01.html#d0e5275)
        :   [3.1.5.1. Models for Releasing Software](ch03s01.html#d0e5280)

            [3.1.5.2. Software Life Cycle Models](ch03s01.html#d0e5351)

            [3.1.5.3. User Requirements](ch03s01.html#d0e5435)

        [3.1.6. Planning](ch03s01.html#d0e5485)
        :   [3.1.6.1. Application Development](ch03s01.html#d0e5492)

            [3.1.6.2. Library Development](ch03s01.html#d0e5616)

        [3.1.7. ACD File Development](ch03s01.html#d0e5643)

        [3.1.8. C Source Code Development](ch03s01.html#d0e5680)
        :   [3.1.8.1. Coding Standards](ch03s01.html#d0e5683)

            [3.1.8.2. Application Development](ch03s01.html#d0e5692)

            [3.1.8.3. Library Development](ch03s01.html#d0e5775)

        [3.1.9. Integration and Compilation](ch03s01.html#d0e5854)

        [3.1.10. Debugging](ch03s01.html#d0e5897)

        [3.1.11. Quality Assurance Testing](ch03s01.html#d0e5905)

        [3.1.12. Documentation](ch03s01.html#d0e5921)

        [3.1.13. Distribution](ch03s01.html#d0e5941)

        [3.1.14. Maintenance, Support and Training](ch03s01.html#d0e5947)

    [3.2. Integration and Compilation](ch03s02.html)
    :   [3.2.1. Using **myemboss** for Application Development](ch03s02.html#DevIntegrationMyemboss)

        [3.2.2. Adding New EMBOSS Applications](ch03s02.html#d0e6099)

        [3.2.3. Adding New EMBASSY Applications](ch03s02.html#d0e6177)

        [3.2.4. Adding a New EMBASSY Package](ch03s02.html#d0e6186)
        :   [3.2.4.1. Directory Structure](ch03s02.html#d0e6217)

            [3.2.4.2. Editing the `Makefile.am` Files](ch03s02.html#d0e6428)

            [3.2.4.3. Editing the `configure.in` Files](ch03s02.html#DevIntegrationEditConfig)

        [3.2.5. Adding New Functions and Datatypes](ch03s02.html#d0e6609)

        [3.2.6. Adding New Library Files](ch03s02.html#d0e6631)

    [3.3. Debugging](ch03s03.html)
    :   [3.3.1. Direct Debugging](ch03s03.html#d0e6699)

        [3.3.2. AJAX Debugging Functions](ch03s03.html#d0e6830)

        [3.3.3. Controlling Debugging Behaviour](ch03s03.html#d0e6843)

        [3.3.4. Debuggers](ch03s03.html#d0e6930)

        [3.3.5. Tracing Memory Problems](ch03s03.html#d0e6984)

[4. ACD File Development](ch04.html)
:   [4.1. Introduction to ACD File Development](ch04s01.html)
    :   [4.1.1. ACD Files](ch04s01.html#d0e7059)

        [4.1.2. ACD General Syntax](ch04s01.html#ACDDevIntroGeneralSyntax)
        :   [4.1.2.1. ACD File Names](ch04s01.html#d0e7101)

            [4.1.2.2. Whitespace](ch04s01.html#d0e7128)

            [4.1.2.3. Comments](ch04s01.html#d0e7139)

        [4.1.3. ACD Definitions](ch04s01.html#ACDDevIntroDefinitions)

        [4.1.4. Parameters and Qualifiers](ch04s01.html#ACDDevIntroParametersQualifiers)
        :   [4.1.4.1. Prompting Behaviour and Default Values](ch04s01.html#d0e7432)

            [4.1.4.2. Help Information](ch04s01.html#d0e7457)

            [4.1.4.3. Examples](ch04s01.html#d0e7466)

        [4.1.5. ACD File Sections](ch04s01.html#ACDDevIntroSections)
        :   [4.1.5.1. Sections in an ACD File](ch04s01.html#d0e7563)

            [4.1.5.2. Input section](ch04s01.html#d0e7604)

            [4.1.5.3. Required section](ch04s01.html#d0e7611)

            [4.1.5.4. Additional section](ch04s01.html#d0e7631)

            [4.1.5.5. Advanced section](ch04s01.html#d0e7642)

            [4.1.5.6. Output section](ch04s01.html#d0e7662)

            [4.1.5.7. Example](ch04s01.html#d0e7669)

            [4.1.5.8. Standard File Sections (`sections.standard` file)](ch04s01.html#ACDDevIntroStandardFileSections)

    [4.2. Application Definition](ch04s02.html)
    :   [4.2.1. Application Definition Format](ch04s02.html#ApplicationDefinition)

        [4.2.2. Application Attributes](ch04s02.html#ACDDevApplicationAttributes)

        [4.2.3. Application Documentation](ch04s02.html#d0e7860)
        :   [4.2.3.1. Application Keywords File (`keywords.standard`)](ch04s02.html#d0e7892)

        [4.2.4. Application Groups](ch04s02.html#d0e7921)
        :   [4.2.4.1. Application Group Names File (`groups.standard`)](ch04s02.html#d0e7970)

    [4.3. Data Definition](ch04s03.html)
    :   [4.3.1. Data Definition Format](ch04s03.html#d0e8101)

        [4.3.2. Parameter Naming Conventions](ch04s03.html#ACDDevDataDefinitionParameterNaming)

        [4.3.3. ACD Datatypes](ch04s03.html#ACDDevDataDefinitionDatatypes)
        :   [4.3.3.1. Groupings of ACD Datatypes](ch04s03.html#d0e8287)

            [4.3.3.2. Simple ACD Datatypes](ch04s03.html#d0e8313)

            [4.3.3.3. Input ACD Datatypes](ch04s03.html#d0e8385)

            [4.3.3.4. Output ACD Datatypes](ch04s03.html#d0e8609)

            [4.3.3.5. Selection ACD Datatypes](ch04s03.html#d0e8862)

            [4.3.3.6. Graphics ACD Datatypes](ch04s03.html#d0e8889)

        [4.3.4. Types of Data Attributes](ch04s03.html#ACDDevDataDefinitionTypesDataAttributes)

        [4.3.5. Global Attributes](ch04s03.html#ACDDevDataDefinitionGlobalAttributes)
        :   [4.3.5.1. Parameters and Qualifiers](ch04s03.html#d0e9029)

            [4.3.5.2. User Prompting](ch04s03.html#d0e9163)

            [4.3.5.3. Datatype Definition](ch04s03.html#d0e9287)

            [4.3.5.4. Help Information and Documentation](ch04s03.html#d0e9375)

            [4.3.5.5. Hints for GUIs](ch04s03.html#d0e9463)

            [4.3.5.6. For use by SOAPLAB](ch04s03.html#d0e9484)

        [4.3.6. Datatype-specific Attributes](ch04s03.html#ACDDevDataDefinitionDataAttributes)
        :   [4.3.6.1. Attributes for Simple ACD Datatypes](ch04s03.html#ACDDevDataDefinitionSimple)

            [4.3.6.2. Attributes for Input ACD Datatypes](ch04s03.html#ACDDevDataDefinitionInput)

            [4.3.6.3. Attributes for Output ACD Datatypes](ch04s03.html#ACDDevDataDefinitionOutput)

            [4.3.6.4. Attributes for Selection ACD Datatypes](ch04s03.html#ACDDevDataDefinitionSelection)

            [4.3.6.5. Attributes for Graphics ACD Datatypes](ch04s03.html#ACDDevDataDefinitionGraphics)

        [4.3.7. Attributes for Datatype-associated Qualifiers](ch04s03.html#ACDDevDataDefinitionQualifierAttributes)

        [4.3.8. Introduction to Calculated Attributes](ch04s03.html#ACDDevDataDefinitionCalculatedAttributes)
        :   [4.3.8.1. Retrieving Values of Calculated Attributes](ch04s03.html#d0e10349)

            [4.3.8.2. Sequence Calculated Attributes](ch04s03.html#d0e10400)

            [4.3.8.3. Feature Calculated Attributes](ch04s03.html#d0e10602)

    [4.4. Operations](ch04s04.html)
    :   [4.4.1. Types of Operation](ch04s04.html#d0e10806)

        [4.4.2. General Operation Syntax](ch04s04.html#d0e10834)
        :   [4.4.2.1. Arithmetic Operators](ch04s04.html#d0e10869)

   