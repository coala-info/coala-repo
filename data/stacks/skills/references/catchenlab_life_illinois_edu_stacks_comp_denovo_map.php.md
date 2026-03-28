[![Stacks](/stacks/images/stacks_logo.png "Stacks")](/stacks)

## denovo\_map.pl

The denovo\_map.pl program will execute the Stacks pipeline by running each of the Stacks components individually. It is the
simplest way to run Stacks and it handles many of the details. The program performs several stages, including:

1. Running [ustacks](./ustacks.php "ustacks") on each of the samples specified, building loci
   *de novo* in each sample.
2. Executing [cstacks](./cstacks.php "cstacks") to create a *catalog* of all loci across the
   population (or from just the parents if processing a genetic map). Loci are matched up across samples according to sequence similarity.
3. Next, [sstacks](./sstacks.php "sstacks") will be executed to match each sample against the
   catalog. In the case of a genetic map, the parents and progeny are matched against the catalog.
4. The [tsv2bam](./tsv2bam.php "tsv2bam") program will be executed in order to transpose the data
   from being organized by sample, to being organized by RAD locus. This allows the downstream pipeline components to look at all data from
   across the meta-population for each locus. If paired-end reads are available, they will be fetched by
   tsv2bam and stored with the single-end reads for later use.
5. The [gstacks](./gstacks.php "gstacks") program is executed next. If paired-end reads are available,
   a contig will be assembled from them and overlapped with the single-end locus. SNPs will be called, and for each locus, the SNPs will be phased
   into haplotypes.
6. The [populations](./populations.php "populations") program will be run to generate population-level
   summary statistics and export data in a variety of formats. Computation is now complete.

### Specifying Samples

The raw data for each sample in the analysis has to be specified to Stacks. The denovo\_map.pl
program expects (but does not require) that your raw sequencing data were demultiplexed and cleaned by the
[process\_radtags](./process_radtags.php "process_radtags") program.

**All of your samples have to be sepcified together for a single run of the pipeline.** This is done by
specifying your list of samples to denovo\_map.pl by using a population map (--popmap)
as well as specifying the path to the directory containing all samples using the --samples
option. denovo\_map.pl will read the contents of the population map file and search for
each specified sample in the --samples directory.

### Using a population map

