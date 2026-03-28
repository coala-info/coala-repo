[![Stacks](/stacks/images/stacks_logo.png "Stacks")](/stacks)

## Pipeline Core

* ustacks - The unique stacks program will take as input a set of
  short-read sequences and align them into exactly-matching stacks. Comparing the stacks it will
  form a set of loci and detect SNPs at each locus using a maximum likelihood.
  [[details](./comp/ustacks.php)]
* cstacks - A catalog can be built from any set of samples processed
  by the ustacks program. It will create a set of consensus loci, merging alleles together. In the case
  of a genetic cross, a catalog would be constructed from the parents of the cross to create a set of
  all possible alleles expected in the progeny of the cross.
  [[details](./comp/cstacks.php)]
* sstacks - Sets of stacks constructed by the ustacks program can be
  searched against a catalog produced by the cstacks program. In the case of a genetic map, stacks
  from the progeny would be matched against the catalog to determine which progeny contain which
  parental alleles.
  [[details](./comp/sstacks.php)]
* gstacks - For *de novo* analyses, this program will pull in paired-end
  reads, if available, assemble the paired-end contig and merge it with the single-end locus, align reads
  to the locus, and call SNPs. For reference-aligned analyses, this program will build loci from the
  single and paired-end reads that have been aligned and sorted.
  [[details](./comp/gstacks.php)]
* populations - This program will be executed in place of the exisiting genotypes
  program when a population is being processed through the pipeline. The populations program will output site level SNP calls (in VCF format)
  and will compute summary statistics such as Pi, Fis, and Fst.
  [[details](./comp/populations.php)]

## Raw Reads

* process\_radtags - examines raw reads from an Illumina sequencing run and first,
  checks that the barcode and the RAD cutsite are intact (correcting minor errors). Second, it slides a window down
  the length of the read and checks the average quality score within the window. If the score drops below 90%
  probability of being correct, the read is discarded.
  [[details](./comp/process_radtags.php)]
* process\_shortreads - performs the same task as process\_radtags for fast cleaning of randomly
  sheared genomic or transcriptomic data.
  [[details](./comp/process_shortreads.php)]
* clone\_filter - take a set of paired-end reads and reduce them according to PCR clones
  (a PCR clone is a pair of reads that match exactly, while paried-end reads from two different DNA molecules will nearly
  always be slightly different lengths).
  [[details](./comp/clone_filter.php)]
* kmer\_filter - allows paired or single-end reads to be filtered according to the number or
  rare or abundant kmers they contain. Useful for both RAD datasets as well as randomly sheared genomic or transcriptomic data.
  [[details](./comp/kmer_filter.php)]

## Pipeline Execution

* denovo\_map.pl - executes each of the stacks components to create a genetic linkage map, or
  to identify the alleles in a free-standing population. It also handles uploading data to the database.
  [[details](./comp/denovo_map.php)]
* ref\_map.pl - takes reference-aligned input data and executes each of the stacks components,
  using the reference alignment to form stacks, and identifies alleles. Can be used in a genetic map of a free-standing
  population. It also handles uploading data to the database.
  [[details](./comp/ref_map.php)]

## Utility Programs

* stacks-dist-extract - pull data distributions from the log and distribs files produced
  by the Stacks component programs.
  [[details](./comp/stacks_dist_extract.php)]
* stacks-integrate-alignments - take loci produced by the *de novo* pipeline, align them
  against a reference genome, and inject the alignment coordinates back into the *de novo*-produced data.
  [[details](./comp/stacks_integrate_alignments.php)]* stacks-private-alleles - extract private allele data from the populations program outputs
    and output useful summaries and prepare it for plotting.
    [[details](./comp/stacks_private_alleles.php)]