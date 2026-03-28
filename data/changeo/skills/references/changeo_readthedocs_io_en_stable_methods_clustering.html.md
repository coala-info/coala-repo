[changeo
![Logo](../_static/changeo.png)](../index.html)

* [Immcantation Portal](http://immcantation.readthedocs.io)

Getting Started

* [Overview](../overview.html)
* [Download](../install.html)
* [Installation](../install.html#installation)
* [Contributing](../contributing.html)
* [Data Standards](../standard.html)
* [Release Notes](../news.html)

Usage Documentation

* [Commandline Usage](../usage.html)
* [API](../api.html)

Examples

* [Using IgBLAST](../examples/igblast.html)
* [Parsing IMGT output](../examples/imgt.html)
* [Parsing 10X Genomics V(D)J data](../examples/10x.html)
* [Filtering records](../examples/filtering.html)
* [Clustering sequences into clonal groups](../examples/cloning.html)
* [Reconstructing germline sequences](../examples/germlines.html)
* [Generating MiAIRR compliant GenBank/TLS submissions](../examples/genbank.html)

Methods

* Clonal clustering methods
  + [Clustering by V-gene, J-gene and junction length](#clustering-by-v-gene-j-gene-and-junction-length)
    - [Amino acid model](#amino-acid-model)
    - [Hamming distance model](#hamming-distance-model)
    - [Human and mouse 1-mer models](#human-and-mouse-1-mer-models)
    - [Human and mouse 5-mer models](#human-and-mouse-5-mer-models)
* [Reconstruction of germline sequences from alignment data](germlines.html)

About

* [Contact](../info.html)
* [Citation](../info.html#citation)
* [License](../info.html#license)

[changeo](../index.html)

* Clonal clustering methods
* [View page source](../_sources/methods/clustering.rst.txt)

---

# Clonal clustering methods[](#clonal-clustering-methods "Link to this heading")

The [DefineClones.py](../tools/DefineClones.html#defineclones) tool provides multiple different approaches to assigning
Ig sequences into clonal groups.

## Clustering by V-gene, J-gene and junction length[](#clustering-by-v-gene-j-gene-and-junction-length "Link to this heading")

All methods provided by [DefineClones.py](../tools/DefineClones.html#defineclones) first partition sequences based on
common IGHV gene, IGHJ gene, and junction region length. These groups are then
further subdivided into clonally related groups based on the following distance
metrics on the junction region. The specified distance metric
(`--model`) is then
used to perform hierarchical clustering under the specified linkage
(`--link`) clustering. Clonal groups are
defined by trimming the resulting dendrogram at the specified threshold
(`--dist`).

### Amino acid model[](#amino-acid-model "Link to this heading")

The `aa` distance model is the Hamming distance
between junction amino acid sequences.

### Hamming distance model[](#hamming-distance-model "Link to this heading")

The `ham` distance model is the Hamming
distance between junction nucleotide sequences.

### Human and mouse 1-mer models[](#human-and-mouse-1-mer-models "Link to this heading")

The `hh_s1f` and
`mk_rs5nf` distance models are single
nucleotide distance matrices derived from averaging and symmetrizing the human 5-mer
targeting model in [[YVanderHeidenU+13](#id11 "Gur Yaari, Jason A Vander Heiden, Mohamed Uduman, Daniel Gadala-Maria, Namita Gupta, Joel N H Stern, Kevin C O'Connor, David A Hafler, Uri Laserson, Francois Vigneault, and Steven H Kleinstein. Models of somatic hypermutation targeting and substitution based on synonymous mutations from high-throughput immunoglobulin sequencing data. Frontiers in immunology, 4:358, January 2013. URL: http://www.pubmedcentral.nih.gov/articlerender.fcgi?artid=3828525\&tool=pmcentrez\&rendertype=abstract, doi:10.3389/fimmu.2013.00358.")] and the mouse 5-mer targeting model in
[[CDiNiroVanderHeiden+16](#id12 "Ang Cui, Roberto Di Niro, Jason A. Vander Heiden, Adrian W. Briggs, Kris Adams, Tamara Gilbert, Kevin C. O'Connor, Francois Vigneault, Mark J. Shlomchik, and Steven H. Kleinstein. A Model of Somatic Hypermutation Targeting in Mice Based on High-Throughput Ig Sequencing Data. The Journal of Immunology, 197(9):3566–3574, nov 2016. URL: http://www.jimmunol.org/content/197/9/3566.abstract http://www.jimmunol.org/lookup/doi/10.4049/jimmunol.1502263, doi:10.4049/jimmunol.1502263.")]. The are broadly similar to a transition/transversion model.

Human 1-mer substitution matrix:

| Nucleotide | A | C | G | T | N |
| --- | --- | --- | --- | --- | --- |
| A | 0 | 1.21 | 0.64 | 1.16 | 0 |
| C | 1.21 | 0 | 1.16 | 0.64 | 0 |
| G | 0.64 | 1.16 | 0 | 1.21 | 0 |
| T | 1.16 | 0.64 | 1.21 | 0 | 0 |
| N | 0 | 0 | 0 | 0 | 0 |

Mouse 1-mer substitution matrix:

| Nucleotide | A | C | G | T | N |
| --- | --- | --- | --- | --- | --- |
| A | 0 | 1.51 | 0.32 | 1.17 | 0 |
| C | 1.51 | 0 | 1.17 | 0.32 | 0 |
| G | 0.32 | 1.17 | 0 | 1.51 | 0 |
| T | 1.17 | 0.32 | 1.51 | 0 | 0 |
| N | 0 | 0 | 0 | 0 | 0 |

### Human and mouse 5-mer models[](#human-and-mouse-5-mer-models "Link to this heading")

The `hh_s5f` and
`mk_rs5nf` distance models are based on
the human 5-mer targeting model in [[YVanderHeidenU+13](#id11 "Gur Yaari, Jason A Vander Heiden, Mohamed Uduman, Daniel Gadala-Maria, Namita Gupta, Joel N H Stern, Kevin C O'Connor, David A Hafler, Uri Laserson, Francois Vigneault, and Steven H Kleinstein. Models of somatic hypermutation targeting and substitution based on synonymous mutations from high-throughput immunoglobulin sequencing data. Frontiers in immunology, 4:358, January 2013. URL: http://www.pubmedcentral.nih.gov/articlerender.fcgi?artid=3828525\&tool=pmcentrez\&rendertype=abstract, doi:10.3389/fimmu.2013.00358.")] and mouse 5-mer
argeting models in [[CDiNiroVanderHeiden+16](#id12 "Ang Cui, Roberto Di Niro, Jason A. Vander Heiden, Adrian W. Briggs, Kris Adams, Tamara Gilbert, Kevin C. O'Connor, Francois Vigneault, Mark J. Shlomchik, and Steven H. Kleinstein. A Model of Somatic Hypermutation Targeting in Mice Based on High-Throughput Ig Sequencing Data. The Journal of Immunology, 197(9):3566–3574, nov 2016. URL: http://www.jimmunol.org/content/197/9/3566.abstract http://www.jimmunol.org/lookup/doi/10.4049/jimmunol.1502263, doi:10.4049/jimmunol.1502263.")], respectively. The targeting
matrix ![T](../_images/math/e8dea8254118f111b5fb20895b03528c17566f06.png) has 5-mers across the columns and the nucleotide to
which the center base of the 5-mer mutates as the rows. The value for a
given nucleotide, 5-mer pair ![T[i,j]](../_images/math/b40a549ad41eda2fc5b0b704307deba40dd1de03.png) is the product of the
likelihood of that 5-mer to be mutated ![mut(j)](../_images/math/113b53bffc095450be8e48338a994faa80940825.png) and the
likelihood of the center base mutating to the given nucleotide
![sub(j\rightarrow i)](../_images/math/26fb5e33bdf3c5b635715804058197c4c09ef151.png). This matrix of probabilities is converted
into a distance matrix ![D](../_images/math/0fcab9067b50b87e868c4fd70f213a086addb964.png) via the following steps:

1. ![D = -log10(T)](../_images/math/0d041f835d32b11179da9e985d599321c9fdfb60.png)
2. ![D](../_images/math/0fcab9067b50b87e868c4fd70f213a086addb964.png) is then divided by the mean of values in ![D](../_images/math/0fcab9067b50b87e868c4fd70f213a086addb964.png)
3. All distances in ![D](../_images/math/0fcab9067b50b87e868c4fd70f213a086addb964.png) that are infinite (probability of zero),
   distances on the diagonal (no change), and NA distances are set to 0.

Since the distance matrix ![D](../_images/math/0fcab9067b50b87e868c4fd70f213a086addb964.png) is not symmetric, the
`--sym` argument
can be specified to calculate either the average (avg) or minimum (min)
of ![D(j\rightarrow i)](../_images/math/87fba85ddeca14ba32b100f7fec87c44721a5ecb.png) and ![D(i\rightarrow j)](../_images/math/810fa10e39e9754b2e0e305f48ce0f5ca27a404b.png).
The distances defined by ![D](../_images/math/0fcab9067b50b87e868c4fd70f213a086addb964.png) for each nucleotide difference are
summed for all 5-mers in the junction to yield the distance between the
two junction sequences.

[CDiNiroVanderHeiden+16]
([1](#id2),[2](#id4))

Ang Cui, Roberto Di Niro, Jason A. Vander Heiden, Adrian W. Briggs, Kris Adams, Tamara Gilbert, Kevin C. O'Connor, Francois Vigneault, Mark J. Shlomchik, and Steven H. Kleinstein. A Model of Somatic Hypermutation Targeting in Mice Based on High-Throughput Ig Sequencing Data. *The Journal of Immunology*, 197(9):3566–3574, nov 2016. URL: [http://www.jimmunol.org/content/197/9/3566.abstract http://www.jimmunol.org/lookup/doi/10.4049/jimmunol.1502263](http://www.jimmunol.org/content/197/9/3566.abstract%20http%3A//www.jimmunol.org/lookup/doi/10.4049/jimmunol.1502263), [doi:10.4049/jimmunol.1502263](https://doi.org/10.4049/jimmunol.1502263).

[YVanderHeidenU+13]
([1](#id1),[2](#id3))

Gur Yaari, Jason A Vander Heiden, Mohamed Uduman, Daniel Gadala-Maria, Namita Gupta, Joel N H Stern, Kevin C O'Connor, David A Hafler, Uri Laserson, Francois Vigneault, and Steven H Kleinstein. Models of somatic hypermutation targeting and substitution based on synonymous mutations from high-throughput immunoglobulin sequencing data. *Frontiers in immunology*, 4:358, January 2013. URL: <http://www.pubmedcentral.nih.gov/articlerender.fcgi?artid=3828525\&tool=pmcentrez\&rendertype=abstract>, [doi:10.3389/fimmu.2013.00358](https://doi.org/10.3389/fimmu.2013.00358).

[Previous](../examples/genbank.html "Generating MiAIRR compliant GenBank/TLS submissions")
[Next](germlines.html "Reconstruction of germline sequences from alignment data")

---

© Copyright Kleinstein Lab, Yale University, 2025.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).