A population map contains assignments of each of your samples to a particular population. See
[the manual](/stacks/manual/#popmap) for more information on how they work. The denovo\_map.pl
program will not directly use the file except to read the sample names for processing. It is the populations
program that acutally uses the population map for statistical calculations, and denovo\_map.pl will provide
the map to the populations program. You can run the populations program by
hand, specifying other population maps as you like, after the pipeline completes its first execution.

### Passing additional arguments to Stacks component programs

The Stacks component programs contain a lot of possible options that can be invoked. It would be impractical to expose them all
througth the denovo\_map.pl wrapper program. Instead, you can pass additional options to internal
programs that denovo\_map.pl will execute using the -X. To use this option,
you specify (in quotes) the program the option goes to, followed by a colon (":"), followed by the option itself. For example,
-X "populations:--fstats" will pass the --fstats option to the
populations program. **Each option should be specified separately with
-X**. See [below](#examples) for examples.

### When not to use denovo\_map.pl

There are a few reasons to run the pipeline manually instead of using the denovo\_map.pl wrapper.

1. If you have a very large number of samples, you may not want to put them all in the catalog. In a population analysis,
   all of the samples specified to denovo\_map.pl will be loaded into the catalog. In a *de novo*
   analysis, each sample added to the catalog will also add a small fraction of error to the catalog. With a very large
   number of samples, the error can overwhelm true loci in the population. In this case you may only want to load a subset
   of each population in your analysis.
2. Again, if you have a lot of samples, you may want to speed your analysis by splitting up your samples and running them
   on a number of nodes in a cluster. In this case, you would have to queue up ustacks to run on
   different nodes with different samples. This can't be done using denovo\_map.pl.

### Post-processing with populations

Stacks is designed so that you run the core pipeline once (or several times to optimize parameters, then complete the final run), but
once it is complete, the core information (assembled loci, genotyped and phased into haplotypes across the meta-population) is
complete and does not need to be further modified. It is common to then run the populations program multiple
times. populations will read the core pipeline outputs and can then be used to filter the data in many
ways, to export the data in different formats, or to apply different population maps so the population genetics statistics are
calculated according to those different maps (e.g. by geography, phenotype, or environmnetal vairable).

## Program Options

denovo\_map.pl --samples dir --popmap path -o dir [--paired [--rm-pcr-duplicates]] (assembly options) (filtering options) [-X prog:"opts" ...]

### Input/Output files:

* --samples [path] — specify a path to the directory of samples (samples will be read from population map).
* --popmap [path] — path to a population map file (format is "[name] TAB [pop]", one sample per line).
* -o [path] — path to write pipeline output files.

### General options:

* -X — additional options for specific pipeline components, e.g. -X "populations: --min-maf 0.05".
* -T, --threads — the number of threads/CPUs to use (default: 1).
* --dry-run — dry run. Do not actually execute anything, just print the commands that would be executed.
* --resume — resume executing the pipeline from a previous run.

### Stack assembly options:

* -M — number of mismatches allowed between stacks within individuals (for ustacks).
* -n — number of mismatches allowed between stacks between individuals (for cstacks; default: set to ustacks -M).

### SNP model options:

* --var-alpha — significance level at which to call variant sites (for gstacks; default: 0.05).
* --gt-alpha — significance level at which to call genotypes (for gstacks; default: 0.05).

### Paired-end options:

* --paired — after assembling RAD loci, assemble contigs for each locus from paired-end reads.
* --rm-pcr-duplicates — remove all but one set of read pairs of the same sample that have
  the same insert length.

### Population filtering options:

* -p,--min-populations — minimum number of populations a locus must be present in to process
  a locus (for populations; default: 1)
* -r,--min-samples-per-pop — minimum percentage of individuals in a population required to
  process a locus for that population (for populations; default: 0)

### For large datasets:

* --catalog-popmap — path to a second population map file containing a subset of samples for use only in building the catalog.

### Miscellaneous:

* --time-components — (for benchmarking)

## Example Usage

### Single-end Reads

1. In this example, we will process single-end reads. We will supply a population map to denovo\_map.pl containing
   the names of the samples we want to analyze and we will tell denovo\_map.pl the directory the samples are located in.

   Your samples directory should look similar to this, after processing with process\_radtags:

   % ls samples/
   sample\_06.fq.gz sample\_07.01.fq.gz sample\_07.02.fq.gz sample\_09.fq.gz
   ...

   The population map would look like this:

   % cat ./treestudy\_popmap
   sample\_07.01 redlake
   sample\_07.02 redlake
   sample\_06 blueriver
   sample\_09 blueriver
   ...

   And we supply both of these paths to denovo\_map.pl, along with an output directory to store results and some parameter settings for builing loci.

   % denovo\_map.pl -M 5 -T 8 -o ./stacks --popmap ./treestudy\_popmap --samples ./samples
2. Building on the previous example, we will specifically tell the populations program to output only one SNP per RAD locus.

   % denovo\_map.pl -M 5 -o ./stacks --popmap ./treestudy\_popmap --samples ./samples -X "populations:--write-single-snp"
3. In this example, perhaps we are optimizing our *de novo* assembly paramters, following [the manual](/stacks/manual/#params). When doing so, we usually
   want to examine ***r80*** loci. To filter to those loci we can specify the --min-samples-per-pop flag (which
   denovo\_map.pl will pass onto the populations program). We may run several iterations of
   denovo\_map.pl, with different parameter choices, going to different output directories:

   % denovo\_map.pl -M 4 -o ./stacks/M4 --popmap ./treestudy\_popmap --samples ./samples --min-samples-per-pop 0.80
   % denovo\_map.pl -M 5 -o ./stacks/M5 --popmap ./treestudy\_popmap --samples ./samples --min-samples-per-pop 0.80
   % denovo\_map.pl -M 6 -o ./stacks/M6 --popmap ./treestudy\_popmap --samples ./samples --min-samples-per-pop 0.80
   % denovo\_map.pl -M 7 -o ./stacks/M7 --popmap ./treestudy\_popmap --samples ./samples --min-samples-per-pop 0.80
   % denovo\_map.pl -M 8 -o ./stacks/M8 --popmap ./treestudy\_popmap --samples ./samples --min-samples-per-pop 0.80

### Paired-end Reads

1. In this example, we will process paired-end reads. We will supply a population map to denovo\_map.pl containing
   the *common prefix* prefix of the names of the samples. The denovo\_map.pl program expects for a single
   sample that the file containing the single-end reads will end in a .1. and the corresponding paired-end file
   will end in a .2. (which is how process\_radtags will output them). We we will tell
   denovo\_map.pl the directory these sample files are located in.

   Your samples directory should look similar to this, after processing with process\_radtags:

   % ls samples/
   sample\_06.1.fq.gz sample\_07.01.1.fq.gz sample\_07.02.1.fq.gz sample\_09.1.fq.gz
   sample\_06.2.fq.gz sample\_07.01.2.fq.gz sample\_07.02.2.fq.gz sample\_09.2.fq.gz
   ...

   The population map would look like this:

   % cat ./treestudy\_popmap
   sample\_07.01 redlake
   sample\_07.02 redlake
   sample\_06 blueriver
   sample\_09 blueriver
   ...

   And we supply both of these paths to denovo\_map.pl, along with an output directory to store results and some parameter settings for builing loci.

   % denovo\_map.pl -M 5 -T 8 -o ./stacks --popmap ./treestudy\_popmap --samples ./samples --paired

   The denovo\_map.pl program will handle specifying the single-ends to the core pipeline (ustacks→cstacks→sstacks) and the paired-ends to tsv2bam.
2. Building on the previous example, it is good practice to filter paired-end data for PCR duplicates (it must be single-digest, sheared data). We can do that
   by passing the the --rm-pcr-duplicates flag to the denovo\_map.pl (which will pass it on to gstacks).

   % denovo\_map.pl -M 7 -T 8 -o ./stacks --popmap ./treestudy\_popmap --samples ./samples --rm-pcr-duplicates --paired

## Program Outputs

The main output of denovo\_map.pl is the log file, denovo\_map.log (and, of course, all of the individual pipeline components will
create their own output). The denovo\_map.log file will capture all of the outputs from the component programs, so each sample run in
ustacks, the cstacks, sstacks, tsv2bam, gstacks, and
populations.

The denovo\_map.log log file will also provide a table listing the depth of sequencing coverage for each sample processed (as calculated by
ustacks) for the single-end reads. It will look similar to this:

sample loci assembled depth of cov max cov number reads incorporated % reads incorporated
sample\_07.01 41228 19.77 291 303663 81.6
sample\_07.02 39101 18.62 212 249467 74.0
sample\_06 35506 17.87 231 199709 86.0
sample\_09 48445 12.24 295 233270 83.6
...

A convenient way to extract this information from the large log file is to use the stacks-dist-extract utility, like this:

stacks-dist-extract --pretty denovo\_map.log cov\_per\_sample

This is a key metric in any *de novo* map analysis.

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
of a genetic cross, a catalog would be constructed from the parents of the cros