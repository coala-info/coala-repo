[![Stacks](/stacks/images/stacks_logo.png "Stacks")](/stacks)

## ref\_map.pl

The ref\_map.pl program will execute the Stacks pipeline by running each of the Stacks components individually. It is the
simplest way to run Stacks and it handles many of the details, such as sample numbering. The
ref\_map.pl program expects data to have been aligned to a reference genome, and can accept data from any aligner that
can produce [BAM](http://samtools.sourceforge.net) formated files. The program performs several stages, including:

1. Running [gstacks](./gstacks.php "pstacks") on the samples specified, assembling loci
   according to the alignment positions provided for each read, and calling SNPs in each sample.
2. The [populations](./populations.php "populations") program will
   be run to generate population-level summary statistics. The population map (--popmap option) you specify will be
   supplied to populations.

### Specifying Samples

The raw data for each sample in the analysis has to be specified to Stacks. **All of your samples have to be
specified together for a single run of the pipeline.** Samples are specified to ref\_map.pl by supplying a population map (--popmap) and the path to the
directory containing all samples (--samples option). ref\_map.pl
will read the contents of the population map file and search for each specified sample in the --samples directory.

For ref\_map.pl, samples must be aligned to a reference genome and the resulting BAM files must
be sorted. To process paired-end reads, in addition to single-end reads, make sure the aligner is given both single- and
paired-end reads when you align the reads to the reference genome. The resulting BAM file will then contain both sets
of reads and gstacks will detect that and continue with a paired-end analysis.

### Using a population map

A population map contains assignments of each of your samples to a particular population. See the
[manual](/stacks/manual/#popmap) for more information on how they work. The ref\_map.pl
program will not directly use the file, beyond reading the sample names out of it. It is the populations
program that acutally uses the population map for statistical calculations, and ref\_map.pl will provide
the map to the populations program. You can run the populations program by
hand, specifying other population maps as you like, after the pipeline completes its first execution.

### Passing additional arguments to Stacks component programs

The Stacks component programs contain a lot of possible options that can be invoked. It would be impractical to expose them all
througth the ref\_map.pl wrapper program. Instead, you can pass additional options to internal
programs that ref\_map.pl will execute using the -X. To use this option,
you specify (in quotes) the program the option goes to, followed by a colon (":"), followed by the option itself. For example,
-X "populations:--fstats" will pass the --fstats option to the
populations program. Another example, -X "populations:-r 0.8" will pass the
-r option, with the argument 0.8, to the populations
program. **Each option should be specified separately with -X**.

### Some notes on alignments

The ref\_map.pl program takes as input aligned reads. It does not provide the assembly parameters that
denovo\_map.pl does and this is because the job of assembling the loci is being taken over by your
aligner program (e.g. BWA or Bowtie2). You must take care that you have good alignmnets — discarding reads with multiple alignments,
making sure that you do not allow too many gaps in your sequences (otherwise loci with repeat elements can easily be collapsed
during alignments), and take care not to allow *soft-masking* in the alignments. This occurs when an aligner can not make
a full alignment and instead *soft-masks* the portion of the read that could not be aligned (pretending that this part of
the read does not exist). These factors, if not cared for, can cause spurious SNP calls and problems in the downstream analysis.

### Post-processing with populations

Stacks is designed so that you run the core pipeline once, and the core information (assembled loci, genotyped and phased into
haplotypes across the meta-population) is complete and does not need to be further modified. It is common to then run the
populations program multiple times. populations will read the core pipeline
outputs and can then be used to filter the data in many ways, to export the data in different formats, or to apply different
population maps so the population genetics statistics are calculated according to those different maps (e.g. by geography,
phenotype, or environmnetal vairable).

## Program Options

ref\_map.pl --samples dir --popmap path [-s spacer] --out-path path [--rm-pcr-duplicates] [-X prog:"opts" ...]

### Input/Output files:

* --samples [path] — path to the directory containing the samples BAM (or SAM) alignment files.
* --popmap [path] — path to a population map file (format is " TAB ", one sample per line).
* s [spacer for file names] — by default this is empty and the program looks for files
  named 'SAMPLE\_NAME.bam'; if this option is given the program looks for files named 'SAMPLE\_NAME.SPACER.bam'.
* o [path] — path to an output directory.

### General options:

* X — additional options for specific pipeline components, e.g. -X "populations: -p 3 -r 0.50"
* T — the number of threads/CPUs to use (default: 1).
* d — Dry run. Do not actually execute anything, just print the individual pipeline commands that would be executed.

### Paired-end options:

* --rm-pcr-duplicates — remove all but one copy of read pairs of the same sample that have
  the same insert length.
* --ignore-pe-reads — ignore paired-end reads even if present in the input
* --unpaired — ignore read pairing (for paired-end GBS; treat READ2's as if they were READ1's)

### SNP model options:

* --var-alpha — significance level at which to call variant sites (for gstacks; default: 0.05).
* --gt-alpha — significance level at which to call genotypes (for gstacks; default: 0.05).

### Miscellaneous:

* --time-components — (for benchmarking)

## Example Usage

1. In this example, we will supply a population map to ref\_map.pl containing the names of the samples we want to
   analyze, and we will tell ref\_map.pl the directory the samples are located in.

   Your samples directory should look similar to this, after cleaning/demultiplexing with process\_radtags and
   then aligning and sorting them with, e.g. BWA-MEM and samtools:

   % ls aligned/
   blue\_1827.19.bam blue\_1827.25.bam blue\_1827.05.bam red\_2827.01.bam red\_2827.07.bam red\_2827.13.bam
   ...

   The population map would look like this:

   % cat ./fishes\_popmap
   red\_2827.01 redlake
   red\_2827.07 redlake
   blue\_1827.19 blueriver
   blue\_1827.25 blueriver
   ...

   And we supply both of these paths to ref\_map.pl:

   % ref\_map.pl -T 8 -o ./stacks --popmap ./fishes\_popmap --samples ./aligned
2. In this example, we will instruct ref\_map.pl to tell populations
   to enable F statistics.

   % ref\_map.pl -o ./stacks --popmap ./fishes\_popmap --samples ./aligned -X "populations:--fstats"

## Program Outputs

The main output of ref\_map.pl is the log file, ref\_map.log (and, of course, all of the individual pipeline components will
create their own output). The ref\_map.log file will capture all of the outputs from the component programs, including gstacks
and populations.

Two key pieces of information from this file are output from gstacks and include how many of the alignments could be incorporated by Stacks,
which looks similar to this:

Read 29454283 BAM records:
kept 26626342 primary alignments (92.5%), of which 12643825 reverse reads
skipped 273219 primary alignments with insufficient mapping qualities (0.9%)
skipped 1049409 excessively soft-clipped primary alignments (3.6%)
skipped 840054 unmapped reads (2.9%)
skipped some suboptimal (secondary/supplementary) alignment records

The mean coverage per-sample can also be found in this file, however per-sample coverages are found in the gstacks.log.distribs file. The mean
coverage looks like this:

Genotyped 99505 loci:
effective per-sample coverage: mean=15.1x, stdev=1.3x, min=12.9x, max=17.1x

## Other Pipeline Programs

|  |  |  |  |
| --- | --- | --- | --- |
| Raw reads  * [process\_radtags](/stacks/comp/process_radtags.php) * [process\_shortreads](/stacks/comp/process_shortreads.php) * [clone\_filter](/stacks/comp/clone_filter.php) * [kmer\_filter](/stacks/comp/kmer_filter.php) | Core  * [ustacks](/stacks/comp/ustacks.php) * [cstacks](/stacks/comp/cstacks.php) * [sstacks](/stacks/comp/sstacks.php) * [tsv2bam](/stacks/comp/tsv2bam.php) * [gstacks](/stacks/comp/gstacks.php) * [populations](/stacks/comp/populations.php) | Execution control  * [denovo\_map.pl](/stacks/comp/denovo_map.php) * [ref\_map.pl](/stacks/comp/ref_map.php) | Utility programs  * [stacks-dist-extract](/stacks/comp/stacks_dist_extract.php) * [stacks-integrate-alignments](/stacks/comp/stacks_integrate_alignments.php) * [stacks-private-alleles](/stacks/comp/stacks_private_alleles.php) |

The process\_radtags program examines raw reads from an Illumina sequencing run and
first, checks that the barcode and the restriction enzyme cutsite are intact (correcting minor errors).
Second, it slides a window down the length of the read and checks the average quality score within the window.
If the score drops below 90% probability of being correct, the read is discarded. Reads that pass quality
thresholds are demultiplexed if barcodes are supplied.

The process\_shortreads program performs the same task as process\_radtags
for fast cleaning of randomly sheared genomic or transcriptomic data. This program will trim reads that are below the
quality threshold instead of discarding them, making it useful for genomic assembly or other analyses.

The clone\_filter program will take a set of reads and reduce them according to PCR
clones. This is done by matching raw sequence or by referencing a set of random oligos that have been included in the sequence.

The kmer\_filter program allows paired or single-end reads to be filtered according to the
number or rare or abundant kmers they contain. Useful for both RAD datasets as well as randomly sheared genomic or
transcriptomic data.

The ustacks program will take as input a set of short-read sequences and align them into
exactly-matching stacks. Comparing the stacks it will form a set of loci and detect SNPs at each locus using a
maximum likelihood framework.

A catalog can be built from any set of samples processed
by the ustacks program. It will create a set of consensus loci, merging alleles together. In the case
of a genetic cross, a catalog would be constructed from the parents of the cross to create a set of
all possible alleles expected in the progeny of the cross.

Sets of stacks constructed by the ustacks
program can be searched against a catalog produced by the cstacks program. In the case of a
genetic map, stacks from the progeny would be matched against the catalog to determine which progeny
contain which parental alleles.

The tsv2bam program will transpose data so that it is oriented by locus, instead of by sample.
In additon, if paired-ends are available, the program will pull in the set of paired reads that are associate with each
single-end locus that was assembled *de novo*.

The gstacks - For *de novo* analyses, this program will pull in paired-end
reads, if available, assemble the paired-end contig and merge it with the single-end locus, align reads
to the locus, and call SNPs. For reference-aligned analyses, this program will build loci from the
single and paired-end reads that have been aligned and sorted.

This populations program will compute population-level summary statistics such
as π, FIS, and FST. It can output site level SNP calls in VCF format and
can also output SNPs for analysis in STRUCTURE or in Phylip format for phylogenetics analysis.

The denovo\_map.pl program executes each of the Stacks components to create a genetic
linkage map, or to identify the alleles in a set of populations.

The ref\_map.pl program takes reference-aligned input data and executes each of the Stacks
components, using the reference alignment to form stacks, and identifies alleles. It can be used in a genetic map
of a set of populations.

The load\_radtags.pl program takes a set of data produced by either the denovo\_map.pl or
ref\_map.pl progams (or produced by hand) and loads it into the database. This allows the data to be generated on
one computer, but loaded from another. Or, for a database to be regenerated without re-executing the pipeline.

The stacks-dist-extract script will pull data distributions from the log and distribs
files produced by the Stacks component programs.

The stacks-integrate-alignments script will take loci produced by the *de novo* pipeline,
align them against a reference genome, and inject the alignment coordinates back into the *de novo*-produced data.

The stacks-private-alleles script will extract private allele data from the populations program
outputs and output useful summaries and prepare it for plotting.