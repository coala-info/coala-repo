1. [Captus](/captus.docs/) >
2. [Assembly](/captus.docs/assembly/) >
3. Assemble

# Assemble

The next step in the workflow is to perform *de novo* assembly with [`MEGAHIT`](https://github.com/voutcn/megahit) on the cleaned reads. Once the reads have been assembled into contigs, depth of coverage is calculated using [`Salmon`](https://github.com/COMBINE-lab/salmon). `Captus` makes it easy to process many samples in a consistent manner, automatically, and providing a comprehensive [Assembly Control HTML report](https://edgardomortiz.github.io/captus.docs/assembly/assemble/report/).

`MEGAHIT` is an extremely fast and robust *de novo* assembler that is very memory-efficient thanks to the use of a new data structure called succint De Bruijn Graph (sDBG). Most importantly, accuracy is not sacrificed because it was originally designed for assembling metagenomes. Since then, it has been shown to be an excellent generalist assembler as well.

If you are analyzing data with extremely high sequencing depth, or you are trying out parameters and want a quick result, `Captus` can subsample a fixed number of reads prior to assembly.

`MEGAHIT` only provides a quick estimation of contig depth of coverage, therefore we use `Salmon` to rapidly and accurately calculate the depth of coverage of each contig. Afterwards, contigs with little evidence (by default <1.5x) are automatically filtered.

If you assemble your reads in `Captus` you can also filter the contigs by GC content. For example, remove contigs with >60% GC will remove mostly bacterial contigs. The filtering by GC content and/or by depth of coverage can be repeated multiple times without needing to repeat the assembly and depth of coverage estimation steps.

`Captus` allows you the flexibility to also provide pre-assembled samples. However, we recommend that, whenever you have read data, to assemble it using `Captus`. For transcriptome assemblies for example, other assemblers will produce lots of redundant contigs (due to isoforms, alleles, etc.) which `MEGAHIT` tends to collapse into a single contig. This is ideal for phylogenomics (and perhaps also to build non-redundant reference transcriptomes).

* [Input Preparation](/captus.docs/assembly/assemble/preparation/)
* [Options](/captus.docs/assembly/assemble/options/)
* [Output Files](/captus.docs/assembly/assemble/output/)
* [HTML Report](/captus.docs/assembly/assemble/report/)

Note

In case you assembled your reads elsewhere or you want to use only pre-assembled genomes (e.g., downloaded from GenBank), you can jump ahead to the [`extract` command](https://edgardomortiz.github.io/captus.docs/assembly/extract/) page.

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