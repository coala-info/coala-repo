1. [Captus](/captus.docs/) >
2. [Assembly](/captus.docs/assembly/) >
3. [Clean](/captus.docs/assembly/clean/) >
4. Input Preparation

# Input Preparation

Note

Before starting your analysis, a  **VERY IMPORTANT** step is to rename your FASTQ files so they clearly identify your samples throughout the entire analysis.

In general, a good tip for renaming your samples is to think on how you want the names in your final phylogenetic tree.

The only special characters that are safe to use in the sample name are `-`, and `_` (`_` is commonly used to replace spaces in many phylogenetic programs). Otherwise, do not use spaces, other special characters (`` ! " # $ % & ( ) * + , . / : ; < = > ? @ [ \ ] ^ ` { | } ~ ``), or accented letters (like `á`, `è`, `ü`, `ç`, `ñ`), they are just guaranteed to give you headaches at some point.

Also, please use this naming convention for your FASTQ files:

![Naming convention for FASTQ files](/captus.docs/images/fastq.png?width=600)

* **IMPORTANT:** Even though underscores (`_`) are allowed in sample names, please **DO NOT** use more than **ONE** consecutive `_` in any case. We use double underscores (`__`) internally to separate several pieces of information during the processing and for the output (see for example [the FASTA headers of extracted markers](/captus.docs/assembly/extract/output/#fasta-headers-explanation)).
* Any text found before the **\_R#** pattern and the **extension** will become your **sample name** (`Pouteria_lucuma_EO9854` in this case).
* If you are using **paired-end** reads, your R1 and R2 filenames should contain the patterns `_R1` and `_R2` respectively to be correctly matched and used as pairs. For **single-end** your filenames should still contain `_R1`.
* These are the valid extensions: `.fq`, `.fastq`, `.fq.gz`, and `.fastq.gz`.

These are examples of **valid** FASTQ filenames for `Captus`:

* `Arabidopsis_thaliana_R1.fq.gz` and `Arabidopsis_thaliana_R2.fq.gz`, these will be correctly taken as a pair
* `Mus_musculus_GX763763_R1.fastq`, if its corresponding R2 is not found it will be used as single-end
* `ERI_Demosthenesia_mandonii_EO2765_R1.fastq.gz` and `ERI_Demosthenesia_mandonii_EO2765_R2.fastq.gz`
* `A_R1.fq` and `A_R2.fq`

And here, some examples or **invalid** FASTQ filenames:

* `ERR246535_1.fastq.gz` and `ERR246535_2.fastq.gz`, notice they lack the `_R1` and `_R2` patterns in the names, `Captus` is not able to match these as a pair
* `Octomeles_sp.1_R1.fastq`, it is better to replace the `.` in the sample name by a `-` to get `Octomeles_sp-1_R1.fastq`
* `Malus_doméstica.fast`, the sample name contains and accent `é`, but most importantly, it will be ignored because of the invalid extension `.fast`

---

Created by [Edgardo M. Ortiz](https://edgardomortiz.github.io/captus.docs/more/credits/#edgardo-m-ortiz) (06.08.2021)
Last modified by [Edgardo M. Ortiz](https://edgardomortiz.github.io/captus.docs/more/credits/#edgardo-m-ortiz) (30.05.2022)

[![](/captus.docs/images/logo.svg)](/)

Search

* [Home](/captus.docs/)

* [ ] Submenu Basics[Basics](/captus.docs/basics/)
  + [Overview](/captus.docs/basics/overview/)
  + [Installation](/captus.docs/basics/installation/)
  + [Parallelization](/captus.docs/basics/parallelization/)
* [x] Submenu Assembly[Assembly](/captus.docs/assembly/)
  + [x] Submenu Clean[**1.** Clean](/captus.docs/assembly/clean/)
    - [Input Preparation](/captus.docs/assembly/clean/preparation/)
    - [Options](/captus.docs/assembly/clean/options/)
    - [Output Files](/captus.docs/assembly/clean/output/)
    - [HTML Report](/captus.docs/assembly/clean/report/)
  + [x] Submenu Assemble[**2.** Assemble](/captus.docs/assembly/assemble/)
    - [Input Preparation](/captus.docs/assembly/assemble/preparation/)
    - [Options](/captus.docs/assembly/assemble/options/)
    - [Output Files](/captus.docs/assembly/assemble/output/)
    - [HTML Report](/captus.docs/assembly/assemble/report/)
  + [x] Submenu Extract[**3.** Extract](/captus.docs/assembly/extract/)
    - [Input Preparation](/captus.docs/assembly/extract/preparation/)
    - [Options](/captus.docs/assembly/extract/options/)
    - [Output Files](/captus.docs/assembly/extract/output/)
    - [HTML Report](/captus.docs/assembly/extract/report/)
  + [x] Submenu Align[**4.** Align](/captus.docs/assembly/align/)
    - [Options](/captus.docs/assembly/align/options/)
    - [Output Files](/captus.docs/assembly/align/output/)
    - [HTML Report](/captus.docs/assembly/align/report/)
* [Design](/captus.docs/design/)
* [ ] Submenu Tutorials[Tutorials](/captus.docs/tutorials/)
  + [Basic](/captus.docs/tutorials/basic/)
  + [Advanced](/captus.docs/tutorials/advanced/)

More

* [GitHub repo](https://github.com/edgardomortiz/Captus)
* [Credits](/captus.docs/more/credits)

---

* Language
* Theme

  Green
* Clear History

[Download](https://github.com/edgardomortiz/Captus/archive/master.zip)
[Star](https://github.com/edgardomortiz/Captus)
[Fork](https://github.com/edgardomortiz/Captus/fork)

Built with  by [Hugo](https://gohugo.io/)