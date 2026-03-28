[Intervene](index.html)

latest

Table of contents

* [Introduction](introduction.html)
* [Installation](install.html)
* [How to use Intervene](how_to_use.html)
* [Intervene modules](modules.html)
* Example gallery
  + [Venn module examples](#venn-module-examples)
  + [UpSet module examples](#upset-module-examples)
  + [Pairwise module examples](#pairwise-module-examples)
* [Interactive Shiny App](shinyapp.html)
* [Support](support.html)
* [Citation](cite.html)
* [Changelog](changelog.html)

[Intervene](index.html)

* [Docs](index.html) »
* Example gallery
* [Edit on GitHub](https://github.com/asntech/intervene/blob/master/docs/examples.rst)

---

# Example gallery[¶](#example-gallery "Permalink to this headline")

Here we provide some examples of how Intervene can be used to generate different types of set intersection plots.

## Venn module examples[¶](#venn-module-examples "Permalink to this headline")

In this example, a 3-way Venn diagram of ChIP-seq peaks of histone modifications (H3K27ac, H3Kme3 and H3K27me3) in hESC from ENCODE data (Dunham et al., 2012).

```
intervene venn -i ~/ENCODE/data/H3K27ac.bed ~/ENCODE/data/H3Kme3.bed ~/ENCODE/data/H3K27me3.bed --filenames
```

[![3-way Venn diagram](_images/venn3way.png)](_images/venn3way.png)

By adding one more BED file to `-i` argument, Intervene will generate a 4-way Venn diagram of overlap of ChIP-seq peaks.

```
intervene venn -i ~/ENCODE/data/H3K27ac.bed ~/ENCODE/data/H3Kme3.bed ~/ENCODE/data/H3K27me3.bed  ~/ENCODE/data/H3Kme2.bed --filenames
```

[![4-way Venn diagram](_images/venn4way.png)](_images/venn4way.png)

Read more about the `venn` diagrams module here:

```
intervene venn --help
```

## UpSet module examples[¶](#upset-module-examples "Permalink to this headline")

In this example, a UpSet plot of ChIP-seq peaks of four histone modifications (H3K27ac, H3Kme3 H3Kme2, and H3K27me3) in hESC from ENCODE data (Dunham et al., 2012).

```
intervene upset -i ~/ENCODE/data/H3K27ac.bed ~/ENCODE/data/H3Kme3.bed ~/ENCODE/data/H3K27me3.bed ~/ENCODE/data/H3Kme2.bed --filenames
```

[![UpSet plot](_images/upset4.png)](_images/upset4.png)

Read more about the `upset` module:

```
intervene upset --help
```

## Pairwise module examples[¶](#pairwise-module-examples "Permalink to this headline")

In this example, we performed a pairwise intersections of super-enhancers in 24 mouse cell and tissue types from dbSUPER (Khan and Zhang, 2016) and showed the fraction of overlap in heatmap.

```
intervene pairwise -i ~/dbSUPER/mm9/*.bed --filenames --compute frac --htype pie
```

[![Pairwise heatmap](_images/pairwise_pie.png)](_images/pairwise_pie.png)

By setting the `--htype` to `color` will produce this plot.

```
intervene pairwise -i ~/dbSUPER/mm9/*.bed --filenames --compute frac --htype color
```

[![Pairwise heatmap](_images/pairwise_color.png)](_images/pairwise_color.png)

By setting the `--htype` to `tribar` will produce a triangular heatmap and with a bar-plot of set sizes.

```
intervene pairwise -i ~/dbSUPER/mm9/*.bed --filenames --compute frac --htype tribar
```

[![Pairwise heatmap](_images/pairwise_tribar.png)](_images/pairwise_tribar.png)

Note

Please make sure that the `tribar` will only show lower triangle of the matrix as heatmap and diagoals are set to zero. It recommended to use this if ``` --compute is set to ``jaccard ```, `fisher` or `reldist`.

Read more about the `pairwise` module here:

```
intervene pairwise --help
```

[Next](shinyapp.html "Interactive Shiny App")
 [Previous](modules.html "Intervene modules")

---

© Copyright 2017, Aziz Khan.
Revision `d7c77661`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/snide/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).