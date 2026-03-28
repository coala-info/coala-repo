[![Stacks](/stacks/images/stacks_logo.png "Stacks")](/stacks)

## gstacks

The gstacks program will examine a RAD data set one locus at a time, looking
at all individuals in the metapopulation for that locus.

For *de novo* analyses, the gstacks program will start with the results
of the core single-end pipeline (ustacks→cstacks→sstacks→tsv2bam), incorporate the paired-end
reads (if available), as fetched by tsv2bam, assemble the paired-end reads into a
contig, merge the contig with the single-end locus, and align reads from individual samples to the locus.

For reference-aligned analyses, the gstacks program is the first program executed
and it will create loci by incorporating single- or paired-end reads that have been aligned to the reference
genome and sorted, using a sliding window algorithm.

In either mode, gstacks will identify SNPs within the meta population for each locus
and then genotype each individual at each identified SNP. Once SNPs have been identified and genotyped,
gstacks will phase the SNPs at each locus, in each individual, into a set of haplotypes.

The gstacks program is able to remove PCR duplicates (pairs of reads with identical insert
lengths) if requested.

The gstacks program will output two major files, catalog.fa.gz,
which contains the consensus sequence for each assembled locus in the data, as well as catalog.calls,
a custom file that contains genotyping data. These files are intended to be read by the populations
program, which can apply appropriate filters and export the data.

## Program Options

### De novo mode:

gstacks -P stacks\_dir -M popmap

* -P — input directory containg '\*.matches.bam' files created by the
  de novo Stacks pipeline, ustacks-cstacks-sstacks-tsv2bam

### Reference-based mode:

gstacks -I bam\_dir -M popmap [-S suffix] -O out\_dir
gstacks -B bam\_file [-B ...] -O out\_dir

* -I — input directory containing BAM files
* -S — with -I/-M, suffix to use to build BAM file names: by default this
  is just '.bam', i.e. the program expects 'SAMPLE\_NAME.bam'
* -B — input BAM file(s)

  The input BAM file(s) must be sorted by coordinate. With -B, records must be assigned to samples using BAM
  "reads groups" (gstacks uses the ID/identifier and SM/sample name fields). Read groups must be consistent if repeated different files.
  With -I, read groups are unneeded and ignored.

### For both modes:

* -M — path to a population map giving the list of samples
* -O — output directory (default: none with -B; with -P same as the input directory)
* -t,--threads — number of threads to use (default: 1)

### SNP Model options:

* --model — model to use to call variants and genotypes; one of
  marukilow (default), marukihigh, or snp
* --var-alpha — alpha threshold for discovering SNPs (default: 0.05 for marukilow)
* --gt-alpha — alpha threshold for calling genotypes (default: 0.05)

### Paired-end options:

* --rm-pcr-duplicates — remove read pairs of the same insert length (implies --rm-unpaired-reads)
* --rm-unpaired-reads — discard unpaired reads
* --ignore-pe-reads — ignore paired-end reads even if present in the input
* --unpaired — ignore read pairing (only for paired-end GBS; treat READ2's as if they were READ1's)

### Advanced options: (De novo mode)

* --kmer-length — kmer length for the de Bruijn graph (default: 31, max. 31)
* --max-debruijn-reads — maximum number of reads to use in the de Bruijn graph (default: 1000)
* --min-kmer-cov — minimum coverage to consider a kmer (default: 2)
* --write-alignments — save read alignments (heavy BAM files)

### Advanced options: (Reference-based mode)

* --min-mapq — minimum PHRED-scaled mapping quality to consider a read (default: 10)
* --max-clipped — maximum soft-clipping level, in fraction of read length (default: 0.20)
* --max-insert-len — maximum allowed sequencing insert length (default: 1000)
* --details — write a heavier output
* --phasing-cooccurrences-thr-range — range of edge coverage thresholds to
  iterate over when building the graph of allele cooccurrences for SNP phasing (default: 1,2)
* --phasing-dont-prune-hets — don't try to ignore dubious heterozygote
  genotypes during phasing

## Example Usage

1. Processing single-end or paired-end data, *de novo*.

   Your Stacks directory should look similar to this, where the tags/snps/alleles/matches files were produced by the core pipeline (ustacks/cstacks/sstacks) and the matches.bam files were produced by tsv2bam:

   % ls stacks/
   sample\_1020.alleles.tsv.gz sample\_1069.alleles.tsv.gz sample\_1086.alleles.tsv.gz sample\_1095.alleles.tsv.gz
   sample\_1020.matches.tsv.gz sample\_1069.matches.tsv.gz sample\_1086.matches.tsv.gz sample\_1095.matches.tsv.gz
   sample\_1020.matches.bam sample\_1069.matches.bam sample\_1086.matches.bam sample\_1095.matches.bam
   sample\_1020.snps.tsv.gz sample\_1069.snps.tsv.gz sample\_1086.snps.tsv.gz sample\_1095.snps.tsv.gz
   sample\_1020.tags.tsv.gz sample\_1069.tags.tsv.gz sample\_1086.tags.tsv.gz sample\_1095.tags.tsv.gz

   % gstacks -P ./stacks -M ./popmap -t 8
2. Processing single or paired-end data, *reference aligned*.

   Your Stacks direcotry should look similar to this, where sample reads have been **aligned and sorted** by a standard aligner, such as bwa:

   % ls aligned/
   sample\_1020.bam sample\_1069.bam sample\_1086.bam sample\_1095.bam

   % gstacks -I ./aligned -O ./stacks -M ./popmap -t 8
3. Given paired-end, single-digest data that is *reference aligned*, perhaps you want to exclude PCR duplicates.

   % gstacks -I ./aligned -O ./stacks -M ./popmap --rm-pcr-duplicates -t 8

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