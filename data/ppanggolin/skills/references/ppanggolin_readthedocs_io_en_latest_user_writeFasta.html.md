[PPanGGOLiN](../index.html)

User Guide:

* [Installation](install.html)
* [Quick usage](QuickUsage/quickAnalyses.html)
* [Practical information](practicalInformation.html)
* [Pangenome analyses](PangenomeAnalyses/pangenomeAnalyses.html)
* [Regions of genome plasticity analyses](RGP/rgpAnalyses.html)
* [Conserved module prediction](Modules/moduleAnalyses.html)
* [Write genomes](writeGenomes.html)
* Write pangenome sequences
  + [Genes](#genes)
    - [Nucleotide sequences](#nucleotide-sequences)
    - [Protein sequences](#protein-sequences)
  + [Gene families](#gene-families)
    - [Protein sequences](#id1)
    - [Nucleotide sequences](#id2)
  + [Modules](#modules)
  + [Regions](#regions)
* [Align external genes to a pangenome](align.html)
* [Projection](projection.html)
* [Prediction of Genomic Context](genomicContext.html)
* [Multiple Sequence Alignment](MSA.html)
* [Metadata and Pangenome](metadata.html)

Developper Guide:

* [How to Contribute ✨](../dev/contribute.html)
* [Building the Documentation](../dev/buildDoc.html)
* [API Reference](../api/api_ref.html)

[PPanGGOLiN](../index.html)

* Write pangenome sequences
* [View page source](../_sources/user/writeFasta.md.txt)

---

# Write pangenome sequences[](#write-pangenome-sequences "Permalink to this heading")

The `fasta` command can be used to write sequences of the pangenome or specific parts of the pangenome in FASTA format.

Most options require a partition.

Available partitions are:

* `all` for the entire pangenome.
* `Persistent` for persistent families
* `Shell` for shell genes or families
* `Cloud` for cloud genes or families
* `rgp` for genes or families found in RGPs
* `core` for core genes or families
* `softcore` for softcore genes or families

When using the `softcore` filter, the `--soft_core` option can be used to modify the threshold used to determine what is part of the softcore. It is set to 0.95 by default.

## Genes[](#genes "Permalink to this heading")

### Nucleotide sequences[](#nucleotide-sequences "Permalink to this heading")

With the `--genes partition` option PPanGGOLiN will write the nucleotide CDS sequences for the given partition.
It can be used as such, to write all the genes of the pangenome for example:

```
ppanggolin fasta -p pangenome.h5 --output MY_GENES --genes all
```

Or to write only the persistent genes:

```
ppanggolin fasta -p pangenome.h5 --output MY_GENES --genes persistent
```

### Protein sequences[](#protein-sequences "Permalink to this heading")

With the `--proteins partition` option PPanGGOLiN will write the nucleotide CDS sequences for the given partition.
It can be used as such, to write all the genes of the pangenome for example:

```
ppanggolin fasta -p pangenome.h5 --output MY_GENES --proteins all
```

Or to write only the cloud genes:

```
ppanggolin fasta -p pangenome.h5 --output MY_GENES --genes_prot cloud
```

To translate the gene sequences, PPanGGOLiN uses the [MMSeqs2](https://github.com/soedinglab/MMseqs2) `translatenucs` command.
So for this option you can specify multiple threads with `--cpu`.
You can also specify the translation table to use with `--translate_table`.
The temporary directory, can be specified with `--tmpdir` to store the [MMSeqs2](https://github.com/soedinglab/MMseqs2) database and other files. Temporary files will be deleted at the end of the execution. To keep them, you can use the `--keep_tmp` option.

## Gene families[](#gene-families "Permalink to this heading")

### Protein sequences[](#id1 "Permalink to this heading")

With the `--prot_families partition` option PPanGGOLiN will write the protein sequences of the representative gene for each family for the given partition.
It can be used as such for all families:

```
ppanggolin fasta -p pangenome.h5 --output MY_PROT --prot_families all
```

Or for all the shell families for example:

```
ppanggolin fasta -p pangenome.h5 --output MY_PROT --prot_families shell
```

### Nucleotide sequences[](#id2 "Permalink to this heading")

With the `--gene_families partition` option PPanGGOLiN will write the nucleotide sequences of the representative gene for each family for the given partition.
It can be used as such for all families:

```
ppanggolin fasta -p pangenome.h5 --output MY_GENES_FAMILIES --gene_families all
```

Or for the core families for example:

```
ppanggolin fasta -p pangenome.h5 --output MY_GENES_FAMILIES --gene_families core
```

## Modules[](#modules "Permalink to this heading")

All the precedent command admit a module as partition.

So you can write the protein sequences for the family in module\_X as such:

```
ppanggolin fasta -p pangenome.h5 --output MY_REGIONS --prot_families module_X
```

Or the nucleotide sequence of all genes in module\_X:

```
ppanggolin fasta -p pangenome.h5 --output MY_REGIONS --genes module_X
```

## Regions[](#regions "Permalink to this heading")

This option can be used to write the nucleotide sequences of the detected RGPs.
It requires the fasta sequences used to compute the pangenome, as originally provided when you computed your pangenome.

This command has only two filters:

* all, for all regions
* complete, for only the ‘complete’ regions which are not on a contig border

It can be used as such:

```
ppanggolin fasta -p pangenome.h5 --output MY_REGIONS --regions all --fasta genomes.fasta.list
```

[Previous](writeGenomes.html "Write genomes")
[Next](align.html "Align external genes to a pangenome")

---

© Copyright 2023, LABGeM.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).