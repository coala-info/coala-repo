[phyluce](../index.html)

Contents:

* [Purpose](../purpose.html)
* [Installation](../installation.html)
* [Phyluce Tutorials](../tutorials/index.html)
* [Phyluce in Daily Use](index.html)
  + Quality Control
    - [Read Counts](#read-counts)
      * [Count reads using shell tools](#count-reads-using-shell-tools)
      * [Get read counts using phyluce](#get-read-counts-using-phyluce)
    - [Adapter- and quality-trimming](#adapter-and-quality-trimming)
      * [Trimming with illumiprocessor](#trimming-with-illumiprocessor)
  + [Assembly](daily-use-2-assembly.html)
  + [UCE Processing for Phylogenomics](daily-use-3-uce-processing.html)
  + [Workflows](daily-use-4-workflows.html)
  + [List of Phyluce Programs](list-of-programs.html)

* [Citing](../citing.html)
* [License](../license.html)
* [Attributions](../attributions.html)
* [Funding](../funding.html)
* [Acknowledgements](../ack.html)

[phyluce](../index.html)

* [Phyluce in Daily Use](index.html)
* Quality Control
* [View page source](../_sources/daily-use/daily-use-1-quality-control.rst.txt)

---

# Quality Control[](#quality-control "Link to this heading")

When you receive your data from the sequencer, typically they are already
demultiplexed (split by sequence tags) for you. If your data are from the
[MiSeq](http://www.illumina.com/systems/miseq.ilmn), they may also have been trimmed of adapter contamination.

Note

If your data are not demultiplexed, they can come in a vast array
of different types, although one common type are so-called BCL-files.
Regardless, if your data are not demultiplexed fastq files, you will need to
talk to your sequencing provider about how to accomplish demultiplexing. I
provide an **unsupported** guide to demultiplexing *BCL* files using [Casava](http://support.illumina.com/sequencing/sequencing_software/casava.ilmn)
or bcl2fastq [here](https://gist.github.com/brantfaircloth/3125885) and a
guide to demultiplexing fastq data [here](http://protocols.faircloth-lab.org/en/latest/protocols-computer/sequencing/sequencing-demultiplex-a-run.html)

Regardless, you need to do a fair bit of quality control on your read data.
**At a minimum**, this includes:

* getting some idea of how much data you have
* trimming adapter contamination of reads
* trimming low quality bases from reads

Although the MiSeq may trim some adapter contamination, running your reads through an additional round of trimming won’t hurt. There is also [lots of evidence](http://scholar.google.com/scholar?q=sequence+quality+affects+short+read+assembly&btnG=&hl=en&as_sdt=0%2C5) showing that quality control of your read data has a **large** effect on your overall success, particularly for the most common way of working with data in [phyluce](https://github.com/faircloth-lab/phyluce). Bottom line is: *garbage in, garbage out*.

## Read Counts[](#read-counts "Link to this heading")

The first thing to do once you have your read data in hand is to to get an idea
of the split of reads among your samples. This does two things:

1. Allows you to determine how well you split the run among your indexes/sequence tags
2. Shows you which samples may be suboptimal (have very few reads)

Really unequal read counts mean that you may want to switch up your library
quantification process (or your pooling steps, prior to enrichment). Suboptimal
read counts for particular libraries may or may not mean that the enrichments
of those samples “failed”, but it’s generally a reasonable indication.

You can get read counts in one of two way - the first is very simple, the
second uses [phyluce](https://github.com/faircloth-lab/phyluce).

### Count reads using shell tools[](#count-reads-using-shell-tools "Link to this heading")

You can get a quick and dirty idea of the number of reads you have for each
sample using simple shell or “terminal” tools - counting lines in lots of files
is a task that’s really suited to UNIX-like operating systems. As mentioned in
[Tutorial I: UCE Phylogenomics](../tutorials/tutorial-1.html#tutorialone) section, we can do this several ways. We’ll use tools from
unix, because they are fast. The next line of code will count the lines in each
R1 file (which should be equal to the reads in the R2 file) and divide that
number by 4 to get the number of sequence reads.

```
for i in *_R1_*.fastq.gz; do echo $i; gunzip -c $i | wc -l | awk '{print $1/4}'; done
```

The number of reads in the R2 files, if you have paired-end data, should **always**
be equal.

### Get read counts using [phyluce](https://github.com/faircloth-lab/phyluce)[](#get-read-counts-using-phyluce "Link to this heading")

There is a bit of code in phyluce that lets you count reads. To use it, you
pass the code the directory containing reads you want to summarize and run:

```
phyluce_assembly_get_fastq_lengths --input /directory/containing/reads/ --csv; done
```

You can run this across many directories of reads as described in
[Tutorial I: UCE Phylogenomics](../tutorials/tutorial-1.html#tutorialone).

## Adapter- and quality-trimming[](#adapter-and-quality-trimming "Link to this heading")

Generally speaking, [Casava](http://support.illumina.com/sequencing/sequencing_software/casava.ilmn) and [bcl2fastq](https://support.illumina.com/downloads/bcl2fastq_conversion_software_184.ilmn), the two programs used to demultiplex
sequence data from [Illumina](http://www.illumina.com/) platforms, output fastq files in a format similar
to the following:

```
Project_name/
    Sample_BFIDT-000
        BFIDT-000_AGTATAGCGC_L001_R1_001.fastq.gz
        BFIDT-000_AGTATAGCGC_L001_R2_001.fastq.gz
    Sample_BFIDT-001
        BFIDT-001_TTGTTGGCGG_L001_R1_001.fastq.gz
        BFIDT-001_TTGTTGGCGG_L001_R2_001.fastq.gz
```

What you want to do is to clean these reads of adapter contamination
and trim low-quality bases from all reads (and probably also drop reads
containing “N” (ambiguous) bases. Then you want to interleave the resulting
data, where read pairs are maintained, and also have an output file of singleton
data, where read pairs are not.

You can do this however you like. [phyluce](https://github.com/faircloth-lab/phyluce) assumes that the results structure of
your data after trimming will look like the following (replace genus\_species
with your taxon names):

```
genus_species1/
    split-adapter-quality-trimmed/
        genus_species1-READ1.fastq.gz
        genus_species1-READ2.fastq.gz
        genus_species1-READ-singleton.fastq.gz
genus_species2/
    split-adapter-quality-trimmed/
        genus_species2-READ1.fastq.gz
        genus_species2-READ2.fastq.gz
        genus_species2-READ-singleton.fastq.gz
```

This can be accomplished in an automated fashion using [illumiprocessor](https://github.com/faircloth-lab/illumiprocessor/).

### Trimming with illumiprocessor[](#trimming-with-illumiprocessor "Link to this heading")

You can run your adapter and quality trimming and output the files in the
correct format using a program I wrote called [illumiprocessor](https://github.com/faircloth-lab/illumiprocessor/). It automates
these processes over hundred of files and produces output in the format we want
downstream.

You need to generate a configuration file `your-illumiprocessor.conf`, that
gives details of your reads, how you want them processed, and what renaming
options to use. There are **several** variations in formatting required
depending on the library preparation method that you used.

Attention

See the documentation for [illumiprocessor](https://github.com/faircloth-lab/illumiprocessor/) for configuration
information.

You can run illumiprocessor against your data (in demultiplexed) with the
following. If you do not have a multicore machine, you may want to run with
`--cores=1`. Additionally, multicore operations require a fair amount of RAM,
so if you’re low on RAM, run with fewer cores:

```
illumiprocessor \
    --input demultiplexed \
    --output uce-clean \
    --config your-illumiprocesser.conf \
    --cores 12
```

The clean data will appear in `uce-clean` with the following structure:

```
uce-clean/
    genus_species1/
        adapters.fasta
        raw-reads/
            genus_species1-READ1.fastq.gz (symlink)
            genus_species1-READ2.fastq.gz (symlink)
        split-adapter-quality-trimmed/
            genus_species1-READ1.fastq.gz
            genus_species1-READ2.fastq.gz
            genus_species1-READ-singleton.fastq.gz
        stats/
            genus_species1-adapter-contam.txt

    genus_species2/
        adapters.fasta
        raw-reads/
            genus_species2-READ1.fastq.gz (symlink)
            genus_species2-READ2.fastq.gz (symlink)
        split-adapter-quality-trimmed/
            genus_species2-READ1.fastq.gz
            genus_species2-READ2.fastq.gz
            genus_species2-READ-singleton.fastq.gz
        stats/
            genus_species2-adapter-contam.txt
```

You are now ready to move onto [Assembly](daily-use-2-assembly.html#assembly) of the cleaned read data.

[Previous](index.html "Phyluce in Daily Use")
[Next](daily-use-2-assembly.html "Assembly")

---

© Copyright 2012-2024, Brant C. Faircloth.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).