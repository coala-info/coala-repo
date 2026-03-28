[![Stacks](/stacks/images/stacks_logo.png "Stacks")](/stacks)

## cstacks

A catalog can be built from any set of samples processed by the [ustacks](./ustacks.php)
or [pstacks](./pstacks.php) programs. It will create a set of consensus loci, merging
alleles together. In the case of a genetic cross, a catalog would be constructed from the parents of the cross
to create a set of all possible alleles expected in the progeny of the cross.

## Program Options

cstacks -P in\_path -M popmap [-n num\_mismatches] [-p num\_threads]
cstacks -s sample1\_path [-s sample2\_path ...] -o path [-n num\_mismatches] [-p num\_threads]

* -P,--in-path — path to the directory containing Stacks files.
* -M,--popmap — path to a population map file.
* -n — number of mismatches allowed between sample loci when build the catalog (default 1).
* -t,--threads — enable parallel execution with num\_threads threads.
* -s — sample prefix from which to load loci into the catalog.
* -o — output path to write results.
* -c,--catalog [path] — provide the path to an existing catalog. cstacks will add data to this existing catalog.

### Gapped assembly options:

* --max-gaps — number of gaps allowed between stacks before merging (default: 2).
* --min-aln-len — minimum length of aligned sequence in a gapped alignment (default: 0.80).
* --disable-gapped — disable gapped alignments between stacks (default: use gapped alignments).

### Advanced options:

* --k-len [len] — specify k-mer size for matching between between catalog loci (automatically calculated by default).
* --report-mmatches — report query loci that match more than one catalog locus.

## Example Usage

1. Here we specify the output directory to write the catalog, and then each sample we want to add to the catalog (one -s option for each sample). Here we
   are allowing up to four, fixed nucleotide differences between loci that we are trying to incorporate into the catalog and we are using 15 threads to
   speed up the sequence-matching process between loci:

   % cstacks -o ./stacks -s ./stacks/f0\_male -s ./stacks/f0\_female -n 4 -p 15
2. Here we specify the directory containing all our Stacks output files from ustacks, and then provide a population map, which
   contains all of the individual samples we want to add to the catalog within it (see [the manual](/stacks/manual/#popmap) for information on population maps):

   % cstacks -P ./stacks -M ./popmap -n 4 -p 15
3. In this example, we start with a pre-existing catalog to which we want to add additional samples, and we want to allow/incorporate gaps between the sample and catalog loci:

   % cstacks -b 1 -o ./stacks --catalog ./stacks/catalog -s ./stacks/sample\_37 -s ./stacks/sample\_38 -s ./stacks/sample\_39 -n 4 -p 12

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