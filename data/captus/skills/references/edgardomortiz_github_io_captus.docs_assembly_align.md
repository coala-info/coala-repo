1. [Captus](/captus.docs/) >
2. [Assembly](/captus.docs/assembly/) >
3. Align

# Align

The last step in the `Captus` workflow is to align the extracted markers so you can estimate phylogenetic trees with your favorite tool (e.g., `IQ-TREE`, `RAxML`, `MrBayes`, `SVDQuartets`, etc.).
`Captus` starts this step by gathering all the markers across your extracted samples and building a FASTA file per marker. Then, it will add the references used during extraction, these are useful to improve alignment since they serve as guides. Then `Captus` aligns the files using `MAFFT` or `MUSCLE`, however, if you choose to align coding sequence in aminoacid (`AA`) and nucleotide (`NT`) in the same run, `Captus` will first align the `AA` version with `MAFFT` or `MUSCLE` and then use that alignment as template to align the `NT` version, thus producing an codon-aware alignment of the coding sequence in nucleotides. Once alignment is completed, paralogs are filtered. Finally, during the trimming stage, Captus removes erroneous stretches of aligned sequences using `TAPER` and then the gappy columns are removed with `ClipKIT` (but you can any other `ClipKIT`’s filtering strategy) as well as exceptionally short sequences which tend to decrease phylogenetic accuracy.
At the end, `Captus` provides several alignment formats from which you can choose the most appropriate for your needs as well as a comprehensive HTML report summarizing alignment statistics along the multiple stages of the `align` step.

* [Options](/captus.docs/assembly/align/options/)
* [Output Files](/captus.docs/assembly/align/output/)
* [HTML Report](/captus.docs/assembly/align/report/)

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