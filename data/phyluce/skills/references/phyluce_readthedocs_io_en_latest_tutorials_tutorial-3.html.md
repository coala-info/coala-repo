[phyluce](../index.html)

Contents:

* [Purpose](../purpose.html)
* [Installation](../installation.html)
* [Phyluce Tutorials](index.html)
  + [Tutorial I: UCE Phylogenomics](tutorial-1.html)
  + [Tutorial II: Phasing UCE data](tutorial-2.html)
  + Tutorial III: Harvesting UCE Loci From Genomes
    - [Starting directory structure](#starting-directory-structure)
    - [Download the data](#download-the-data)
      * [chicken (galGal4)](#chicken-galgal4)
      * [alligator (allMis1)](#alligator-allmis1)
    - [Finding UCE loci](#finding-uce-loci)
      * [Get the UCE probes](#get-the-uce-probes)
      * [Align the probes to the genomes](#align-the-probes-to-the-genomes)
      * [Extracting FASTA sequence matching UCE loci from genome sequences](#extracting-fasta-sequence-matching-uce-loci-from-genome-sequences)
      * [Using the extracted sequences in downstream analyses](#using-the-extracted-sequences-in-downstream-analyses)
  + [Tutorial IV: Identifying UCE Loci and Designing Baits To Target Them](tutorial-4.html)
* [Phyluce in Daily Use](../daily-use/index.html)

* [Citing](../citing.html)
* [License](../license.html)
* [Attributions](../attributions.html)
* [Funding](../funding.html)
* [Acknowledgements](../ack.html)

[phyluce](../index.html)

* [Phyluce Tutorials](index.html)
* Tutorial III: Harvesting UCE Loci From Genomes
* [View page source](../_sources/tutorials/tutorial-3.rst.txt)

---

# Tutorial III: Harvesting UCE Loci From Genomes[](#tutorial-iii-harvesting-uce-loci-from-genomes "Link to this heading")

In many cases, genomic data exist for some (or many) taxa, and you want to
“harvest” those loci from the genome(s) available to you for inclusion in a
study. This tutorial is meant to explain how to do this. For this example,
we’ll download two genome sequences from web repositories, locate, and extract
UCE loci from these genomes for subsequent analysis.

The taxa we are working with will be:

* Gallus gallus
* Alligator mississippiensis

## Starting directory structure[](#starting-directory-structure "Link to this heading")

To keep things clear, we’re going to assume you are working in some directory,
which I’ll call uce-genome. We’ll be working from the top of this directory
in the steps below:

```
uce-genome
```

## Download the data[](#download-the-data "Link to this heading")

You can download genome assemblies from any number of sources - some better than
others. Here, we’re going to download one genome assembly (chicken; galGal4)
from the [UCSC Genome Browser](https://genome.ucsc.edu/) and another (alligator) from NCBI. We’re using
two difference sources so you can see some of the differences in the process…
and what you might need to do in order to “clean up” a given genome sequence.
We’ll start with the easy one.

### chicken (galGal4)[](#chicken-galgal4 "Link to this heading")

The [UCSC Genome Browser](https://genome.ucsc.edu/) is a great resource for lots of data that is easy to
find and easy to use. In particular, we’re interested in the [UCSC Genome
Browser Downloads](https://genome.ucsc.edu/downloads) area, where you can find genome sequence, genome
annotations, etc. for many model (and non-model) taxa. In this case, we want
the galGal4 genome sequence, which is the 4th “official” assembly of the
chicken genome sequence (AKA GCA\_000002315.2). You can find this by
navigating from the [UCSC Genome Browser Downloads](https://genome.ucsc.edu/downloads) to the [Chicken](http://hgdownload.soe.ucsc.edu/downloads.html#chicken) section of the page.
Under the galGal4 heading, click on [Full data set](http://hgdownload.soe.ucsc.edu/goldenPath/galGal4/bigZips/). This will take
you to the data download page for galGal4 where there is a listing of all the
data you can download for the galGal4 assembly. We’re interested in the
galGal4.2bit file, which is a compressed representation of the genome in
[2bit format](https://genome.ucsc.edu/goldenpath/help/twoBit.html). You can
either click on this file name to download the file, or navigate to your uce-
genome folder and:

```
$ cd uce-genome
$ mkdir galGal4
$ cd galGal4
wget http://hgdownload.soe.ucsc.edu/goldenPath/galGal4/bigZips/galGal4.2bit
```

This put a 2bit file in our uce-genome directory, so that our directory structure looks like:

```
uce-genome
└── galGal4
    └── galGal4.2bit
```

There are various utilities for dealing with
[2bit](https://genome.ucsc.edu/goldenpath/help/twoBit.html) files that you can
download as part of the [Kent Source Archive](http://hgdownload.soe.ucsc.edu/admin/exe/), a set of programs for dealing
with genome-scale data. Probably the most important of these are faToTwoBit,
which we use below; twoBitInfo, which gives us information on a given 2bit
file; and twoBitToFa which converts a 2bit file back to FASTA format. If we
run twoBitInfo against galGal4.2bit, we see something like:

```
$ cd uce-genome/galGal4
$ twoBitInfo galGal4.2bit sizes.tab

$ head -n 5 sizes.tab
chr1    195276750
chr10   19911089
chr10_AADN03010416_random   11080
chr10_AADN03010420_random   8415
chr10_JH375184_random   3009
```

which shows us the scaffolds/contigs and their sizes.

### alligator (allMis1)[](#alligator-allmis1 "Link to this heading")

Although you can get the alligator genomes [from UCSC](http://hgdownload.soe.ucsc.edu/goldenPath/allMis1/bigZips/), we’ll download
it from [NCBI](http://www.ncbi.nlm.nih.gov/), so that you can see the differences in the process/data.
Explaining [NCBI](http://www.ncbi.nlm.nih.gov/) is beyond the scope of what we’re doing here, so we’ll just
navigate to the [NCBI alligator genome assembly page](http://www.ncbi.nlm.nih.gov/genome/13409). If you click the [Assembly](http://www.ncbi.nlm.nih.gov/assembly?LinkName=genome_assembly&from_uid=13409)
link on the right hand side of the page (under “Related information”), this will
take you to the [suite of assemblies](http://www.ncbi.nlm.nih.gov/assembly?LinkName=genome_assembly&from_uid=13409)
for alligator.

We’ll download the Algmis\_Hirise\_1.0 assembly, which is an improvement on the
original assembly. To do this, click on the Algmis\_Hirise\_1.0 link, and look
for the Download the GenBank assembly
link on the top right corner of the next page. This will take you to an FTP
page, where you want to download
GCA\_001541155.1\_Algmis\_Hirise\_1.0\_genomic.fna.gz. You can do this by clicking
on the link or by:

```
$ cd uce-genome
$ mkdir allMis2
$ cd allMis2
# now download from NCBI
$ wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/541/155/GCA_001541155.1_Algmis_Hirise_1.0/GCA_001541155.1_Algmis_Hirise_1.0_genomic.fna.gz
```

This put a gzipped fasta file in our uce-genome/allMis2 directory, so that our
directory structure looks like:

```
uce-genome
├── allMis2
│   └── GCA_001541155.1_Algmis_Hirise_1.0_genomic.fna.gz
└── galGal4
    ├── galGal4.2bit
    └── sizes.tab
```

Now, we need to unzip this and have a look at the file:

```
$ cd uce-genome/allMis2
$ gunzip GCA_001541155.1_Algmis_Hirise_1.0_genomic.fna.gz

# take a look at the contents of this file:
$ head -n 1 GCA_001541155.1_Algmis_Hirise_1.0_genomic.fna
>LPUV01000001.1 Alligator mississippiensis ScZkoYb_3522, whole genome shotgun sequence
```

Note that the header has a lot of text in it, and this text is not always good.
We’re going to convert this file to 2bit format using faToTwoBit from the
[Kent Source Archive](http://hgdownload.soe.ucsc.edu/admin/exe/), which will remove everything following the first space
in the header line:

```
$ faToTwoBit GCA_001541155.1_Algmis_Hirise_1.0_genomic.fna allMis2.2bit
$ twoBitInfo allMis2.2bit sizes.tab
$ head -n 5 sizes.tab
LPUV01000001.1  1279
LPUV01000002.1  4883
LPUV01000003.1  1105
LPUV01000004.1  22955
LPUV01000005.1  1137523
```

Now that we’ve converted the fasta file to 2bit format, we can delete the
fasta file:

```
$ rm GCA_001541155.1_Algmis_Hirise_1.0_genomic.fna
```

And your directory structure should look like:

```
uce-genome
├── allMis2
│   ├── allMis2.2bit
│   └── sizes.tab
└── galGal4
    ├── galGal4.2bit
    └── sizes.tab
```

Attention

It’s easiest to use 2bit files of each genome you want to
search for UCE loci.

## Finding UCE loci[](#finding-uce-loci "Link to this heading")

Now that we’ve downloaded our genome assemblies, it’s time to find those
contigs/scaffolds in the assembly that contain UCE loci.

### Get the UCE probes[](#get-the-uce-probes "Link to this heading")

To do that, we need to get the UCE probe set we want to search for into our
directory. Here, we’ll search for the UCE 5k probe set. However, you
can use whichever probe set you like - you just need to know the path to this
file.

```
> cd uce-genome
# download the probe set
wget https://raw.githubusercontent.com/faircloth-lab/uce-probe-sets/refs/heads/master/V1/uce-5k-probe-set/uce-5k-probes.fasta
```

Now, our directory structure looks like:

```
uce-genome
├── allMis2
│   ├── allMis2.2bit
│   └── sizes.tab
├── galGal4
│   ├── galGal4.2bit
│   └── sizes.tab
└── uce-5k-probes.fasta
```

### Align the probes to the genomes[](#align-the-probes-to-the-genomes "Link to this heading")

We need to align the probes to the genome sequences. The program that we are
going to run assumes that each 2bit genome file is in it’s own directory
(which we have ensured, above).

Attention

If you use some other organizational structure, you still need
to ensure that each genome sequence is in it’s own directory. So, if you
have some directory genomes, the genomes must be organized within that
folder like:

```
genomes
├── allMis2
│   └── allMis2.2bit
└── galGal4
    └── galGal4.2bit
```

Now, we need to think of some name for the database to create (here
tutorial3.sqlite), the name of an output in which to store the lastz search
results, the path to the genome sequences, the name of the genome sequences, the
path to the probe file, and a number of compute cores to use:

```
> cd uce-genome

# run the search
> phyluce_probe_run_multiple_lastzs_sqlite \
    --db tutorial3.sqlite \
    --output tutorial3-genome-lastz \
    --scaffoldlist galGal4 allMis2 \
    --genome-base-path ./ \
    --probefile uce-5k-probes.fasta \
    --cores 12
```

The program will create some output that looks like:

```
Running against galGal4.2bit
Running with the --huge option.  Chunking files into 10000000 bp...
/tmp/tmptXup1D.lastz

< .. snip .. >

Cleaning up the chunked files...
Cleaning /home/bcf/tmp/uce-genome/tutorial3-genome-lastz/uce-5k-probes.fasta_v_galGal4.lastz
Creating galGal4 table
Inserting data to galGal4 table

Running against allMis2.2bit
Running with the --huge option.  Chunking files into 10000000 bp...
Running the targets against 109 queries...
/tmp/tmpuuHOpS.fasta

< .. snip .. >

Cleaning up the chunked files...
Cleaning /home/bcf/tmp/uce-genome/tutorial3-genome-lastz/uce-5k-probes.fasta_v_allMis2.lastz
Creating allMis2 table
Inserting data to allMis2 table
```

The directory structure should now look like this:

```
uce-genome
├── allMis2
│   ├── allMis2.2bit
│   └── sizes.tab
├── galGal4
│   ├── galGal4.2bit
│   └── sizes.tab
├── tutorial3-genome-lastz
│   ├── uce-5k-probes.fasta_v_allMis2.lastz.clean
│   └── uce-5k-probes.fasta_v_galGal4.lastz.clean
├── tutorial3.sqlite
└── uce-5k-probes.fasta
```

### Extracting FASTA sequence matching UCE loci from genome sequences[](#extracting-fasta-sequence-matching-uce-loci-from-genome-sequences "Link to this heading")

Once you have run the search, you can extract the loci identified during the
search from each respective genome sequence plus some sequence flanking each
locus (at a distance you can specify). Before you do that, however, you need to
create a configuration file that tells the program where to find each genome.
In the case above, that file would look like so (the full path to my
working directory is /home/bcf/tmp/uce-genome):

```
[scaffolds]
galGal4:/home/bcf/tmp/uce-genome/galGal4/galGal4.2bit
allMis2:/home/bcf/tmp/uce-genome/allMis2/allMis2.2bit
```

Attention

Be careful to make sure that your capitalization is consistent
with your file names.

With that file created as genomes.conf, our directory structure looks like:

```
uce-genome
├── allMis2
│   ├── allMis2.2bit
│   └── sizes.tab
├── galGal4
│   ├── galGal4.2bit
│   └── sizes.tab
├── genomes.conf
├── tutorial3-genome-lastz
│   ├── uce-5k-probes.fasta_v_allMis2.lastz.clean
│   └── uce-5k-probes.fasta_v_galGal4.lastz.clean
├── tutorial3.sqlite
└── uce-5k-probes.fasta
```

Now, we can extract FASTA data from each genome for each UCE locus. To do this,
we need to input the path to the lastz files from above, the path to the
conf file we just created, the amount of flanking sequence (to each side) that
we would like to slice, a name pattern, matching the lastz files that we would
like to use, and the name of the output directory we want to create:

```
phyluce_probe_slice_sequence_from_genomes \
    --lastz tutorial3-genome-lastz \
    --conf genomes.conf \
    --flank 500 \
    --name-pattern "uce-5k-probes.fasta_v_{}.lastz.clean" \
    --output tutorial-genome-fasta
```

You should see output similar to:

```
2016-06-01 16:02:18,907 - Phyluce - INFO - =================== Starting Phyluce: Slice Sequence ===================
2016-06-01 16:02:18,908 - Phyluce - INFO - ------------------- Working on galGal4 genome -------------------
2016-06-01 16:02:18,908 - Phyluce - INFO - Reading galGal4 genome
2016-06-01 16:02:28,036 - Phyluce - INFO - galGal4: 4966 uces, 35 dupes, 4931 non-dupes, 2 orient drop, 40 length drop, 4889 written
2016-06-01 16:02:28,036 - Phyluce - INFO - ------------------- Working on allMis2 genome -------------------
2016-06-01 16:02:28,037 - Phyluce - INFO - Reading allMis2 genome
2016-06-01 16:02:37,230 - Phyluce - INFO - allMis2: 4830 uces, 7 dupes, 4823 non-dupes, 2 orient drop, 3 length drop, 4818 written
```

And, your directory structure should look like:

```
uce-genome
├── allMis2
│   ├── allMis2.2bit
│   └── sizes.tab
├── galGal4
│   ├── galGal4.2bit
│   └── sizes.tab
├── genomes.conf
├── tutorial3-genome-lastz
│   ├── uce-5k-probes.fasta_v_allMis2.lastz.clean
│   └── uce-5k-probes.fasta_v_galGal4.lastz.clean
├── tutorial3.sqlite
├── tutorial-genome-fasta
│   ├── allmis2.fasta
│   └── galgal4.fasta
└── uce-5k-probes.fasta
```

The UCE contig sequence are in each respective file within
tutorial-genome-fasta.

### Using the extracted sequences in downstream analyses[](#using-the-extracted-sequences-in-downstream-analyses "Link to this heading")

The easiest way for you to use the extracted sequences is to basically pretend
like they are “newly assembled contigs” and place the fasta files (allmis2.fasta
as in the above) into a contigs directory. Alternatively, you can symlink them
into a new or existing contigs folder (that resulted from a [PHYLUCE](https://github.com/faircloth-lab/phyluce) assembly
process) and then proceed with the [Finding UCE loci](tutorial-1.html#finding-uce-loci) procedure.

> Attention
>
> Although we have alre