[![Stacks](/stacks/images/stacks_logo.png "Stacks")](/stacks)

## process\_shortreads

Performs the same task as [process\_radtags](./process_radtags.php) for fast cleaning of randomly sheared genomic or transcriptomic data, not for RAD data.

## Program Options

process\_shortreads [-f in\_file | -p in\_dir [-P] | -1 pair\_1 -2 pair\_2] -b barcode\_file -o out\_dir
[-i type] [-y type] [-c] [-q] [-r] [-E encoding] [-t len] [-D] [-w size] [-s lim] [-h]

* f — path to the input file if processing single-end seqeunces.
* i — input file type, either 'bustard' for the Illumina BUSTARD format, 'bam', 'fastq' (default), or 'gzfastq' for gzipped FASTQ.
* y — output type, either 'fastq', 'gzfastq', 'fasta', or 'gzfasta' (default is to match the input file type).
* p — path to a directory of single-end Illumina files.
* P — specify that input is paired (for use with '-p').
* I — specify that the paired-end reads are interleaved in single files.
* 1 — first input file in a set of paired-end sequences.
* 2 — second input file in a set of paired-end sequences.
* o — path to output the processed files.
* b — a list of barcodes for this run.
* c — clean data, remove any read with an uncalled base.
* q — discard reads with low quality scores.
* r — rescue barcodes.
* t — truncate final read length to this value.
* E — specify how quality scores are encoded, 'phred33' (Illumina 1.8+, Sanger) or 'phred64' (Illumina 1.3 - 1.5, default).
* D — capture discarded reads to a file.
* w — set the size of the sliding window as a fraction of the read length, between 0 and 1 (default 0.15).
* s — set the score limit. If the average score within the sliding window drops below this value, the read is discarded (default 10).
* h — display this help message.

### Barcode options:

* --inline\_null: barcode is inline with sequence, occurs only on single-end read (default).
* --index\_null: barcode is provded in FASTQ header, occurs only on single-end read.
* --inline\_inline: barcode is inline with sequence, occurs on single and paired-end read.
* --index\_index: barcode is provded in FASTQ header, occurs on single and paired-end read.
* --inline\_index: barcode is inline with sequence on single-end read, occurs in FASTQ header for paired-end read.
* --index\_inline: barcode occurs in FASTQ header for single-end read, is inline with sequence on paired-end read.

### Adapter options:

* --adapter\_1 [sequence]: provide adaptor sequence that may occur on the first read for filtering.
* --adapter\_2 [sequence]: provide adaptor sequence that may occur on the paired-read for filtering.
* --adapter\_mm [mismatches]: number of mismatches allowed in the adapter sequence.

### Output options:

* --merge: if no barcodes are specified, merge all input files into a single output file (or single pair of files).

### Advanced options:

* --no\_read\_trimming: do not trim low quality reads, just discard them.
* --len\_limit [limit]: when trimming sequences, specify the minimum length a sequence must be to keep it (default 31bp).
* --filter\_illumina: discard reads that have been marked by Illumina's chastity/purity filter as failing.
* --barcode\_dist: provide the distace between barcodes to allow for barcode rescue (default 2)
* --mate-pair: raw reads are circularized mate-pair data, first read will be reverse complemented.
* --no\_overhang: data does not contain an overhang nucleotide between barcode and seqeunce.

## Example Usage

If your data are **paired-end, Illumina HiSeq data**, in a directory called raw:

~/raw% ls
lane4\_NoIndex\_L004\_R1\_001.fastq lane4\_NoIndex\_L004\_R1\_009.fastq lane4\_NoIndex\_L004\_R2\_005.fastq
lane4\_NoIndex\_L004\_R1\_002.fastq lane4\_NoIndex\_L004\_R1\_010.fastq lane4\_NoIndex\_L004\_R2\_006.fastq
lane4\_NoIndex\_L004\_R1\_003.fastq lane4\_NoIndex\_L004\_R1\_011.fastq lane4\_NoIndex\_L004\_R2\_007.fastq
lane4\_NoIndex\_L004\_R1\_004.fastq lane4\_NoIndex\_L004\_R1\_012.fastq lane4\_NoIndex\_L004\_R2\_008.fastq
lane4\_NoIndex\_L004\_R1\_005.fastq lane4\_NoIndex\_L004\_R2\_001.fastq lane4\_NoIndex\_L004\_R2\_009.fastq
lane4\_NoIndex\_L004\_R1\_006.fastq lane4\_NoIndex\_L004\_R2\_002.fastq lane4\_NoIndex\_L004\_R2\_010.fastq
lane4\_NoIndex\_L004\_R1\_007.fastq lane4\_NoIndex\_L004\_R2\_003.fastq lane4\_NoIndex\_L004\_R2\_011.fastq
lane4\_NoIndex\_L004\_R1\_008.fastq lane4\_NoIndex\_L004\_R2\_004.fastq lane4\_NoIndex\_L004\_R2\_012.fastq

Then you run process\_shortreads like this:

% process\_shortreads -P -p ./raw/ -o ./samples/ -b ./barcodes/barcodes\_lane4 -r -c -q

See more examples in the [process\_radtags manual page](%24root_path/comp/process_radtags.php).

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