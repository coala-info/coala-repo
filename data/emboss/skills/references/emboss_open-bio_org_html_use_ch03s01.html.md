| 3.1. Application Documentation | | |
| --- | --- | --- |
| [Prev](ch03.html) | Chapter 3. Getting Started | [Next](ch03s02.html) |

---

## 3.1. Application Documentation

### 3.1.1. Online Documentation

As a user of EMBOSS you will need to familiarise yourself with the applications. Documentation is available for the application groups (see below), EMBASSY packages and, of course, the applications themselves. Documentation is available for the CVS (Developers) Release and major versions of the Stable Release:

CVS (Developers) Release
:   *<http://emboss.open-bio.org/rel/dev/apps/>*

Stable Release 6 Release
:   *<http://emboss.open-bio.org/rel/rel6/apps/>*

#### 3.1.1.1. Application Groups

All applications are organised into logical groups according to their function. For descriptions of the groups see [Section B.2, “Application Groups (release R6)”](apbs02.html "B.2. Application Groups (release R6)").

#### 3.1.1.2. EMBASSY Packages

An EMBASSY package groups together applications of related functionality that are kept separate from EMBOSS either for convenience or because difference licensing conditions are in effect. For descriptions of the packages see [Section B.3, “EMBASSY Packages (release R6)”](apbs03.html "B.3. EMBASSY Packages (release R6)").

#### 3.1.1.3. Applications

The documentation includes usage examples, which give the command line session and example input and output files for typical uses of the application. EMBOSS contains many applications and this can be daunting at first. A guide to navigating the documentation is given later ([Section 3.2, “Navigating the Application Documentation”](ch03s02.html "3.2. Navigating the Application Documentation")).

See the following tables:

* EMBOSS applications ([Section B.4, “EMBOSS Applications (release R6)”](apbs04.html "B.4. EMBOSS Applications (release R6)"))
* EMBASSY applications ([Section B.5, “EMBASSY Applications (release R6)”](apbs05.html "B.5. EMBASSY Applications (release R6)"))
* Applications organised by group ([Section B.6, “All Applications (by group)”](apbs06.html "B.6. All Applications (by group)"))

### 3.1.2. AJAX Command Definition (ACD) Language

Each application has a complete description of its command line interface given in its ACD (AJAX Command Definition) file. The ACD file defines all the information the application needs to run and how it will behave at the command line, It controls such things as default values and whether the user is prompted for parameter values. ACD files are written in the ACD language, designed specifically for EMBOSS.

Users of EMBOSS normally need not concern themselves with the ACD file at all. In some cases, especially where you want to customise the applications you use, for instance, changing default values or input sequence types, some familiarity with the syntax is very helpful. The syntax is described in detail in the *EMBOSS Developers Guide*.

### 3.1.3. Interfaces

There are many interfaces ([Section 7.1, “Introduction”](ch07s01.html "7.1. Introduction")) to EMBOSS which you might wish to use as an alternative to the command line. There are in-depth guides to two popular interfaces:

* **Jemboss** ([Chapter 9, *Using EMBOSS under JEMBOSS*](ch09.html "Chapter 9. Using EMBOSS under JEMBOSS"))
* **wEMBOSS** ([Chapter 8, *Using EMBOSS under WEMBOSS*](ch08.html "Chapter 8. Using EMBOSS under WEMBOSS"))

---

|  |  |  |
| --- | --- | --- |
| [Prev](ch03.html) | [Up](ch03.html) | [Next](ch03s02.html) |
| Chapter 3. Getting Started | [Home](index.html) | 3.2. Navigating the Application Documentation |