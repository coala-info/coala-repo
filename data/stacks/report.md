# stacks CWL Generation Report

## stacks_process_radtags

### Tool Description
Process RAD-seq data to demultiplex, clean, and filter reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/stacks:2.68--h077b44d_3
- **Homepage**: https://catchenlab.life.illinois.edu/stacks/
- **Package**: https://anaconda.org/channels/bioconda/packages/stacks/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/stacks/overview
- **Total Downloads**: 314.4K
- **Last updated**: 2025-09-30
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
You must specify an input file of a directory path to a set of input files.
process_radtags 2.68
process_radtags -p in_dir [-P] [-b barcode_file] -o out_dir -e enz [--threads num] [-c] [-q] [-r] [-t len]
process_radtags -f in_file [-b barcode_file] -o out_dir -e enz [--threads num] [-c] [-q] [-r] [-t len]
process_radtags --in-path in_dir [--paired] [--barcodes barcode_file] --out-path out_dir --renz-1 enz [--renz-2 enz] [--threads num] [-c] [-q] [-r] [-t len]
process_radtags -1 pair_1 -2 pair_2 [-b barcode_file] -o out_dir -e enz [--threads num] [-c] [-q] [-r] [-t len]

  -p,--in-path: path to a directory of files.
  -P,--paired: files contained within the directory are paired.
  -I,--interleaved: specify that the paired-end reads are interleaved in single files.
  -b,--barcodes: path to a file containing barcodes for this run, omit to ignore any barcoding or for already demultiplexed data.
  -f: path to the input file if processing single-end sequences.
  -1: first input file in a set of paired-end sequences.
  -2: second input file in a set of paired-end sequences.
  -o,--out-path: path to output the processed files.
    --basename: specify the prefix of the output files when using -f or -1/-2.

  --threads: number of threads to run.
  -c,--clean: clean data, remove any read with an uncalled base ('N').
  -q,--quality: discard reads with low quality (phred) scores.
  -r,--rescue: rescue barcodes and RAD-Tag cut sites.
  -t,--truncate: truncate final read length to this value.
  -D,--discards: capture discarded reads to a file.

  Barcode options:
    --inline-null:   barcode is inline with sequence, occurs only on single-end read (default).
    --index-null:    barcode is provded in FASTQ header (Illumina i5 or i7 read).
    --null-index:    barcode is provded in FASTQ header (Illumina i7 read if both i5 and i7 read are provided).
    --inline-inline: barcode is inline with sequence, occurs on single and paired-end read.
    --index-index:   barcode is provded in FASTQ header (Illumina i5 and i7 reads).
    --inline-index:  barcode is inline with sequence on single-end read and occurs in FASTQ header (from either i5 or i7 read).
    --index-inline:  barcode occurs in FASTQ header (Illumina i5 or i7 read) and is inline with single-end sequence (for single-end data) on paired-end read (for paired-end data).

  Restriction enzyme options:
    -e [enz], --renz-1 [enz]: provide the restriction enzyme used (cut site occurs on single-end read)
    --renz-2 [enz]: if a double digest was used, provide the second restriction enzyme used (cut site occurs on the paired-end read).
    Currently supported enzymes include:
      'aciI', 'aclI', 'ageI', 'aluI', 'apaLI', 'apeKI', 'apoI', 'aseI', 
      'bamHI', 'bbvCI', 'bfaI', 'bfuCI', 'bgIII', 'bsaHI', 'bspDI', 'bstYI', 
      'btgI', 'cac8I', 'claI', 'csp6I', 'ddeI', 'dpnII', 'eaeI', 'ecoRI', 
      'ecoRV', 'ecoT22I', 'haeII', 'haeIII', 'hhaI', 'hinP1I', 'hindIII', 'hpaII', 
      'hpyCH4IV', 'kpnI', 'mluCI', 'mseI', 'mslI', 'mspI', 'ncoI', 'ndeI', 
      'ngoMIV', 'nheI', 'nlaIII', 'notI', 'nsiI', 'nspI', 'pacI', 'pspXI', 
      'pstI', 'pstIshi', 'rsaI', 'sacI', 'sau3AI', 'sbfI', 'sexAI', 'sgrAI', 
      'speI', 'sphI', 'taqI', 'xbaI', or 'xhoI'

  Protocol-specific options:
    --bestrad: library was generated using BestRAD, check for restriction enzyme on either read and potentially tranpose reads.
    --methylrad: library was generated using enzymatic methyl-seq (EM-seq) or bisulphite sequencing.

  Adapter options:
    --adapter-1 <sequence>: provide adaptor sequence that may occur on the single-end read for filtering.
    --adapter-2 <sequence>: provide adaptor sequence that may occur on the paired-read for filtering.
      --adapter-mm <mismatches>: number of mismatches allowed in the adapter sequence.

  Input/Output options:
    --in-type: input file type, either 'fastq', 'gzfastq' (gzipped fastq), 'bam', or 'bustard' (default: guess, or gzfastq if unable to).
    --out-type: output type, either 'fastq', 'gzfastq', 'fasta', or 'gzfasta' (default: match input type).
    --retain-header: retain unmodified FASTQ headers in the output.
    --merge: if no barcodes are specified, merge all input files into a single output file.

  Advanced options:
    --filter-illumina: discard reads that have been marked by Illumina's chastity/purity filter as failing.
    --disable-rad-check: disable checking if the RAD cut site is intact.
    --force-poly-g-check: force a check for runs of poly-Gs (default: autodetect based on machine type in FASTQ header).
    --disable-poly-g-check: disable checking for runs of poly-Gs (default: autodetect based on machine type in FASTQ header).
    --encoding: specify how quality scores are encoded, 'phred33' (Illumina 1.8+/Sanger, default) or 'phred64' (Illumina 1.3-1.5).
    --window-size: set the size of the sliding window as a fraction of the read length, between 0 and 1 (default 0.15).
    --score-limit: set the phred score limit. If the average score within the sliding window drops below this value, the read is discarded (default 10).
    --len-limit <limit>: specify a minimum sequence length (useful if your data has already been trimmed).
    --barcode-dist-1: the number of allowed mismatches when rescuing single-end barcodes (default 1).
    --barcode-dist-2: the number of allowed mismatches when rescuing paired-end barcodes (defaults to --barcode-dist-1).
