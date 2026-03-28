[![Stacks](/stacks/images/stacks_logo.png "Stacks")](/stacks)

## stacks-dist-extract

The stacks-dist-extract script will export a paricular section of a Stacks log or distribs file, either for easy
viewing (e.g. using the --pretty option), or for plotting. If you supply a log path alone, stacks-dist-extract
will print the available sections to output. The log file can also be supplied via stdin (which then requires the user to supply the
--section option).

The Stacks component programs tend to output two types of files, \*.log files and \*.distribs files. While
these files are all plain text files, and can therefore be viewed using standard UNIX tools (e.g., less,
more, or cat), these files can be large and can contain a number of differt data sets of interest,
and stacks-dist-extract makes it easy to pull out particular data sets.

## Program Options

stacks-dist-extract logfile [section]
stacks-dist-extract [--pretty] [--out-path path] logfile [section]
cat logfile | stacks-dist-extract [--pretty] --section section

* -p, --pretty — Output data as a table with columns lined up.
* -o, --out-path path — Path to output file.
* -s, --section section — Name of section to output from the log file.

## Example Usage

1. If we want to know what sections are available for extraction, we can run the script on a \*.log or
   \*.distribs file without specifying a section, and the script will tell us our options:

   % stacks-dist-extract ./stacks/population\_r80/populations.log.distribs
   batch\_progress
   samples\_per\_loc\_prefilters
   missing\_samples\_per\_loc\_prefilters
   snps\_per\_loc\_prefilters
   samples\_per\_loc\_postfilters
   missing\_samples\_per\_loc\_postfilters
   snps\_per\_loc\_postfilters
   ...
2. We can then select a distribution to view:

   % stacks-dist-extract ./stacks/population\_r80/populations.log.distribs samples\_per\_loc\_prefilters
   # Distribution of valid samples matched to a catalog locus prior to filtering.
   n\_samples n\_loci
   1 810
   2 362
   3 224
   4 213
   5 202
   6 175
   7 224
   8 542
   9 46792
   10 49961
3. Here is another example from the gstacks distribs file:

   % stacks-dist-extract ./stacks/gstacks.log.distribs
   bam\_stats\_per\_sample
   effective\_coverages\_per\_sample
   phasing\_rates\_per\_sample
4. If we type enough of a section heading to make it unique, the script will print the results:

   % stacks-dist-extract ./stacks/gstacks.log.distribs bam\_stats
   sample records primary\_kept kept\_frac primary\_kept\_read2 primary\_disc\_mapq primary\_disc\_sclip unmapped secondary supplementary
   S1\_2023.01 2780637 2515438 0.905 1195103 26801 98337 80108 0 59953
   S1\_2023.07 3156646 2860191 0.906 1359700 27987 110763 89513 0 68192
   S2\_1999.13 2835542 2574684 0.908 1225169 25379 96962 81343 0 57174
   ...
5. If we add the --pretty flag, it will line up the columns (but remove the tabs, so not useful for plotting e.g., in R):

   % stacks-dist-extract ./stacks/gstacks.log.distribs --pretty bam\_stats
   sample records primary\_kept kept\_frac primary\_kept\_read2 primary\_disc\_mapq primary\_disc\_sclip unmapped secondary supplementary
   S1\_2023.01 2780637 2515438 0.905 1195103 26801 98337 80108 0 59953
   S1\_2023.07 3156646 2860191 0.906 1359700 27987 110763 89513 0 68192
   S2\_1999.13 2835542 2574684 0.908 1225169 25379 96962 81343 0 57174
   ...
6. Lastly, we can use the program in a UNIX pipeline, but then we need to specify the --section option:

   % cat ./stacks/gstacks.log.distribs | stacks-dist-extract --section bam\_stats\_per\_sample
7. Here is an example of a UNIX pipeline that will compute the average number of records for all samples:

   % cat ./stacks/gstacks.log.distribs | stacks-dist-extract --section bam\_stats\_per\_sample | tail -n +2 | cut -f 2 | awk '{s+=$1} END {print s/NR}'

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