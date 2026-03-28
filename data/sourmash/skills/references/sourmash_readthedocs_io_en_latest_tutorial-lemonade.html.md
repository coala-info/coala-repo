# [Analyzing the genomic and taxonomic composition of an environmental genome using GTDB and sample-specific MAGs with sourmash](#id1)[¶](#analyzing-the-genomic-and-taxonomic-composition-of-an-environmental-genome-using-gtdb-and-sample-specific-mags-with-sourmash "Link to this heading")

C. Titus Brown, Taylor Reiter, and Tessa Pierce Ward

July 2022

Based on a tutorial developed for MBL STAMPS 2022.

You’ll need 5 GB of disk space and 5 GB of RAM in order to run this tutorial.
It will take about 30 minutes of compute time to execute all the commands.

---

Contents

* [Analyzing the genomic and taxonomic composition of an environmental genome using GTDB and sample-specific MAGs with sourmash](#analyzing-the-genomic-and-taxonomic-composition-of-an-environmental-genome-using-gtdb-and-sample-specific-mags-with-sourmash)

  + [Install sourmash](#install-sourmash)
  + [Create a working subdirectory](#create-a-working-subdirectory)
  + [Download a database and a taxonomy spreadsheet.](#download-a-database-and-a-taxonomy-spreadsheet)
  + [Download and prepare sample reads](#download-and-prepare-sample-reads)
  + [Find matching genomes with `sourmash gather`](#find-matching-genomes-with-sourmash-gather)
  + [Build a taxonomic summary of the metagenome](#build-a-taxonomic-summary-of-the-metagenome)
  + [Interlude: why reference-based analyses are problematic for environmental metagenomes](#interlude-why-reference-based-analyses-are-problematic-for-environmental-metagenomes)
  + [Update gather with information from MAGs](#update-gather-with-information-from-mags)
  + [Classify the taxonomy of the MAGs; update metagenome classification](#classify-the-taxonomy-of-the-mags-update-metagenome-classification)
  + [Interlude: where we are and what we’ve done so far](#interlude-where-we-are-and-what-we-ve-done-so-far)
  + [Summary and concluding thoughts](#summary-and-concluding-thoughts)

In this tutorial, we’ll use sourmash to analyze the composition of a metagenome, both genomically and taxonomically. We’ll also use sourmash to classify some MAGs and integrate them into our analysis.

## [Install sourmash](#id2)[¶](#install-sourmash "Link to this heading")

First, we need to install the software! We’ll use conda/mamba to do this.

The below command installs [sourmash](http://sourmash.readthedocs.io/) and [GNU parallel](https://www.gnu.org/software/parallel/).

Run:

```
# create a new environment
mamba create -n smash -y -c conda-forge -c bioconda sourmash parallel
```

to install the software, and then run

```
conda activate smash
```

to activate the conda environment so you can run the software.

Note

Victory conditions: your prompt should start with
`(smash)`
and you should now be able to run `sourmash` and have it output usage information!!

## [Create a working subdirectory](#id3)[¶](#create-a-working-subdirectory "Link to this heading")

Make a directory named `kmers` and change into it.

```
mkdir ~/kmers
cd ~/kmers
```

## [Download a database and a taxonomy spreadsheet.](#id4)[¶](#download-a-database-and-a-taxonomy-spreadsheet "Link to this heading")

We’re going to start by doing a reference-based *compositional analysis* of the lemonade metagenome from [Taylor Reiter’s STAMPS 2022 tutorial on assembly and binning](https://github.com/mblstamps/stamps2022/blob/main/assembly_and_binning/tutorial_assembly_and_binning.md).

For this purpose, we’re going to need a database of known genomes. We’ll use the GTDB genomic representatives database, containing ~65,000 genomes - that’s because it’s smaller than the full GTDB database (~320,000) or Genbank (~1.3m), and hence faster. But you can download and use those on your own, if you like!

You can find the link to a prepared GTDB RS207 database for k=31 on the [the sourmash prepared databases page](https://sourmash.readthedocs.io/en/latest/databases.html). Let’s download it to the current directory:

```
curl -JLO https://osf.io/3a6gn/download
```

This will create a 1.7 GB file:

```
ls -lh gtdb-rs207.genomic-reps.dna.k31.zip
```

and you can examine the contents with sourmash `sig summarize`:

```
sourmash sig summarize gtdb-rs207.genomic-reps.dna.k31.zip
```

which will show you:

```
>path filetype: ZipFileLinearIndex
>location: /home/stamps2022/kmers/gtdb-rs207.genomic-reps.dna.k31.zip
>is database? yes
>has manifest? yes
>num signatures: 65703
>** examining manifest...
>total hashes: 212454591
>summary of sketches:
>   65703 sketches with DNA, k=31, scaled=1000, abund  212454591 total hashes
```

There’s a lot of things to digest in this output but the two main ones are:

* there are 65,703 genome sketches in this database, for a k-mer size of 31
* this database represents 212 *billion* k-mers (multiply number of hashes by the scaled number)

If you want to read more about what, exactly, sourmash is doing, please see [Lightweight compositional analysis of metagenomes with FracMinHash and minimum metagenome covers](https://www.biorxiv.org/content/10.1101/2022.01.11.475838v2), Irber et al., 2022.

We also want to download the accompanying taxonomy spreadsheet:

```
curl -JLO https://osf.io/v3zmg/download
```

and uncompress it:

```
gunzip gtdb-rs207.taxonomy.csv.gz
```

This spreadsheet contains information connecting Genbank genome identifiers to the GTDB taxonomy - take a look:

```
head -2 gtdb-rs207.taxonomy.csv
```

will show you:

```
>ident,superkingdom,phylum,class,order,family,genus,species
>GCF_000566285.1,d__Bacteria,p__Proteobacteria,c__Gammaproteobacteria,o__Enterobacterales,f__Enterobacteriaceae,g__Escherichia,s__Escherichia coli
```

Let’s index the taxonomy database using SQLite, for faster access later on:

```
sourmash tax prepare -t gtdb-rs207.taxonomy.csv \
    -o gtdb-rs207.taxonomy.sqldb -F sql
```

This creates a file `gtdb-rs207.taxonomy.sqldb` that contains all the information in the CSV file, but which is faster to load than the CSV file.

## [Download and prepare sample reads](#id5)[¶](#download-and-prepare-sample-reads "Link to this heading")

Next, let’s download one of the metagenomes from [the assembly and binning tutorial](https://github.com/mblstamps/stamps2022/blob/main/assembly_and_binning/tutorial_assembly_and_binning.md#retrieving-the-data).

We’ll use sample SRR8859675 for today, and you can view sample info [here](https://www.ebi.ac.uk/ena/browser/view/SRR8859675?show=reads) on the ENA.

To download the metagenome from the ENA, run:

```
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR885/005/SRR8859675/SRR8859675_1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR885/005/SRR8859675/SRR8859675_2.fastq.gz
```

Now we’re going to prepare the metagenome for use with sourmash by converting it into a *signature file* containing *sketches* of the k-mers in the metagenome. This is the step that “shreds” all of the reads into k-mers of size 31, and then does further data reduction by [sketching](https://en.wikipedia.org/wiki/Streaming_algorithm) the resulting k-mers.

To build a signature file, we run `sourmash sketch dna` like so:

```
sourmash sketch dna -p k=31,abund SRR8859675*.gz \
    -o SRR8859675.sig.gz --name SRR8859675
```

Here we’re telling sourmash to sketch at k=31, and to track k-mer multiplicity (with ‘abund’). We sketch *both* metagenome files together into a single signature named `SRR8859675` and stored in the file `SRR8859675.sig.gz`.

When we run this, we should see:

> `calculated 1 signature for 3452142 sequences taken from 2 files`

which tells you how many reads there are in these two files!

If you look at the resulting files,

```
ls -lh SRR8859675*
```

you’ll see that the signature file is *much* smaller (2.5mb) than the metagenome files (~600mb). This is because of the way sourmash uses a reduced representation of the data, and it’s what makes sourmash fast. Please see the paper above for more info!

Also note that the GTDB prepared database we downloaded above was built using the same `sourmash sketch dna` command, but applied to 65,000 genomes and stored in a zip file.

## [Find matching genomes with `sourmash gather`](#id6)[¶](#find-matching-genomes-with-sourmash-gather "Link to this heading")

At last, we have the ingredients we need to analyze the metagenome against GTDB!

* the software is installed
* the GTDB database is downloaded
* the metagenome is downloaded and sketched

Now, we’ll run the [sourmash gather](https://sourmash.readthedocs.io/en/latest/command-line.html#sourmash-gather-find-metagenome-members) command to find matching genomes.

Run gather - this will take ~6 minutes:

```
sourmash gather SRR8859675.sig.gz gtdb-rs207.genomic-reps.dna.k31.zip --save-matches matches.zip
```

Here we are saving the matching genome sketches to `matches.zip` so we can rerun the analysis if we like.

The results will look like this:

```
overlap     p_query p_match avg_abund
---------   ------- ------- ---------
2.0 Mbp        0.4%   31.8%       1.3    GCF_004138165.1 Candidatus Chloroploc...
1.9 Mbp        0.5%   66.9%       2.1    GCF_900101955.1 Desulfuromonas thioph...
0.6 Mbp        0.3%   23.3%       3.2    GCA_016938795.1 Chromatiaceae bacteri...
0.6 Mbp        0.5%   27.3%       6.6    GCA_016931495.1 Chlorobiaceae bacteri...
...
found 22 matches total;
the recovered matches hit 5.3% of the abundance-weighted query
```

In this output:

* the last column is the name of the matching GTDB genome
* the first column is the estimated overlap between the metagenome and that genome, in base pairs (estimated from shared k-mers)
* the second column, `p_query` is the percentage of metagenome k-mers (weighted by multiplicity) that match to the genome; this will approximate the percentage of *metagenome reads* that will map to this genome, if you map.
* the third column, `p_match`, is the percentage of the genome k-mers that are matched by the metagenome; this will approximate the percentage of *genome bases* that will be covered by mapped reads;
* the fourth column is the estimated mean abundance of this genome in the metagenome.

The other interesting number is here:

> `the recovered matches hit 5.3% of the abundance-weighted query`

which tells you that you should expect about 5.3% of the metagenome reads to map to these 22 reference genomes.

Note

You can try running gather without abundance weighting:

`sourmash gather SRR8859675.sig.gz matches.zip --ignore-abundance`

How does the output differ?

The main number that changes bigly is:

> `the recovered matches hit 2.4% of the query (unweighted)`

which represents the proportion of *unique* kmers in the metagenome that are not found in any genome.

This is (approximately) the following number:

* suppose you assembled the entire metagenome perfectly into perfect contigs (**note, this is impossible, although you can get close with “unitigs”**);
* and then matched all the genomes to the contigs;
* approximately 2.4% of the bases in the contigs would have genomes that match to them.

Interestingly, this is the *only* number in this entire tutorial that is essentially impossible to estimate any way other than with k-mers.

This number is also a big underestimate of the “true” number for the metagenome - we’ll explain more later :)

## [Build a taxonomic summary of the metagenome](#id7)[¶](#build-a-taxonomic-summary-of-the-metagenome "Link to this heading")

We can use these matching genomes to build a taxonomic summary of the metagenome using [sourmash tax metagenome](https://sourmash.readthedocs.io/en/latest/command-line.html#sourmash-tax-subcommands-for-integrating-taxonomic-information-into-gather-results) like so:

```
# rerun gather, save the results to a CSV
sourmash gather SRR8859675.sig.gz matches.zip -o SRR8859675.x.gtdb.csv

# use tax metagenome to classify the metagenome
sourmash tax metagenome -g SRR8859675.x.gtdb.csv \
    -t gtdb-rs207.taxonomy.sqldb -F human -r order
```

this shows you the rank, taxonomic lineage, and weighted fraction of the metagenome at the ‘order’ rank.

At the bottom, we have a script to plot the resulting taxonomy using [metacoder](https://grunwaldlab.github.io/metacoder_documentation/) - here’s what it looks like:

![metacoder output](https://raw.githubusercontent.com/mblstamps/stamps2022/main/kmers_and_sourmash/metacoder_gather.png)

## [Interlude: why reference-based analyses are problematic for environmental metagenomes](#id8)[¶](#interlude-why-reference-based-analyses-are-problematic-for-environmental-metagenomes "Link to this heading")

Reference-based metagenome classification is highly dependent on the organisms present in our reference databases.
For well-studied environments, such as human-associated microbiomes, your classification percentage is likely to be quite high.
In contrast, this is an environmental metagenome, and you can see that we’re estimating only 5.3% of it will map to GTDB reference genomes!

Wow, that’s **terrible**! Our taxonomic and/or functional analysis will be based on only 1/20th of the data!

What could we do to improve that?? There are two basic options -

(1) Use a more complete reference database, like the entire GTDB, or Genbank. This will only get you so far, unfortunately. (See exercises at end.)
(2) Assemble and bin the metagenome to produce new reference genomes!

There are other things you could think about doing here, too, but these are probably the “easiest” options. And what’s super cool is that we did the second one as part of [Taylor Reiter’s STAMPS 2022 tutorial on assembly and binning](https://github.com/mblstamps/stamps2022/blob/main/assembly_and_binning/tutorial_assembly_and_binning.md). So can we include that in the analysis??

Yes, yes we can! We can integrate the three MAGs that Taylor generated during her tutorial into the sourmash analysis.

We’ll need to:

* download the three genomes;
* sketch them with k=31;
* re-run sourmash gather with both GTDB *and* the MAGs.

Let’s do it!!

## [Update gather with information from MAGs](#id9)[¶](#update-gather-with-information-from-mags "Link to this heading")

First, download the MAGs:

```
# Download 3 MAGs generated by ATLAS
curl -JLO https://osf.io/fejps/download
curl -JLO https://osf.io/jf65t/download
curl -JLO https://osf.io/2a4nk/download
```

This will produce three files, `MAG*.fasta`.

Now sketch them:

```
sourmash sketch dna MAG*.fasta --name-from-first
```

here, `--name-from-first` is a convenient way to give them distinguishing names based on the name of the first contig in the FASTA file; you can see the names of the signatures by doing:

```
sourmash sig describe MAG1.fasta.sig
```

Now, let’s re-do the metagenome classification with the MAGs:

```
sourmash gather SRR8859675.sig.gz MAG*.sig matches.zip -o SRR8859675.x.gtdb+MAGS.csv
```

and look, we classify a lot more!

```
overlap     p_query p_match avg_abund
---------   ------- ------- ---------
2.3 Mbp       12.1%   99.9%      39.4    MAG2_1
2.2 Mbp       26.5%   99.9%      92.4    MAG3_1
2.0 Mbp        0.4%   31.8%       1.3    GCF_004138165.1 Candid