```


## stacks_process_shortreads

### Tool Description
process_shortreads 2.68

### Metadata
- **Docker Image**: quay.io/biocontainers/stacks:2.68--h077b44d_3
- **Homepage**: https://catchenlab.life.illinois.edu/stacks/
- **Package**: https://anaconda.org/channels/bioconda/packages/stacks/overview
- **Validation**: PASS

### Original Help Text
```text
You must specify an input file of a directory path to a set of input files.
process_shortreads 2.68
process_shortreads [-f in_file | -p in_dir [-P] [-I] | -1 pair_1 -2 pair_2] -b barcode_file -o out_dir [-i type] [-y type] [-c] [-q] [-r] [-E encoding] [-t len] [-D] [-w size] [-s lim] [-h]
  f: path to the input file if processing single-end seqeunces.
  i: input file type, either 'bustard' for the Illumina BUSTARD format, 'bam', 'fastq' (default), or 'gzfastq' for gzipped FASTQ.
  p: path to a directory of single-end Illumina files.
  1: first input file in a set of paired-end sequences.
  2: second input file in a set of paired-end sequences.
  P: specify that input is paired (for use with '-p').
  I: specify that the paired-end reads are interleaved in single files.
  o: path to output the processed files.
  y: output type, either 'fastq' or 'fasta' (default gzfastq).
  b: a list of barcodes for this run.
  c: clean data, remove any read with an uncalled base.
  q: discard reads with low quality scores.
  r: rescue barcodes.
  t: truncate final read length to this value.
  E: specify how quality scores are encoded, 'phred33' (Illumina 1.8+/Sanger, default) or 'phred64' (Illumina 1.3-1.5).
  D: capture discarded reads to a file.
  w: set the size of the sliding window as a fraction of the read length, between 0 and 1 (default 0.15).
  s: set the score limit. If the average score within the sliding window drops below this value, the read is discarded (default 10).
  h: display this help messsage.

  Barcode options:
    --inline-null:   barcode is inline with sequence, occurs only on single-end read (default).
    --index-null:    barcode is provded in FASTQ header (Illumina i5 or i7 read).
    --null-index:    barcode is provded in FASTQ header (Illumina i7 read if both i5 and i7 read are provided).
    --inline-inline: barcode is inline with sequence, occurs on single and paired-end read.
    --index-index:   barcode is provded in FASTQ header (Illumina i5 and i7 reads).
    --inline-index:  barcode is inline with sequence on single-end read and occurs in FASTQ header (from either i5 or i7 read).
    --index-inline:  barcode occurs in FASTQ header (Illumina i5 or i7 read) and is inline with single-end sequence (for single-end data) on paired-end read (for paired-end data).

  Adapter options:
    --adapter-1 <sequence>: provide adaptor sequence that may occur on the first read for filtering.
    --adapter-2 <sequence>: provide adaptor sequence that may occur on the paired-read for filtering.
      --adapter-mm <mismatches>: number of mismatches allowed in the adapter sequence.

  Output options:
    --retain-header: retain unmodified FASTQ headers in the output.
    --merge: if no barcodes are specified, merge all input files into a single output file (or single pair of files).

  Advanced options:
    --no-read-trimming: do not trim low quality reads, just discard them.
    --len-limit <limit>: when trimming sequences, specify the minimum length a sequence must be to keep it (default 31bp).
    --filter-illumina: discard reads that have been marked by Illumina's chastity/purity filter as failing.
    --barcode-dist: provide the distace between barcodes to allow for barcode rescue (default 2)
    --mate-pair: raw reads are circularized mate-pair data, first read will be reverse complemented.
    --no-overhang: data does not contain an overhang nucleotide between barcode and seqeunce.
