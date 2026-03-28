[![Stacks](/stacks/images/stacks_logo.png "Stacks")](/stacks)

## stacks-integrate-alignments

The stacks-integrate-alignments script will take loci produced by the *de novo* pipeline,
along with a set of alignments of those loci against a reference genome, and inject the alignment coordinates back into the
*de novo*-produced data. The program will extract the coordinates of the RAD loci from the given BAM file into a
'locus\_coordinates.tsv' table, and it then rewrites the 'catalog.fa.gz'
and 'catalog.calls' files so that they include the genomic coordinates given in
the input BAM file.

These data can be aligned to any reference genome the user is interested in. This may include a closely-realted genome, such as
from the organism itself, to a more distantly related genome. Of course, the more distantly related the genome, the fewer
loci that will be successfully aligned. The user can also filter alignments to exclude poorly mapped loci using several options
including, minimum mapping quality (provided by the alignment program and stored in the BAM file containing the alignments),
minimum alignment coverage and minimum percent identity, both of which are calculated from the CIGAR strings in the supplied
alignments.

Once this integration is complete, we can run the populations program to export, for example,
smoothed FST statistics along the reference genome.

## Program Options

stacks-integrate-alignments --in-path path --bam-path path --out-path path [-q min] [-a min] [-p min]

* -P, --in-path path — Path to a directory containing Stacks ouput files.
* -B, --bam-path path — Path to a SAM or BAM file containing alignment of de novo catalog loci to a reference genome.
* -O, --out-path path — Path to write the integrated ouput files.
* -q, --min\_mapq min — Minimum mapping quality as listed in the BAM file (default 20).
* -a, --min\_alncov min — Minimum fraction of the de novo catalog locus that must participate in the alignment (default 0.6).
* -p, --min\_pctid min — Minimum BLAST-style percent identity of the largest alignment fragment for a de novo catalog locus (default 0.6).
* --verbose — Provide verbose output.

## Example Usage

1. We start with the output from the de novo pipeline, most easily produced by denovo\_map.pl. Using the set of
   consensus seqeunces that make up the catalog, contained in the 'catalog.fa.gz' file, we will align those
   sequences against our reference genome of interest and convert the output to BAM:

   % bwa mem /path/to/reference/gaculeatus ./stacks\_output/catalog.fa.gz | samtools view -h -b > ./stacks\_output/integrate\_alns/catalog.gacu.bam

   We next feed these alignments, along with the directory containing the Stacks *de novo* files and a separate output directory
   to stacks-integrate-alignments:

   % stacks-integrate-alignments --in-path ./stacks\_output --bam-path ./stacks\_output/integrate\_alns/catalog.gacu.bam --out-path ./stacks/integrate\_alns/

   Finally, we could run populations to generate smoothed statistics along the chromosomes of our integrated reference genome:

   % populations --in-path ./stacks/integrate\_alns --ordered-export --fstats --smooth -r 0.8

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