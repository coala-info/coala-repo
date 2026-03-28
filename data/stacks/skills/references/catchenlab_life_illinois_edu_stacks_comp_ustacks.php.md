[![Stacks](/stacks/images/stacks_logo.png "Stacks")](/stacks)

## ustacks

The unique stacks program will take as input a set of short-read sequences and align them into exactly-matching stacks (or putative alleles).
Comparing the stacks it will form a set of putative loci and detect SNPs at each locus using a maximum likelihood
framework[1](#footnote).

1Hohenlohe PA, Bassham S, Etter PD, Stiffler N, Johnson EA, Cresko WA. 2010. *Population genomics of parallel
adaptation in threespine stickleback using sequenced RAD tags.* **PLoS Genetics**,
[6(2):e1000862](http://dx.doi.org/doi%3A10.1371/journal.pgen.1000862).

## Program Options

ustacks -f in\_path -o out\_path [-M max\_dist] [-m min\_readds] [-t num\_threads]

* -f,--file — input file path.
* -o,--out-path — output path to write results.
* -M — Maximum distance (in nucleotides) allowed between stacks (default 2).
* -m — Minimum number of reads to seed a stack (default 3).
* -N — Maximum distance allowed to align secondary reads to primary stacks (default: M + 2).
* -t,--threads — enable parallel execution with num\_threads threads.
* -i,--in-type — input file type. Supported types: fasta, fastq, gzfasta, or gzfastq (default: guess).
* -n,--name — a name for the sample (default: input file name minus the suffix).
* -R — retain unused reads.
* -H — disable calling haplotypes from secondary reads.

### Stack assembly options:

* --force-diff-len — allow raw input reads of different lengths, e.g. after trimming (default: ustacks perfers raw input reads of uniform length).
* --keep-high-cov — disable the algorithm that removes highly-repetitive stacks and nearby errors.
* --high-cov-thres — highly-repetitive stacks threshold, in standard deviation units (default: 3.0).
* --max-locus-stacks  — maximum number of stacks at a single de novo locus (default 3).
* --k-len [len] — specify k-mer size for matching between alleles and loci (automatically calculated by default).
* --deleverage — enable the Deleveraging algorithm, used for resolving over merged tags.

### Gapped assembly options:

* --max-gaps — number of gaps allowed between stacks before merging (default: 2).
* --min-aln-len — minimum length of aligned sequence in a gapped alignment (default: 0.80).
* --disable-gapped — do not preform gapped alignments between stacks (default: gapped alignements enabled).

### Model Options

* --model-type — either 'snp' (default), 'bounded', or 'fixed'

#### For the SNP or Bounded SNP model:

* --alpha [num] — chi square significance level required to call a heterozygote or homozygote, either 0.1, 0.05 (default), 0.01, or 0.001.

#### For the Bounded SNP model:

* --bound-low [num] — lower bound for epsilon, the error rate, between 0 and 1.0 (default 0).
* --bound-high [num] — upper bound for epsilon, the error rate, between 0 and 1.0 (default 1).

#### For the Fixed model:

* --bc-err-freq [num] — specify the barcode error frequency, between 0 and 1.0.

## Example Usage

1. Here we run ustacks independently on four samples from a genetic cross, two parents and two
   progeny. We specify the parameters for creating putative alleles
   (-m) and merging alleles into putative
   loci (-M). We speed up the matching process by specifying 16 parallel threads.

   % ustacks -f ./samples/f0\_male.fq.gz -o ./stacks -m 3 -M 4 -t 16
   % ustacks -f ./samples/f0\_female.fq.gz -o ./stacks -m 3 -M 4 -t 16
   % ustacks -f ./samples/progeny\_01.fq.gz -o ./stacks -m 3 -M 4 -t 16
   % ustacks -f ./samples/progeny\_02.fq.gz -o ./stacks -m 3 -M 4 -t 16
2. Here we run ustacks against three samples from a population. Gapped alignments
   will be made between alleles when forming putative loci, by default.

   % ustacks -f ./samples/sample\_39-1.fq.gz -o ./stacks -M 6 -t 8
   % ustacks -f ./samples/sample\_40-2.fq.gz -o ./stacks -M 6 -t 8
   % ustacks -f ./samples/sample\_41-1.fq.gz -o ./stacks -M 6 -t 8

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