```


## stacks_clone_filter

### Tool Description
You must specify an input file of a directory path to a set of input files.

### Metadata
- **Docker Image**: quay.io/biocontainers/stacks:2.68--h077b44d_3
- **Homepage**: https://catchenlab.life.illinois.edu/stacks/
- **Package**: https://anaconda.org/channels/bioconda/packages/stacks/overview
- **Validation**: PASS

### Original Help Text
```text
You must specify an input file of a directory path to a set of input files.
clone_filter 2.68
clone_filter [-f in_file | -p in_dir [-P] [-I] | -1 pair_1 -2 pair_2] -o out_dir [-i type] [-y type] [-D] [-h]
  f: path to the input file if processing single-end sequences.
  p: path to a directory of files.
  P: files contained within directory specified by '-p' are paired.
  1: first input file in a set of paired-end sequences.
  2: second input file in a set of paired-end sequences.
  i: input file type, either 'bustard', 'fastq', 'fasta', 'gzfasta', or 'gzfastq' (default 'fastq').
  o: path to output the processed files.
  y: output type, either 'fastq', 'fasta', 'gzfasta', or 'gzfastq' (default same as input type).
  D: capture discarded reads to a file.
  h: display this help messsage.
  --oligo-len-1 len: length of the single-end oligo sequence in data set.
  --oligo-len-2 len: length of the paired-end oligo sequence in data set.
  --retain-oligo: do not trim off the random oligo sequence (if oligo is inline).

  Oligo sequence options:
    --inline-null:   random oligo is inline with sequence, occurs only on single-end read (default).
    --null-inline:   random oligo is inline with sequence, occurs only on the paired-end read.
    --null-index:    random oligo is provded in FASTQ header (Illumina i7 read if both i5 and i7 read are provided).
    --index-null:    random oligo is provded in FASTQ header (Illumina i5 or i7 read).
    --inline-inline: random oligo is inline with sequence, occurs on single and paired-end read.
    --index-index:   random oligo is provded in FASTQ header (Illumina i5 and i7 read).
    --inline-index:  random oligo is inline with sequence on single-end read and second oligo occurs in FASTQ header.
    --index-inline:  random oligo occurs in FASTQ header (Illumina i5 or i7 read) and is inline with sequence on single-end read (if single read data) or paired-end read (if paired data).
