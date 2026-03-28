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
* Align external genes to a pangenome
  + [Output files](#output-files)
    - [1. ‘sequences\_partition\_projection.tsv’](#sequences-partition-projection-tsv)
    - [2. ‘input\_to\_pangenome\_associations.blast-tab’](#input-to-pangenome-associations-blast-tab)
    - [3. Optional outputs](#optional-outputs)
* [Projection](projection.html)
* [Prediction of Genomic Context](genomicContext.html)
* [Multiple Sequence Alignment](MSA.html)
* [Metadata and Pangenome](metadata.html)

Developper Guide:

* [How to Contribute ✨](../dev/contribute.html)
* [Building the Documentation](../dev/buildDoc.html)
* [API Reference](../api/api_ref.html)

[PPanGGOLiN](../index.html)

* Align external genes to a pangenome
* [View page source](../_sources/user/align.md.txt)

---

# Align external genes to a pangenome[](#align-external-genes-to-a-pangenome "Permalink to this heading")

The PPanGGOLiN `align` command allows to use a pangenome as a reference to get information about a set of sequences of interest. It requires a previously computed pangenome in HDF-5 format as input, along with a `.fasta` file containing either nucleotide or protein sequences.
The command utilizes MMseqs to compare input sequences to representatives of the pangenome gene family. It assigns a gene family to each input sequence if there is one that is sufficiently similar (as defined by command parameters). If multiple families are assignable, the one with the highest bitscore is selected.

This command is used as follows:

```
ppanggolin align -p pangenome.h5 -o MYOUTPUTDIR --sequences MY_SEQUENCSE_OF_INTEREST.fasta
```

## Output files[](#output-files "Permalink to this heading")

By default the command creates two output files:

### 1. ‘sequences\_partition\_projection.tsv’[](#sequences-partition-projection-tsv "Permalink to this heading")

‘sequences\_partition\_projection.tsv’ is a .tsv file with two columns that indicates the partition of the most similar gene family in the pangenome to which the given input sequence is closest. It follows the following format:

| column | description |
| --- | --- |
| input | the header of the sequence in the given .fasta file |
| partition | predicted partition based on the most similar gene family, or ‘cloud’ if there are   no similar enough gene family |

### 2. ‘input\_to\_pangenome\_associations.blast-tab’[](#input-to-pangenome-associations-blast-tab "Permalink to this heading")

‘input\_to\_pangenome\_associations.blast-tab’ is a .tsv file that follows the tabular blast format which many alignment software (such as blast, diamond, mmseqs etc.) use, with two additional columns: the length of query sequence which was aligned, and the length of the subject sequence which was aligned (provided with qlen and slen with the software I previously named). You can find a detailed description of the format in [this blog post](https://www.metagenomics.wiki/tools/blast/blastn-output-format-6) for example (and there are many other descriptions of this format on internet, if you search for ‘tabular blast format’). The query are the provided sequences, and the subject are the pangenome gene families.

### 3. Optional outputs[](#optional-outputs "Permalink to this heading")

Optionally, you can also write additional files that provide alternative information. If RGP and spots have been predicted in your pangenome (see [Regions of Genome Plasticity](RGP/rgpAnalyses.html) if you do not know what those are)
you can use `--getinfo` as such:

```
ppanggolin align -p pangenome.h5 -o MYOUTPUTDIR --sequences MY_SEQUENCSE_OF_INTEREST.fasta --getinfo
```

`--getinfo` will list known spots and RGPs where the gene families similar to your proteins of interest are found. They will be listed if they are in the RGPs themselves OR if they are bordering it (that is, if they are within 3 persistent genes of the RGP).
The written file will be called ‘info\_input\_seq.tsv’, and follows the following format:

| column | description |
| --- | --- |
| input | the header of the sequence in the given .fasta file |
| family | the id of the family the input sequence was assigned to |
| partition | predicted partition based on the most similar gene family, or ‘cloud’ if   there are no similar enough gene family |
| spot\_list\_as\_member | the list of spots in which the sequence is found, as a member of the spot   (it is included in it) |
| spot\_list\_as\_border | the list of spots in which the sequence is found as a bordering gene |
| rgp\_list | the list of RGP in which the sequence is found |

You can use `--draw_related` as such:

```
ppanggolin align -p pangenome.h5 -o MYOUTPUTDIR --sequences MY_SEQUENCSE_OF_INTEREST.fasta --draw_related
```

It will draw all of the spots where the gene families similar to your proteins of interest are found, writing 3 files, one figure, one .gexf file and one .tsv file. This option is basically using what is described in the [`draw --spots`](RGP/rgpOutputs.html#draw-spots) part of the documentation.

[Previous](writeFasta.html "Write pangenome sequences")
[Next](projection.html "Projection")

---

© Copyright 2023, LABGeM.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).