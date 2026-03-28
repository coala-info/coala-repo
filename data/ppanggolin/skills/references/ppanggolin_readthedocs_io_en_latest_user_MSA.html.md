[PPanGGOLiN](../index.html)

User Guide:

* [Installation](install.html)
* [Quick usage](QuickUsage/quickAnalyses.html)
* [Practical information](practicalInformation.html)
* [Pangenome analyses](PangenomeAnalyses/pangenomeAnalyses.html)
* [Regions of genome plasticity analyses](RGP/rgpAnalyses.html)
* [Conserved module prediction](Modules/moduleAnalyses.html)
* [Write genomes](writeGenomes.html)
* [Write pangenome sequences](writeFasta.html)
* [Align external genes to a pangenome](align.html)
* [Projection](projection.html)
* [Prediction of Genomic Context](genomicContext.html)
* Multiple Sequence Alignment
  + [Modify the partition with `--partition`](#modify-the-partition-with-partition)
  + [Chose to align dna or protein sequences with `--source`](#chose-to-align-dna-or-protein-sequences-with-source)
  + [Write a single whole MSA file with `--phylo`](#write-a-single-whole-msa-file-with-phylo)
* [Metadata and Pangenome](metadata.html)

Developper Guide:

* [How to Contribute ✨](../dev/contribute.html)
* [Building the Documentation](../dev/buildDoc.html)
* [API Reference](../api/api_ref.html)

[PPanGGOLiN](../index.html)

* Multiple Sequence Alignment
* [View page source](../_sources/user/MSA.md.txt)

---

# Multiple Sequence Alignment[](#multiple-sequence-alignment "Permalink to this heading")

The commande `msa` compute multiple sequence alignment of any partition of the pangenome. The command uses [mafft](https://mafft.cbrc.jp/alignment/software/) with default options to perform the alignment. Using multiple cpus with the `--cpu` argument is recommended as multiple alignment can be quite demanding in computational resources.

This command can be used as follow:

```
ppanggolin msa -p pangenome.h5
```

By default it will write the strict ‘core’ (genes that are present in absolutely all genomes) and remove any duplicated genes. Beware however that, if you have many genomes (over 1000), the core will likely be either very small or even empty if you have fragmented genomes.

It will write one MSA for each family. You can then provide the directory where the MSA are written to [IQ-TREE](https://github.com/Cibiv/IQ-TREE) for example, to do phylogenetic analysis.

## Modify the partition with `--partition`[](#modify-the-partition-with-partition "Permalink to this heading")

You can change the partition which is written, by using the –partition option.

for example will compute MSA for all the persistent gene families.

```
ppanggolin msa -p pangenome.h5 --partition persistent
```

Supported partitions are `core`, `persistent`, `shell`, `cloud`, `softcore`, `accessory`. If you need specific filters, you can submit a request in the [issue tracker](https://github.com/labgem/PPanGGOLiN/issues) with your requirements. You can also directly implement the new filter and submit a Pull Request (instructions for contribution can be found [here](../dev/contribute.html)). Most filters should be quite straightforward to add.

## Chose to align dna or protein sequences with `--source`[](#chose-to-align-dna-or-protein-sequences-with-source "Permalink to this heading")

You can specify whether to use `dna` or `protein` sequences for the MSA by using `--source`. It uses protein sequences by default.

```
ppanggolin msa -p pangenome.h5 --source dna
```

## Write a single whole MSA file with `--phylo`[](#write-a-single-whole-msa-file-with-phylo "Permalink to this heading")

It is also possible to write a single whole genome MSA file, which many phylogenetic software accept as input, by using the `--phylo` option as such:

```
ppanggolin msa -p pangenome.h5 --phylo
```

This will concatenate all of the family MSA into a single MSA, with one sequence for each genome.

[Previous](genomicContext.html "Prediction of Genomic Context")
[Next](metadata.html "Metadata and Pangenome")

---

© Copyright 2023, LABGeM.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).