```


## stacks_ustacks

### Tool Description
ustacks -f in_path -o out_path [-M max_dist] [-m min_reads] [-t num_threads]

### Metadata
- **Docker Image**: quay.io/biocontainers/stacks:2.68--h077b44d_3
- **Homepage**: https://catchenlab.life.illinois.edu/stacks/
- **Package**: https://anaconda.org/channels/bioconda/packages/stacks/overview
- **Validation**: PASS

### Original Help Text
```text
ustacks: option '--h' is ambiguous; possibilities: '--help' '--high-cov-thres' '--high_cov_thres'
ustacks 2.68
ustacks -f in_path -o out_path [-M max_dist] [-m min_reads] [-t num_threads]
  -f,--file: input file path.
  -o,--out-path: output path to write results.
  -M: Maximum distance (in nucleotides) allowed between stacks (default 2).
  -m: Minimum number of reads to seed a new stack (default 3).
  -N: Maximum distance allowed to align secondary reads to primary stacks (default: M + 2).
  -t,--threads: enable parallel execution with num_threads threads.
  -i,--in-type: input file type. Supported types: fasta, fastq, gzfasta, or gzfastq (default: guess).
  -n,--name: a name for the sample (default: input file name minus the suffix).
  -R: retain unused reads.
  -H: disable calling haplotypes from secondary reads.

  Stack assembly options:
    --force-diff-len: allow raw input reads of different lengths, e.g. after trimming (default: ustacks perfers raw input reads of uniform length).
    --keep-high-cov: disable the algorithm that removes highly-repetitive stacks and nearby errors.
    --high-cov-thres: highly-repetitive stacks threshold, in standard deviation units (default: 3.0).
    --max-locus-stacks <num>: maximum number of stacks at a single de novo locus (default 3).
    --k-len <len>: specify k-mer size for matching between alleles and loci (automatically calculated by default).
    --deleverage: enable the Deleveraging algorithm, used for resolving over merged tags.

  Gapped assembly options:
    --max-gaps: number of gaps allowed between stacks before merging (default: 2).
    --min-aln-len: minimum length of aligned sequence in a gapped alignment (default: 0.80).
    --disable-gapped: do not preform gapped alignments between stacks (default: gapped alignements enabled).

  Model options:
    --model-type: either 'snp' (default), 'bounded', or 'fixed'
    For the SNP or Bounded SNP model:
      --alpha <num>: chi square significance level required to call a heterozygote or homozygote, either 0.1, 0.05 (default), 0.01, or 0.001.
    For the Bounded SNP model:
      --bound-low <num>: lower bound for epsilon, the error rate, between 0 and 1.0 (default 0).
      --bound-high <num>: upper bound for epsilon, the error rate, between 0 and 1.0 (default 1).
    For the Fixed model:
      --bc-err-freq <num>: specify the barcode error frequency, between 0 and 1.0.

  h: display this help messsage.
```


## stacks_cstacks

### Tool Description
Build a catalog of loci from sample data.

### Metadata
- **Docker Image**: quay.io/biocontainers/stacks:2.68--h077b44d_3
- **Homepage**: https://catchenlab.life.illinois.edu/stacks/
- **Package**: https://anaconda.org/channels/bioconda/packages/stacks/overview
- **Validation**: PASS

### Original Help Text
```text
Error: You must specify one of -P or -s.
cstacks 2.68
cstacks -P in_dir -M popmap [-n num_mismatches] [-t num_threads]
cstacks -s sample1_path [-s sample2_path ...] -o path [-n num_mismatches] [-t num_threads]

  -P,--in-path: path to the directory containing Stacks files.
  -M,--popmap: path to a population map file.
  -n: number of mismatches allowed between sample loci when build the catalog (default 1; suggested: set to ustacks -M).
  -t,--threads: enable parallel execution with num_threads threads.
  -s: sample prefix from which to load loci into the catalog.
  -o,--outpath: output path to write results.
  -c,--catalog <path>: add to an existing catalog.

