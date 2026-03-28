[Probabilistic 20/20](index.html)

latest

* [Download](download.html)
* [Installation](installation.html)
* [Quick Start](quickstart.html)
* Tutorial
  + [Input formats](#input-formats)
    - [Mutations](#mutations)
    - [Gene BED file](#gene-bed-file)
    - [Gene FASTA](#gene-fasta)
    - [Pre-computed scores (optional)](#pre-computed-scores-optional)
  + [Running the statistical test](#running-the-statistical-test)
    - [Running oncogene sub-command](#running-oncogene-sub-command)
      * [Output format](#output-format)
    - [Running tsg sub-command](#running-tsg-sub-command)
      * [Output format](#id1)
    - [Running hotmaps1d sub-command](#running-hotmaps1d-sub-command)
      * [Output format](#id2)
  + [Simulating somatic mutations](#simulating-somatic-mutations)
    - [Simulated MAF](#simulated-maf)
    - [Simulated Features](#simulated-features)
* [FAQ](faq.html)

[Probabilistic 20/20](index.html)

* [Docs](index.html) »
* Tutorial
* [Edit on GitHub](https://github.com/KarchinLab/probabilistic2020/blob/master/doc/tutorial.rst)

---

# Tutorial[¶](#tutorial "Permalink to this headline")

Probabilistic 20/20 consists of two broad statistical tests (oncogene-like and tsg-like)
and somatic mutation simulation framework. Internally, the simulation framework is
used to establish statistical significance in the hypothesis test through the
**probabilistic2020** command. However, the simulation framework through the **mut\_annotate** command can
also be used to create a simulated MAF file where aferwords all mutations are distributed
like passengers based on uniform null distribution. Moreover, a set of mutational
features for each gene representative of driver genes (used in 20/20+) can also be
created.

## Input formats[¶](#input-formats "Permalink to this headline")

### Mutations[¶](#mutations "Permalink to this headline")

Mutations are provided in a Mutation Annotation Format (MAF) file.
Columns can be in any order, and only a few columns in the MAF file
are needed. The following is a list of the required columns.

* Hugo\_Symbol (or named “Gene”)
* Chromosome
* Start\_Position
* End\_Position
* Reference\_Allele
* Tumor\_Seq\_Allele2 (or named “Tumor\_Allele”)
* Tumor\_Sample\_Barcode (or named “Tumor\_Sample”)
* Variant\_Classification

The remaining columns in the MAF specification can be
left empty or not included. Since a MAF file has many additional
annotation columns, removing additional columns will reduce
the memory usage of probabilistic2020.

Only coding variants found in the Variant\_Classification column will be used, which includes the following: ‘Missense\_Mutation’, ‘Silent’, ‘Nonsense\_Mutation’, ‘Splice\_Site’, ‘Nonstop\_Mutation’, ‘Translation\_Start\_Site’, ‘Frame\_Shift\_Ins’, ‘Frame\_Shift\_Del’, ‘In\_Frame\_Ins’, ‘In\_Frame\_Del’, ‘Frame\_Shift\_Indel’, or ‘In\_Frame\_Indel’. Note, although ‘In\_Frame\_Indel’ and ‘Frame\_Shift\_Indel’ are not official MAF specification values, for the purpose of this program represent either and insertion or deletion. Other values for the Variant\_Classification column are assumed to be non-coding, and dropped from the analysis.

### Gene BED file[¶](#gene-bed-file "Permalink to this headline")

A single reference transcript for each gene is stored in BED12 format. Instead of
using the transcript name for the name field in the BED file,
the gene symbol which matches the MAF file should be used.
In the example data, the longest CDS transcript from SNVBox was used.

### Gene FASTA[¶](#gene-fasta "Permalink to this headline")

Gene sequences are extracted from a genome FASTA file, and is a step that only needs to be done once.
To do this, you need a BED file with names corresponding to genes, and a genome FASTA (e.g. hg19).
You can download hg19 from [here](http://hgdownload.soe.ucsc.edu/goldenPath/hg19/bigZips/hg19.2bit).
Creating the gene sequence FASTA is then done by the extract\_gene\_seq script:

```
$ extract_gene_seq -i hg19.fa -b snvboxGenes.bed -o snvboxGenes.fa
```

In this case the BED file is created using SNVBox, a genome FASTA file for hg19 (hg19.fa), and the
resulting coding sequences for the gene are stored in snvboxGenes.fa.

### Pre-computed scores (optional)[¶](#pre-computed-scores-optional "Permalink to this headline")

Two pre-computed scores are used to evaluate missense pathogenicity
scores and evolutionary conservation. Both are provided in the example
data, matching the reference transcript annotation from SNVBox.
Including the score information is useful, but optional. The
pre-computed missense pathogenicity scores are from the
[VEST algorithm](http://www.ncbi.nlm.nih.gov/pubmed/23819870).
The evolutionary conservation scores are calculated as the entropy of
a specific column in the protein-translated version of UCSC’s 46-way vertebrate alignment.

## Running the statistical test[¶](#running-the-statistical-test "Permalink to this headline")

The statistical tests account for gene sequence and mutational base context.
Each gene is represented by a single reference transcript (above is longest CDS SNVBox transcript).
By default the relevant sequence context for mutations are utilized from
[CHASM paper](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2763410/) (denoted by **-c 1.5** parameter). This includes some common dinucletoide contexts
like CpG, and otherwise just a single base. Ultimately a multiple testing corrected q-value
is reported using the Benjamini-Hochberg (BH) method.

**Technical detail:** Running on the obtained pan-cancer data may take several hours to run on a single
core. Specifying the **-p** parameter to use multiple processors will speed up run time if available.
Lowering the number of iterations (default: 100,000) will decrease run time, but also decrease the resolution
of p-values.

### Running oncogene sub-command[¶](#running-oncogene-sub-command "Permalink to this headline")

The oncogene sub-command examines missense position clustering (by codon) and elevated
*in silico* pathogenicity scores (VEST). The score directory contains pre-computed values for VEST scores.
The p-values will be combined using fisher’s method
to report a single p-value with a BH FDR. In the below example, the command is parallelized
onto 10 processors with the **-p** parameter. Lower this if the compute is not available.

```
$ probabilistic2020 oncogene \
     -i genes.fa \
     -b genes.bed \
     -s score_dir \
     -m mutations.txt \
     -c 1.5
     -p 10 \
     -o oncogene_output.txt
```

Where genes.fa is your gene FASTA file for your reference transcripts in genes.bed, mutations.txt is your MAF file containing mutations, score\_dir is the directory containing the pre-computed VEST scores, and oncogene\_output.txt is the file name to save the results.

#### Output format[¶](#output-format "Permalink to this headline")

The oncogene statistical test will output a tab-delimited file having columns for the
p-values and Benjamini-Hochberg q-values:

* “entropy”
* “vest” (only included if score\_dir provided)
* “combined” (only included if score\_dir provided)

The entropy columns evaluate missense clustering at the same codon by using a normalized missense position entropy statistic. Low values for entropy correspond to increased clustering
of missense mutations. The vest columns examine whether missense mutations tend to have
higher *in silico* pathogenicity scores for missense mutations than expected. The “combined”
columns, combine the p-values from VEST scores and missense clustering using Fisher’s method.

### Running tsg sub-command[¶](#running-tsg-sub-command "Permalink to this headline")

The **tsg** sub-command evaluates for elevated proportion of inactivating point mutations to find TSG-like genes.

```
$ probabilistic2020 tsg \
     -i genes.fa \
     -b genes.bed \
     -m mutations.txt \
     -p 10 \
     -c 1.5 \
     -o tsg_output.txt
```

Where genes.fa is your gene FASTA file for your reference transcripts in genes.bed, mutations.txt is your MAF file containing mutations, and tsg\_output.txt is the file name to save the results.

#### Output format[¶](#id1 "Permalink to this headline")

The tsg statistical test examines inactivating single nucleotide variants (nonsense,
splice site, lost start, and lost stop). Both the p-value (“inactivating p-value”)
and the Benjamini-hochberg q-value (“inactivating BH q-value”) are reported for
a higher than expected fraction of inactivating mutations. Mutations which could
not be placed onto the reference transcript will be indicated in the
“SNVs Unmapped to Ref Tx” column.

### Running hotmaps1d sub-command[¶](#running-hotmaps1d-sub-command "Permalink to this headline")

The **hotmaps1d** sub-command evaluates particular amino acid residues for elevated cluster of missense mutations in the protein sequence.

```
$ probabilistic2020 hotmaps1d \
     -i genes.fa \
     -b genes.bed \
     -m mutations.txt \
     -w 3 \
     -p 10 \
     -c 1.5 \
     -o hotmaps1d_output.txt
```

Where genes.fa is your gene FASTA file for your reference transcripts in genes.bed, mutations.txt is your MAF file containing mutations, and hotmaps1d\_output.txt is the file name to save the results. HotMAPS 1D also takes a window size for examining missense mutation clustering. In the above example, the parameter **-w 3** considers 3 residues on either side of each mutated residue. A large number of mutations in this small window may indicate the mutations form a “hotspot”, and likely contain driver mutations at the mutated residue. The window size can be changed depending on the preferred granularity of the analysis.

#### Output format[¶](#id2 "Permalink to this headline")

The hotmaps1d statistical test examines the position of missense mutations in sequence.
Both the p-value (“p-value”) and the Benjamini-hochberg q-value (“q-value”) are reported for
a higher than expected ammount of missense mutations within a given window around a mutation. The “mutation count” column reports how many missense mutations were observed at the particular codon, and the “windowed sum” column reports how many missense mutations were observed in a sequence window encompassing the particular codon.

## Simulating somatic mutations[¶](#simulating-somatic-mutations "Permalink to this headline")

The probabilistic2020 package also allows saving the results of underlying simulation
of somatic mutations. The simulations need a set of observed mutations to create simulated
mutations. Briefly, for each gene, SNVs (single nucleotide variants) are moved with uniform probability to any matching position in the gene sequence, holding the total number of SNVs fixed. A matching position was required to have the same base context (e.g. **-c 1.5** = C\*pG, CpG\*, TpC\*, G\*pA, A, C, G, T) as the observed position. This method of generating a null distribution controls for the particular gene sequence, gene length and mutation base context.
To simulate small insertions/deletions (indels), indels are moved to different genes according to a multinomial model where the probability is proprotional to the gene length.
This can be done for both creating a simulated MAF file or simulated
features calculated from the mutations.

Simulations are performed with the **mut\_annotate** command. The **–seed** parameter
will pass a seed to the pseudo random number generator. If you are performing several
simulations for MAF files and features, then it is critical that every time the seed for each
simulation match.

### Simulated MAF[¶](#simulated-maf "Permalink to this headline")

MAF output is designated with the **–maf** flag, but is a substantially reduced version
then a typical MAF file because it only contains the relevant columns noted in the
mutations input format section. To indicate mutations for each gene should be simulated
once, the **-n 1** parameter is used. If zero is supplied for this parameter, then
simulations are not performed and rather the observed mutations are just annotated
as a MAF file on the corresponding reference transcripts in genes.bed. The pseudo random
number generator seed can be passed with the **–seed** argument.

```
$ mut_annotate \
     --maf \
     -n 1 \
     -i genes.fa \
     -b genes.bed \
     -m mutations.txt \
     -p 10 \
     -c 1.5 \
     -o maf_output.txt
```

### Simulated Features[¶](#simulated-features "Permalink to this headline")

Simulated features which serve as input to [20/20+](http://2020plus.readthedocs.io/)
can also be generated.

```
$ mut_annotate \
     --summary \
     -n 1 \
     -i genes.fa \
     -b genes.bed \
     -m mutations.txt \
     -p 10 \
     -c 1.5 \
     -o summary_output.txt
```

[Next](faq.html "FAQ")
 [Previous](quickstart.html "Quick Start")

---

© Copyright 2014-19, Collin Tokheim
Revision `8e0b1b95`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).