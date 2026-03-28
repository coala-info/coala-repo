[![Stacks](/stacks/images/stacks_logo.png "Stacks")](/stacks)

## clone\_filter

The clone\_filter program is designed to identify PCR clones. This can be done in two
different ways. In the simplest case, if you have a set of RAD data that is paired-end and is randomly sheared
(single-digest RAD or similar), you can identify clones by comparing the single and paired-end reads to find identical
sequence. More than one set of identically matching single and paired-end reads will be considered a clone and only
one representative of that set will be output. This method will likely overestimate the number of actual clones in a
data set.

A second method to identify PCR clones is to include a short random sequence (an 'oligo') with each molecule during
molecular library construction. After sequencing we can then compare oligo sequences and identify PCR clones as those
sequences with identical oligos. An oligo sequnce can be part of on inline barcode ligated onto each molecule (the
program assumes the oligo is at the most 5' end of the read, while an inline barcode will come after the oligo in
the sequenced read). An oligo sequence can also be added as either the i5 or the i7 index barcode of the Illumina
TruSeq kits. The clone\_filter program can work with any combination of these types of data
and will reduce each set of identical oligos to a single representative in the output.

The clone\_filter program is designed to work with the process\_radtags
or process\_shortreads programs. Depending on how unique your oligos are (they might be unique
to an entire library or only unique to a single individual) you can first demultiplex your data and then run
clone\_filter or vice-versa.

The clone\_filter program can also be run multiple times with different subsets of the data.
This allows you to filter for clones in increments if necessary due to a lack of memory on your computer.

## Program Options

clone\_filter [-f in\_file | -p in\_dir [-P] [-I] | -1 pair\_1 -2 pair\_2] -o out\_dir [-i type] [-y type] [-D] [-h]

* f — path to the input file if processing single-end sequences.
* p — path to a directory of files.
* P — files contained within directory specified by '-p' are paired.
* 1 — first input file in a set of paired-end sequences.
* 2 — second input file in a set of paired-end sequences.
* i — input file type, either 'bustard' for the Illumina BUSTARD output files, 'fastq', 'fasta', 'gzfasta', or 'gzfastq' (default 'fastq').
* o — path to output the processed files.
* y — output type, either 'fastq', 'gzfastq', 'fasta' or 'gzfasta' (default is same as input type).
* D — capture discarded reads to a file.
* h — display this help messsage.
* --oligo\_len\_1 len — length of the single-end oligo sequence in data set.
* --oligo\_len\_2 len — length of the paired-end oligo sequence in data set.
* --retain\_oligo — do not trim off the random oligo sequence (if oligo is inline).

### Oligo sequence options:

* --inline\_null — random oligo is inline with sequence, occurs only on single-end read (default).
* --null\_index — random oligo is provded in FASTQ header (Illumina i7 read if both i5 and i7 read are provided).
* --index\_null — random oligo is provded in FASTQ header (Illumina i5 or i7 read).
* --inline\_inline — random oligo is inline with sequence, occurs on single and paired-end read.
* --index\_index — random oligo is provded in FASTQ header (Illumina i5 and i7 read).
* --inline\_index — random oligo is inline with sequence on single-end read and second oligo occurs in FASTQ header.
* --index\_inline — random oligo occurs in FASTQ header (Illumina i5 or i7 read) and is inline with sequence on single-end read (if single read data) or paired-end read (if paired data).

## Example Usage

1. Here we run one set of paired-end files through clone\_filter. It will identify clones soley based on matching sequence of single and paired-end reads.

   % clone\_filter -1 ./Sample\_ATTACTCG-ATAGAGGC.R1.fastq.gz -2 ./Sample\_ATTACTCG-ATAGAGGC.R2.fastq.gz -i gzfastq -o ./filtered/
2. Here we can run a pair of files that have a 6bp inline oligo on both the single and paired-end read.

   % clone\_filter -1 ./Sample\_1.R1.fastq.gz -2 ./Sample\_1.R2.fastq.gz -i gzfastq -o ./filtered/ --inline\_inline --oligo\_len\_1 6 --oligo\_len\_2 6
3. Here we can run a set of paired reads (all of them are in the raw subdirectory and are named with the default Illumina scheme) that have a random oligo in the index barcode position.

   % clone\_filter -P -p ./raw/ -i gzfastq -o ./filtered/ --index\_null --oligo\_len\_1 8
4. In this case, their is a set of paired reads (all of them are in the raw subdirectory and are named with the default Illumina scheme) that
   have a barcode in the first index position and a random oligo in the second index barcode position. In this case, the barcode will be output
   by Illumina's software in the FASTQ header as "AAAAAAAA+BBBBBBBB". We instruct clone\_filter
   to ignore the barcode (AAAAAAAA) and use the random oligo (BBBBBB) to identify clones.

   % clone\_filter -P -p ./raw/ -i gzfastq -o ./filtered/ --null\_index --oligo\_len\_2 8

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