Gapped assembly options:
  --max-gaps: number of gaps allowed between stacks before merging (default: 2).
  --min-aln-len: minimum length of aligned sequence in a gapped alignment (default: 0.80).
  --disable-gapped: disable gapped alignments between stacks (default: use gapped alignments).

Advanced options:
  --k-len <len>: specify k-mer size for matching between between catalog loci (automatically calculated by default).
  --report-mmatches: report query loci that match more than one catalog locus.
```


## stacks_sstacks

### Tool Description
Stacks de novo assembly pipeline

### Metadata
- **Docker Image**: quay.io/biocontainers/stacks:2.68--h077b44d_3
- **Homepage**: https://catchenlab.life.illinois.edu/stacks/
- **Package**: https://anaconda.org/channels/bioconda/packages/stacks/overview
- **Validation**: PASS

### Original Help Text
```text
Error: You must specify one of -P or -c.
sstacks 2.68
sstacks -P dir -M popmap [-t n_threads]
sstacks -c catalog_path -s sample_path [-s sample_path ...] -o path [-t n_threads]
  -P,--in-path: path to the directory containing Stacks files.
  -M,--popmap: path to a population map file from which to take sample names.
  -s,--sample: filename prefix from which to load sample loci.
  -c,--catalog: path to the catalog.
  -t,--threads: enable parallel execution with n_threads threads.
  -o,--out-path: output path to write results.
  -x: don't verify haplotype of matching locus.

Gapped assembly options:
  --disable-gapped: disable gapped alignments between stacks (default: enable gapped alignments).
```


## stacks_tsv2bam

### Tool Description
Converts STACKS tsv files to BAM format.

### Metadata
- **Docker Image**: quay.io/biocontainers/stacks:2.68--h077b44d_3
- **Homepage**: https://catchenlab.life.illinois.edu/stacks/
- **Package**: https://anaconda.org/channels/bioconda/packages/stacks/overview
- **Validation**: PASS

### Original Help Text
```text
Error: An input directory is required (-P).
tsv2bam 2.68
tsv2bam -P stacks_dir -M popmap [-R paired_reads_dir]
tsv2bam -P stacks_dir -s sample [-s sample ...] [-R paired_reads_dir]

  -P,--in-dir: input directory.
  -M,--popmap: population map.
  -s,--sample: name of one sample.
  -R,--pe-reads-dir: directory where to find the paired-end reads files (in fastq/fasta/bam (gz) format).
  -t: number of threads to use (default: 1).
```


## stacks_gstacks

### Tool Description
De novo and reference-based mode for variant calling.

### Metadata
- **Docker Image**: quay.io/biocontainers/stacks:2.68--h077b44d_3
- **Homepage**: https://catchenlab.life.illinois.edu/stacks/
- **Package**: https://anaconda.org/channels/bioconda/packages/stacks/overview
- **Validation**: PASS

### Original Help Text
```text
Error: Please specify exactly one of -P, -I or -B.
gstacks 2.68

De novo mode:
  gstacks -P stacks_dir -M popmap

  -P: input directory containg '*.matches.bam' files created by the
      de novo Stacks pipeline, ustacks-cstacks-sstacks-tsv2bam

Reference-based mode:
  gstacks -I bam_dir -M popmap [-S suffix] -O out_dir
  gstacks -B bam_file [-B ...] -O out_dir

  -I: input directory containing BAM files
  -S: with -I/-M, suffix to use to build BAM file names: by default this
      is just '.bam', i.e. the program expects 'SAMPLE_NAME.bam'
  -B: input BAM file(s)

  The input BAM file(s) must be sorted by coordinate.
  With -B, records must be assigned to samples using BAM "reads groups"
  (gstacks uses the ID/identifier and SM/sample name fields). Read groups
  must be consistent if repeated different files. Note that with -I, read
  groups are unneeded and ignored.

