[phyluce](../index.html)

Contents:

* [Purpose](../purpose.html)
* [Installation](../installation.html)
* [Phyluce Tutorials](index.html)
  + [Tutorial I: UCE Phylogenomics](tutorial-1.html)
  + [Tutorial II: Phasing UCE data](tutorial-2.html)
  + [Tutorial III: Harvesting UCE Loci From Genomes](tutorial-3.html)
  + Tutorial IV: Identifying UCE Loci and Designing Baits To Target Them
    - [Starting directory structure](#starting-directory-structure)
    - [Data download and preparation](#data-download-and-preparation)
      * [Download the genomes](#download-the-genomes)
      * [Cleanup the genome sequences](#cleanup-the-genome-sequences)
      * [Put genomes in their own directories](#put-genomes-in-their-own-directories)
      * [Convert genomes to 2bit format](#convert-genomes-to-2bit-format)
      * [Simulate reads from genomes](#simulate-reads-from-genomes)
    - [Read alignment to the base genome](#read-alignment-to-the-base-genome)
      * [Prepare the base genome](#prepare-the-base-genome)
      * [Align reads to the base genome](#align-reads-to-the-base-genome)
      * [What it all means](#what-it-all-means)
    - [Conserved locus identification](#conserved-locus-identification)
      * [Convert BAMS to BEDS](#convert-bams-to-beds)
      * [Sort the converted BEDs](#sort-the-converted-beds)
      * [Merge overlapping or nearly-overlapping intervals](#merge-overlapping-or-nearly-overlapping-intervals)
      * [Remove repetitive intervals](#remove-repetitive-intervals)
      * [Determining locus presence in multiple genomes](#determining-locus-presence-in-multiple-genomes)
      * [Determining shared, conserved, loci](#determining-shared-conserved-loci)
    - [Conserved locus validation](#conserved-locus-validation)
      * [Extract FASTA sequence from base genome for temp bait design](#extract-fasta-sequence-from-base-genome-for-temp-bait-design)
      * [Design a temporary bait set from the base taxon](#design-a-temporary-bait-set-from-the-base-taxon)
      * [Remove duplicates from our temporary bait set](#remove-duplicates-from-our-temporary-bait-set)
      * [Align baits against exemplar genomes](#align-baits-against-exemplar-genomes)
      * [Extract sequence around conserved loci from exemplar genomes](#extract-sequence-around-conserved-loci-from-exemplar-genomes)
      * [Find which loci we detect consistently](#find-which-loci-we-detect-consistently)
    - [Final bait set design](#final-bait-set-design)
      * [Design a bait set using all exemplar genomes (and the base)](#design-a-bait-set-using-all-exemplar-genomes-and-the-base)
      * [Remove duplicates from our bait set](#remove-duplicates-from-our-bait-set)
    - [The master bait list](#the-master-bait-list)
      * [Subsetting the master probe list](#subsetting-the-master-probe-list)
    - [In-silico test of the bait design](#in-silico-test-of-the-bait-design)
      * [Align our bait set to the extant genome sequences](#align-our-bait-set-to-the-extant-genome-sequences)
      * [Match contigs to baits](#match-contigs-to-baits)
      * [Get match counts and extract FASTA information](#get-match-counts-and-extract-fasta-information)
      * [Align the conserved locus data](#align-the-conserved-locus-data)
      * [Trim the conserved locus alignments](#trim-the-conserved-locus-alignments)
      * [Remove the locus names from each alignment](#remove-the-locus-names-from-each-alignment)
      * [Get stats across the aligned loci](#get-stats-across-the-aligned-loci)
      * [Generate an incomplete matrix](#generate-an-incomplete-matrix)
      * [Prep raxml files, run raxml ML searches, and reconcile best tree w/ bootreps](#prep-raxml-files-run-raxml-ml-searches-and-reconcile-best-tree-w-bootreps)
* [Phyluce in Daily Use](../daily-use/index.html)

* [Citing](../citing.html)
* [License](../license.html)
* [Attributions](../attributions.html)
* [Funding](../funding.html)
* [Acknowledgements](../ack.html)

[phyluce](../index.html)

* [Phyluce Tutorials](index.html)
* Tutorial IV: Identifying UCE Loci and Designing Baits To Target Them
* [View page source](../_sources/tutorials/tutorial-4.rst.txt)

---

# Tutorial IV: Identifying UCE Loci and Designing Baits To Target Them[](#tutorial-iv-identifying-uce-loci-and-designing-baits-to-target-them "Link to this heading")

The first few tutorials have given you a feel for how to perform
phylogenetic/phylogeographic analyses using existing probe sets, new data, and
genomes. However, what if you are working on a set of organisms without a probe
set targeting conserved loci? How do you identify those loci and design baits
to target them? This Tutorial shows you how to do that.

In the examples below, we’ll follow a UCE identification and probe design workflow
using data from Coleoptera (beetles). Although you can follow the entire
tutorial from beginning to end, I’ve also made the BAM files containing mapped
reads available, which lets you skip the computationally exepensive step of
performing read simulation and alignment.

## Starting directory structure[](#starting-directory-structure "Link to this heading")

To keep things clear, we’re going to assume you are working in some directory,
which I’ll call uce-coleoptera. We’ll be working from the top of this
directory in the steps below:

```
uce-coleoptera
```

## Data download and preparation[](#data-download-and-preparation "Link to this heading")

### Download the genomes[](#download-the-genomes "Link to this heading")

Attention

You do not neccessarily need to do this as part of this tutorial
for UCE identification and probe design - If you only want to follow the
steps for locus identification (skipping probe design and in-silico
testing), you can simply download the prepared [FASTQ/BAM files from
figshare](https://dx.doi.org/10.6084/m9.figshare.3487349).

Make a directory to hold the genome sequences:

```
> mkdir genomes
> cd genomes
```

Now, get the genome sequences:

```
# Anoplophora glabripennis (Asian longhorned beetle)
> wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/390/285/GCA_000390285.1_Agla_1.0/GCA_000390285.1_Agla_1.0_genomic.fna.gz

# Agrilus planipennis (emerald ash borer)
> wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/699/045/GCA_000699045.1_Apla_1.0/GCA_000699045.1_Apla_1.0_genomic.fna.gz

# Leptinotarsa decemlineata (Colorado potato beetle)
> wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/500/325/GCA_000500325.1_Ldec_1.5/GCA_000500325.1_Ldec_1.5_genomic.fna.gz

# Onthophagus taurus (beetles)
> wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/648/695/GCA_000648695.1_Otau_1.0/GCA_000648695.1_Otau_1.0_genomic.fna.gz

# Dendroctonus ponderosae (mountain pine beetle)
> wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/355/655/GCA_000355655.1_DendPond_male_1.0/GCA_000355655.1_DendPond_male_1.0_genomic.fna.gz

# Tribolium castaneum (red flour beetle)
> wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/002/335/GCA_000002335.2_Tcas_3.0/GCA_000002335.2_Tcas_3.0_genomic.fna.gz

# Mengenilla moldrzyki (twisted-wing parasites) [Outgroup]
> wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/281/935/GCA_000281935.1_Memo_1.0/GCA_000281935.1_Memo_1.0_genomic.fna.gz
```

You need to unzip all of the genome sequences

```
> gunzip *
```

Finally, your directory structure should look something like:

```
uce-coleoptera
└── genomes
    ├── GCA_000002335.2_Tcas_3.0_genomic.fna
    ├── GCA_000281935.1_Memo_1.0_genomic.fna
    ├── GCA_000355655.1_DendPond_male_1.0_genomic.fna
    ├── GCA_000390285.1_Agla_1.0_genomic.fna
    ├── GCA_000500325.1_Ldec_1.5_genomic.fna
    ├── GCA_000648695.1_Otau_1.0_genomic.fna
    └── GCA_000699045.1_Apla_1.0_genomic.fna
```

### Cleanup the genome sequences[](#cleanup-the-genome-sequences "Link to this heading")

Attention

You do not neccessarily need to do this as part of this tutorial
for UCE identification and probe design - If you only want to follow the
steps for locus identification (skipping probe design and in-silico
testing), you can simply download the prepared [FASTQ/BAM files from
figshare](https://dx.doi.org/10.6084/m9.figshare.3487349).

When you get genome sequences from NCBI, the FASTA headers of most
scaffold/contigs contain a lot of extra cruft that can cause problems with some
of the steps in the UCE identification and probe design workflow. I usually
remove the extra stuff, maintaining only the accession number information for
each contig / scaffold. To do that, I use a little python script that looks
like the following:

```
from Bio import SeqIO
with open("Name_of_Genome_File.fna", "rU") as infile:
with open("outfileName.fasta", "w") as outf:
    for seq in SeqIO.parse(infile, 'fasta'):
        seq.name = ""
        seq.description = ""
        outf.write(seq.format('fasta'))
```

For these genome assemblies, the important bits are in the FASTA header just
before the space in the name. The code above basically keeps this information
before the space and discards the remaining FASTA header information.

In the case of the genomes above, here are the commands I ran (note also that
this creates an output file with a different name from the input file):

```
from Bio import SeqIO

# Anoplophora glabripennis (Asian longhorned beetle)
with open("GCA_000390285.1_Agla_1.0_genomic.fna", "rU") as infile:
    with open("anoGla1.fasta", "w") as outf:
        for seq in SeqIO.parse(infile, 'fasta'):
            seq.name = ""
            seq.description = ""
            outf.write(seq.format('fasta'))

# Agrilus planipennis (emerald ash borer)
with open("GCA_000699045.1_Apla_1.0_genomic.fna", "rU") as infile:
    with open("agrPla1.fasta", "w") as outf:
        for seq in SeqIO.parse(infile, 'fasta'):
            seq.name = ""
            seq.description = ""
            outf.write(seq.format('fasta'))

# Dendroctonus ponderosae (mountain pine beetle)
with open("GCA_000355655.1_DendPond_male_1.0_genomic.fna", "rU") as infile:
    with open("denPon1.fasta", "w") as outf:
        for seq in SeqIO.parse(infile, 'fasta'):
            seq.name = ""
            seq.description = ""
            outf.write(seq.format('fasta'))

# Leptinotarsa decemlineata (Colorado potato beetle)
with open("GCA_000500325.1_Ldec_1.5_genomic.fna", "rU") as infile:
    with open("lepDec1.fasta", "w") as outf:
        for seq in SeqIO.parse(infile, 'fasta'):
            seq.name = ""
            seq.description = ""
            outf.write(seq.format('fasta'))

# Mengenilla moldrzyki (twisted-wing parasites) [Outgroup]
with open("GCA_000281935.1_Memo_1.0_genomic.fna", "rU") as infile:
    with open("menMol1.fasta", "w") as outf:
        for seq in SeqIO.parse(infile, 'fasta'):
            seq.name = ""
            seq.description = ""
            outf.write(seq.format('fasta'))

# Onthophagus taurus (beetles)
with open("GCA_000648695.1_Otau_1.0_genomic.fna", "rU") as infile:
    with open("ontTau1.fasta", "w") as outf:
        for seq in SeqIO.parse(infile, 'fasta'):
            seq.name = ""
            seq.description = ""
            outf.write(seq.format('fasta'))

# Tribolium castaneum (red flour beetle)
with open("GCA_000002335.2_Tcas_3.0_genomic.fna", "rU") as infile:
    with open("triCas1.fasta", "w") as outf:
        for seq in SeqIO.parse(infile, 'fasta'):
            seq.name = ""
            seq.description = ""
            outf.write(seq.format('fasta'))
```

Now, you can remove the original files downloaded from NCBI:

```
rm *.fna
```

And, your directory structure should look something like:

```
uce-coleoptera
└── genomes
    ├── anoGla1.fasta
    ├── agrPla1.fasta
    ├── denPon1.fasta
    ├── lepDec1.fasta
    ├── menMol1.fasta
    ├── ontTau1.fasta
    └── triCas1.fasta
```

### Put genomes in their own directories[](#put-genomes-in-their-own-directories "Link to this heading")

Because of some historical reasons (and how I organize our lab data), each
genome sequence needs to be in its own directory. We can do that pretty easily
by running:

```
> cd uce-coleoptera
> cd genomes
> for critter in *; do mkdir ${critter%.*}; mv $critter ${critter%.*}; done
```

Now the directory structure looks like:

```
uce-coleoptera
└── genomes
    ├── agrPla1
    │   └── agrPla1.fasta
    ├── anoGla1
    │   └── anoGla1.fasta
    ├── denPon1
    │   └── denPon1.fasta
    ├── lepDec1
    │   └── lepDec1.fasta
    ├── menMol1
    │   └── menMol1.fasta
    ├── ontTau1
    │   └── ontTau1.fasta
    └── triCas1
        └── triCas1.fasta
```

### Convert genomes to 2bit format[](#convert-genomes-to-2bit-format "Link to this heading")

Later during the workflow, we’re going to need to have our genomes in 2bit
format, which is a binary format for genomic data that is easier and faster to
work with than FASTA format. We’ll use a BASH script to convert all of the
sequences, above, to 2bit format:

```
> cd uce-coleoptera
> cd genomes
> for critter in *; do faToTwoBit $critter/$critter.fasta $critter/${critter%.*}.2bit; done
```

Now the directory structure looks like:

```
uce-coleoptera
└── genomes
    ├── agrPla1
    │   ├── agrPla1.2bit
    │   └── agrPla1.fasta
    ├── anoGla1
    │   ├── anoGla1.2bit
    │   └── anoGla1.fasta
    ├── denPon1
    │   ├── denPon1.2bit
    │   └── denPon1.fasta
    ├── lepDec1
    │   ├── lepDec1.2bit
    │   └── lepDec1.fasta
    ├── menMol1
    │   ├── menMol1.2bit
    │   └── menMol1.fasta
    ├── ontTau1
    │   ├── ontTau1.2bit
    │   └── ontTau1.fasta
    └── triCas1
        ├── triCas1.2bit
        └── triCas1.fasta
```

### Simulate reads from genomes[](#simulate-reads-from-genomes "Link to this heading")

Attention

You do not neccessarily need to take this step as part of the
tutorial - you can simply download prepared, simulated [FASTQ files from
figshare](https://ndownloader.figshare.com/files/5513204).

In order to locate UCE loci across a selection of different genomes, we’re going
to align reads from each taxon, above, to a reference genome sequence (the
“base” genome sequence) using a permissive raw read aligner. You can use reads
from low-coverage, genome scans or you can use reads simulated from particular
genomes. In this tutorial, we’re going to use this latter approach and simulate
reads (without sequencing error) from the genomes that we will align to the base
genome. To accomplish this, we’ll use [art](http://www.niehs.nih.gov/research/resources/software/biostatistics/art/),
which is a robust read simulator that is reasonably flexible.

Because we’re using simulated reads to locate UCE loci, we want to turn off the
built-in feature of art that adds some sequencing error to simulated reads.
This results in a general form of the call to art that looks like:

```
> art_illumina \
    --paired \
    --in ~/path/to/input/genome.fasta \
    --out prefix-of-output-file \
    --len 100 \
    --fcov 2 \
    --mflen 200 \
    --sdev 150 \
    -ir 0.0 -ir2 0.0 -dr 0.0 -dr2 0.0 -qs 100 -qs2 100 -na
```

This simulates reads from the –in genome.fasta that are 100 bp