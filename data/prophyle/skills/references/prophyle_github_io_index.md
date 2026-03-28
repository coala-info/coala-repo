* Home
* [Get it](install.html)
* [Docs](contents.html)
* [Extend/Develop](http://github.com/prophyle/prophyle)

ProPhyle

DNA sequence classification

### Navigation

* [index](genindex.html "General Index")
* ProPhyle home |
* [Documentation](contents.html) »
* ProPhyle: DNA sequence classification

### Download

Current version: **[0.3.3.2](https://github.com/prophyle/prophyle/releases/tag/0.3.3.2)**

Get ProPhyle from the [Python Package
Index](https://pypi.python.org/pypi/prophyle), install it with:

```
pip install -U prophyle
```

or from [BioConda](http://bioconda.github.io), install it with

```
conda install prophyle
```

or from [Zenodo](http://doi.org/10.5281/zenodo.1045429).

### Questions? Suggestions?

Join the [ProPhyle](http://groups.google.com/group/prophyle) mailing list on Google Groups:

You can also open an issue at the
[tracker](https://github.com/prophyle/prophyle/issues).

### Quick search

# Welcome to ProPhyle

ProPhyle brings metagenomic classification **from clusters to laptops**. This is possible thanks to a novel indexing strategy,
based on the bottom-up propagation of k-mers in the phylogenetic/taxonomic tree, assembling contigs at each node and matching using a full-text search.

Compared to other state-of-the-art classifiers, ProPhyle provides several unique features:
![](_static/prophyle_overview.jpg)

* **Low memory requirements.** Compared to Kraken, ProPhyle has 7x smaller memory footprint for index construction and 5x smaller footprint for querying, while providing a more expressive index.
* **Flexibility.** ProPhyle is easy to use with any user-provided phylogenetic trees and reference genomics sequences (e.g., reads or assemblies). It can classify short reads, long reads, or even assembled contigs.
* **Standard bioinformatics formats.** Newick/NHX is used for representing phylogenetic trees and SAM/BAM for reporting assignments.
* **Lossless k-mer indexing.** ProPhyle stores a list of all genomes containing a k-mer. The classification is, therefore, accurate even with trees containing similar genomes (e.g, phylogenetic trees for a single species).
* **Reproducibility.** ProPhyle is fully deterministic, with a mathematically well-defined behavior. Databases are versioned and distributed via Zenodo.

## Documentation

|  |  |
| --- | --- |
| [Quick example](example.html)  5 minutes example | [Contents](contents.html)  for a complete overview |
| [Search page](search.html)  search the documentation | [Releases](https://github.com/prophyle/prophyle/releases)  release history |

## Auxiliary tools

|  |  |
| --- | --- |
| [ProphEx](http://github.com/prophyle/prophex)  FM-index for rapid k-mer matching using simplitigs | [ProphAsm](http://github.com/prophyle/prophasm)  representing k-mer sets via simplitigs |

## Cite

[1] K. Břinda, L. Lima, S. Pignotti, N. Quinones-Olvera, K. Salikhov,
R. Chikhi, G. Kucherov, Z. Iqbal, and M. Baym,
**Efficient and robust search of microbial genomes via phylogenetic compression,**
bioRxiv 2023.04.15.536996, 2023.
<https://doi.org/10.1101/2023.04.15.536996>.

[2] Břinda K, Salikhov K, Pignotti S, Kucherov G.
**ProPhyle 0.3.1.0**, Zenodo, 2017.
[https://doi.org/10.5281/zenodo.1045429](http://doi.org/10.5281/zenodo.1045429).

[3] Břinda K, Salikhov K, Pignotti S, Kucherov G.
**ProPhyle: a phylogeny-based metagenomic classifier using the Burrows-Wheeler Transform.**
Poster at HiTSeq 2017.
[https://doi.org/10.5281/zenodo.1045427](http://doi.org/10.5281/zenodo.1045427)

[4] Břinda K.
**Novel computational techniques for mapping and classifying Next-Generation Sequencing data.**
PhD Thesis, Université Paris-Est, 2016.
[https://doi.org/10.5281/zenodo.1045317](http://doi.org/10.5281/zenodo.1045317)

[5] Salikhov K.
**Efficient algorithms and data structures for indexing DNA sequence data.**
PhD Thesis, Université Paris-Est, 2017.

[1] introduces phylogenetic compression, which is the fundamental concept behind ProPhyle,
[2] is the main reference for the entire ProPhyle package,
[3] contains a summary of the ProPhyle algorithm,
[4] provides a thorough description (see Chapter 12),
and [5] explains details of the BWT-indexing technique.

## Authors

* [Karel Břinda](http://brinda.eu) <karel.brinda@inria.fr>
* Kamil Salikhov <kamil.salikhov@univ-mlv.fr>
* Simone Pignotti <pignottisimone@gmail.com>
* [Gregory Kucherov](http://igm.univ-mlv.fr/~koutcher/) <gregory.kucherov@univ-mlv.fr>

### Navigation

* [index](genindex.html "General Index")
* ProPhyle home |
* [Documentation](contents.html) »
* ProPhyle: DNA sequence classification

© Copyright 2015-2024, Karel Břinda, Kamil Salikhov, Simone Pignotti, Gregory Kucherov.
Created using [Sphinx](https://www.sphinx-doc.org/) 8.0.2.