For both modes:
  -M: path to a population map giving the list of samples
  -O: output directory (default: none with -B; with -P same as the input
      directory)
  -t,--threads: number of threads to use (default: 1)

SNP Model options:
  --model: model to use to call variants and genotypes; one of
           marukilow (default), marukihigh, or snp
  --var-alpha: alpha threshold for discovering SNPs (default: 0.01 for marukilow)
  --gt-alpha: alpha threshold for calling genotypes (default: 0.05)

Paired-end options:
  --rm-pcr-duplicates: remove all but one set ofread pairs of the same sample that 
                       have the same insert length (implies --rm-unpaired-reads)
  --rm-unpaired-reads: discard unpaired reads
  --ignore-pe-reads: ignore paired-end reads even if present in the input
  --unpaired: ignore read pairing (only for paired-end GBS; treat READ2's as if they were READ1's)

Advanced options:
  (De novo mode)
  --kmer-length: kmer length for the de Bruijn graph (default: 31, max. 31)
  --max-debruijn-reads: maximum number of reads to use in the de Bruijn graph (default: 1000)
  --min-kmer-cov: minimum coverage to consider a kmer (default: 2)
  --write-alignments: save read alignments (heavy BAM files)

  (Reference-based mode)
  --methyl-status: assumes a methylation-aware molecular protocol used; calls methylated bases.
  --min-mapq: minimum PHRED-scaled mapping quality to consider a read (default: 10)
  --max-clipped: maximum soft-clipping level, in fraction of read length (default: 0.20)
  --max-insert-len: maximum allowed sequencing insert length (default: 1000)

  --details: write a heavier output
  --phasing-cooccurrences-thr-range: range of edge coverage thresholds to
        iterate over when building the graph of allele cooccurrences for
        SNP phasing (default: 1,2)
  --phasing-dont-prune-hets: don't try to ignore dubious heterozygote
        genotypes during phasing
```


## stacks_populations

### Tool Description
Stacks populations module for population genetics analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/stacks:2.68--h077b44d_3
- **Homepage**: https://catchenlab.life.illinois.edu/stacks/
- **Package**: https://anaconda.org/channels/bioconda/packages/stacks/overview
- **Validation**: PASS

### Original Help Text
```text
populations 2.68
Usage:
populations -P dir [-O dir] [-M popmap] (filters) [--fstats] [-k [--sigma=150000] [--bootstrap [-N 100]]] (output formats)
populations -V vcf -O dir [-M popmap] (filters) [--fstats] [-k [--sigma=150000] [--bootstrap [-N 100]]] (output formats)

  -P,--in-path: path to a directory containing Stacks ouput files.
  -V,--in-vcf: path to a standalone input VCF file.
  -O,--out-path: path to a directory where to write the output files. (Required by -V; otherwise defaults to value of -P.)
  -M,--popmap: path to a population map. (Format is 'SAMPLE1 \t POP1 \n SAMPLE2 ...'.)
  -t,--threads: number of threads to run in parallel sections of code.
  --batch-size [int]: the number of loci to process in a batch (default: 10,000 in de novo mode; in reference mode, one chromosome
                      per batch). Increase to speed analysis, uses more memory, decrease to save memory).

Data Filtering:
  -p,--min-populations [int]: minimum number of populations a locus must be present in to process a locus.
  -r,--min-samples-per-pop [float]: minimum percentage of individuals in a population required to process a locus for that population.
  -R,--min-samples-overall [float]: minimum percentage of individuals across populations required to process a locus.
  -H,--filter-haplotype-wise: apply the above filters haplotype wise
                              (unshared SNPs will be pruned to reduce haplotype-wise missing data).
  --min-maf [float]: specify a minimum minor allele frequency required to process a SNP (0 < min_maf < 0.5; applied to the metapopulation).
  --min-mac [int]: specify a minimum minor allele count required to process a SNP (applied to the metapopulation).
  --max-obs-het [float]: specify a maximum observed heterozygosity required to process a SNP (applied ot the metapopulation).
  --min-gt-depth [int]: specify a minimum number of reads to include a called SNP (otherwise marked as missing data).

  --write-single-snp: restrict data analysis to only the first SNP per locus (implies --no-haps).
  --write-random-snp: restrict data analysis to one random SNP per locus (implies --no-haps).
  -B,--blacklist: path to a file containing Blacklisted markers to be excluded from the export.
  -W,--whitelist: path to a file containing Whitelisted markers to include in the export.

