1. [Captus](/captus.docs/) >
2. [Assembly](/captus.docs/assembly/) >
3. Extract

# Extract

The next step in the workflow is to search markers within the assemblies and extract them. For that you need to provide `Captus` reference sequence(s) of the marker(s) you want to extract. You can provide coding sequences in either nucleotide or aminoacid, in this case, protein extraction will be performed with [`Scipio`](https://www.webscipio.org/). One key advantage of `Scipio` is its ability of reconstructing gene models (i.e., exons + introns) from separate contigs in highly fragmented assemblies, which are not uncommon when analyzing hybridization capture or genome skimming data.
If you want to extract any other DNA marker (entire genes with introns, ribosomal genes, non-coding regions, RAD reference loci, etc.) you provide your reference(s) in nucleotide format, in this case the extraction is performed using [`BLAT`](http://hgdownload.soe.ucsc.edu/admin/exe/) and our own code to stitch and extract partial hits if necessary in an analogous fashion to `Scipio`’s method.

* [Input Preparation](/captus.docs/assembly/extract/preparation/)
* [Options](/captus.docs/assembly/extract/options/)
* [Output Files](/captus.docs/assembly/extract/output/)
* [HTML Report](/captus.docs/assembly/extract/report/)

---

Created by [Edgardo M. Ortiz](https://edgardomortiz.github.io/captus.docs/more/credits/#edgardo-m-ortiz) (06.08.2021)
Last modified by [Gentaro Shigita](https://edgardomortiz.github.io/captus.docs/more/credits/#gentaro-shigita) (12.05.2025)

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