Locus stats:
  --hwe: calculate divergence from Hardy-Weinberg equilibrium for each locus.

Fstats:
  --fstats: enable SNP and haplotype-based F statistics.
  --fst-correction: specify a p-value correction to be applied to Fst values based on a Fisher's exact test. Default: off.
  --p-value-cutoff [float]: maximum p-value to keep an Fst measurement. Default: 0.05.

Kernel-smoothing algorithm:
  -k,--smooth: enable kernel-smoothed Pi, Fis, Fst, Fst', and Phi_st calculations.
  --smooth-fstats: enable kernel-smoothed Fst, Fst', and Phi_st calculations.
  --smooth-popstats: enable kernel-smoothed Pi and Fis calculations.
    (Note: turning on smoothing implies --ordered-export.)
  --sigma [int]: standard deviation of the kernel smoothing weight distribution. Sliding window size is defined as 3 x sigma; (default sigma = 150kbp).
  --bootstrap-archive: archive statistical values for use in bootstrap resampling in a subsequent run, statistics must be enabled to be archived.
  --bootstrap: turn on boostrap resampling for all kernel-smoothed statistics.
  -N,--bootstrap-reps [int]: number of bootstrap resamplings to calculate (default 100).
  --bootstrap-pifis: turn on boostrap resampling for smoothed SNP-based Pi and Fis calculations.
  --bootstrap-fst: turn on boostrap resampling for smoothed Fst calculations based on pairwise population comparison of SNPs.
  --bootstrap-div: turn on boostrap resampling for smoothed haplotype diveristy and gene diversity calculations based on haplotypes.
  --bootstrap-phist: turn on boostrap resampling for smoothed Phi_st calculations based on haplotypes.
  --bootstrap-wl [path]: only bootstrap loci contained in this whitelist.

File output options:
  --ordered-export: if data is reference aligned, exports will be ordered; only a single representative of each overlapping site.
  --fasta-loci: output locus consensus sequences in FASTA format.
  --fasta-samples: output the sequences of the two haplotypes of each (diploid) sample, for each locus, in FASTA format.
  --vcf: output SNPs and haplotypes in Variant Call Format (VCF).
  --vcf-all: output all sites in Variant Call Format (VCF).
  --genepop: output SNPs and haplotypes in GenePop format.
  --structure: output results in Structure format.
  --radpainter: output results in fineRADstructure/RADpainter format.
  --plink: output genotypes in PLINK format.
  --hzar: output genotypes in Hybrid Zone Analysis using R (HZAR) format.
  --phylip: output nucleotides that are fixed-within, and variant among populations in Phylip format for phylogenetic tree construction.
  --phylip-var: include variable sites in the phylip output encoded using IUPAC notation.
  --phylip-var-all: include all sequence as well as variable sites in the phylip output encoded using IUPAC notation.
  --treemix: output SNPs in a format useable for the TreeMix program (Pickrell and Pritchard).
  --gtf: output locus positions in a GTF annotation file.
  --no-hap-exports: omit haplotype outputs.
  --fasta-samples-raw: output all haplotypes observed in each sample, for each locus, in FASTA format.

Genetic map output options (population map must specify a genetic cross):
  --map-type: genetic map type to write. 'CP', 'DH', 'F2', and 'BC1' are the currently supported map types.
  --map-format: mapping program format to write, 'joinmap', 'onemap', and 'rqtl' are currently supported.

Additional options:
  -h,--help: display this help messsage.
  -v,--version: print program version.
  --verbose: turn on additional logging.
  --log-fst-comp: log components of Fst/Phi_st calculations to a file.
```


## Metadata
- **Skill**: generated
