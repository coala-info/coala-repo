cwlVersion: v1.2
class: CommandLineTool
baseCommand: rsem-calculate-expression
label: rsem_rsem-calculate-expression
doc: "Estimate gene and isoform expression from RNA-Seq data.\n\nTool homepage: https://deweylab.github.io/RSEM/"
inputs:
  - id: input_alignments
    type: File
    doc: SAM/BAM/CRAM formatted input file. If "-" is specified for the 
      filename, the input is instead assumed to come from standard input. RSEM 
      requires all alignments of the same read group together. For paired-end 
      reads, RSEM also requires the two mates of any alignment be adjacent. In 
      addition, RSEM does not allow the SEQ and QUAL fields to be empty. See 
      Description section for how to make input file obey RSEM's requirements.
    inputBinding:
      position: 1
  - id: upstream_read_files
    type:
      type: array
      items: File
    doc: Comma-separated list of files containing single-end reads or upstream 
      reads for paired-end data. By default, these files are assumed to be in 
      FASTQ format. If the --no-qualities option is specified, then FASTA format
      is expected.
    inputBinding:
      position: 2
  - id: downstream_read_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Comma-separated list of files containing downstream reads which are 
      paired with the upstream reads. By default, these files are assumed to be 
      in FASTQ format. If the --no-qualities option is specified, then FASTA 
      format is expected.
    inputBinding:
      position: 3
  - id: reference_name
    type: string
    doc: The name of the reference used. The user must have run 
      'rsem-prepare-reference' with this reference_name before running this 
      program.
    inputBinding:
      position: 4
  - id: sample_name
    type: string
    doc: The name of the sample analyzed. All output files are prefixed by this 
      name (e.g., sample_name.genes.results)
    inputBinding:
      position: 5
  - id: alignments
    type:
      - 'null'
      - boolean
    doc: Input file contains alignments in SAM/BAM/CRAM format. The exact file 
      format will be determined automatically.
    inputBinding:
      position: 106
      prefix: --alignments
  - id: append_names
    type:
      - 'null'
      - boolean
    doc: If gene_name/transcript_name is available, append it to the end of 
      gene_id/transcript_id (separated by '_') in files 
      'sample_name.isoforms.results' and 'sample_name.genes.results'.
    inputBinding:
      position: 106
      prefix: --append-names
  - id: bam
    type:
      - 'null'
      - boolean
    doc: Inputs are alignments in BAM format.
    inputBinding:
      position: 106
      prefix: --bam
  - id: bowtie2
    type:
      - 'null'
      - boolean
    doc: Use Bowtie 2 instead of Bowtie to align reads. Since currently RSEM 
      does not handle indel, local and discordant alignments, the Bowtie2 
      parameters are set in a way to avoid those alignments. In particular, we 
      use options '--sensitive --dpad 0 --gbar 99999999 --mp 1,1 --np 1 
      --score-min L,0,-0.1' by default. The last parameter of '--score-min', 
      '-0.1', is the negative of maximum mismatch rate. This rate can be set by 
      option '--bowtie2-mismatch-rate'. If reads are paired-end, we additionally
      use options '--no-mixed' and '--no-discordant'.
    inputBinding:
      position: 106
      prefix: --bowtie2
  - id: bowtie2_k
    type:
      - 'null'
      - int
    doc: '(Bowtie 2 parameter) Find up to <int> alignments per read. (Default: 200)'
    inputBinding:
      position: 106
      prefix: --bowtie2-k
  - id: bowtie2_mismatch_rate
    type:
      - 'null'
      - float
    doc: '(Bowtie 2 parameter) The maximum mismatch rate allowed. (Default: 0.1)'
    inputBinding:
      position: 106
      prefix: --bowtie2-mismatch-rate
  - id: bowtie2_path
    type:
      - 'null'
      - File
    doc: "(Bowtie 2 parameter) The path to the Bowtie 2 executables. (Default: the
      path to the Bowtie 2 executables is assumed to be in the user's PATH environment
      variable)"
    inputBinding:
      position: 106
      prefix: --bowtie2-path
  - id: bowtie2_sensitivity_level
    type:
      - 'null'
      - string
    doc: "(Bowtie 2 parameter) Set Bowtie 2's preset options in --end-to-end mode.
      This option controls how hard Bowtie 2 tries to find alignments. <string> must
      be one of \"very_fast\", \"fast\", \"sensitive\" and \"very_sensitive\". The
      four candidates correspond to Bowtie 2's \"--very-fast\", \"--fast\", \"--sensitive\"\
      \ and \"--very-sensitive\" options. (Default: \"sensitive\" - use Bowtie 2's
      default)"
    inputBinding:
      position: 106
      prefix: --bowtie2-sensitivity-level
  - id: bowtie_chunkmbs
    type:
      - 'null'
      - int
    doc: "(Bowtie parameter) memory allocated for best first alignment calculation
      (Default: 0 - use Bowtie's default)"
    inputBinding:
      position: 106
      prefix: --bowtie-chunkmbs
  - id: bowtie_e
    type:
      - 'null'
      - int
    doc: '(Bowtie parameter) max sum of mismatch quality scores across the alignment.
      (Default: 99999999)'
    inputBinding:
      position: 106
      prefix: --bowtie-e
  - id: bowtie_m
    type:
      - 'null'
      - int
    doc: '(Bowtie parameter) suppress all alignments for a read if > <int> valid alignments
      exist. (Default: 200)'
    inputBinding:
      position: 106
      prefix: --bowtie-m
  - id: bowtie_n
    type:
      - 'null'
      - int
    doc: '(Bowtie parameter) max # of mismatches in the seed. (Range: 0-3, Default:
      2)'
    inputBinding:
      position: 106
      prefix: --bowtie-n
  - id: bowtie_path
    type:
      - 'null'
      - File
    doc: "The path to the Bowtie executables. (Default: the path to the Bowtie executables
      is assumed to be in the user's PATH environment variable)"
    inputBinding:
      position: 106
      prefix: --bowtie-path
  - id: calc_ci
    type:
      - 'null'
      - boolean
    doc: Calculate 95% credibility intervals and posterior mean estimates. The 
      credibility level can be changed by setting '--ci-credibility-level'.
    inputBinding:
      position: 106
      prefix: --calc-ci
  - id: calc_pme
    type:
      - 'null'
      - boolean
    doc: Run RSEM's collapsed Gibbs sampler to calculate posterior mean 
      estimates.
    inputBinding:
      position: 106
      prefix: --calc-pme
  - id: cap_stacked_chipseq_reads
    type:
      - 'null'
      - boolean
    doc: Keep a maximum number of ChIP-seq reads that aligned to the same 
      genomic interval. This option is used when running prior-enhanced RSEM, 
      where prior is learned from multiple complementary data sets. This option 
      is only in use when either '--chipseq-read-files-multi-targets <string>' 
      or '--chipseq-bed-files-multi-targets <string>' is specified.
    inputBinding:
      position: 106
      prefix: --cap-stacked-chipseq-reads
  - id: chipseq_bed_files_multi_targets
    type:
      - 'null'
      - File
    doc: Comma-separated full path of BED files for multiple ChIP-seq targets. 
      This option is used when running prior-enhanced RSEM, where prior is 
      learned from multiple complementary data sets. It provides information of 
      ChIP-seq signals and must have at least the first six BED columns. All 
      files can be either ungzipped or gzipped with a suffix '.gz' or '.gzip'. 
      When this option is specified, the option '--partition-model <string>' 
      will be set to 'cmb_lgt' automatically.
    inputBinding:
      position: 106
      prefix: --chipseq-bed-files-multi-targets
  - id: chipseq_control_read_files
    type:
      - 'null'
      - File
    doc: Comma-separated full path of FASTQ read file(s) for ChIP-seq conrol. 
      This option is used when running prior-enhanced RSEM. It provides 
      information to call ChIP-seq peaks. The file(s) can be either ungzipped or
      gzipped with a suffix '.gz' or '.gzip'. The options '--bowtie-path <path>'
      and '--chipseq-target-read-files <string>' must be defined when this 
      option is specified.
    inputBinding:
      position: 106
      prefix: --chipseq-control-read-files
  - id: chipseq_peak_file
    type:
      - 'null'
      - File
    doc: Full path to a ChIP-seq peak file in ENCODE's narrowPeak, i.e. BED6+4, 
      format. This file is used when running prior-enhanced RSEM in the default 
      two-partition model. It partitions isoforms by whether they have ChIP-seq 
      overlapping with their transcription start site region or not. Each 
      partition will have its own prior parameter learned from a training set. 
      This file can be either gzipped or ungzipped.
    inputBinding:
      position: 106
      prefix: --chipseq-peak-file
  - id: chipseq_read_files_multi_targets
    type:
      - 'null'
      - File
    doc: Comma-separated full path of FASTQ read files for multiple ChIP-seq 
      targets. This option is used when running prior-enhanced RSEM, where prior
      is learned from multiple complementary data sets. It provides information 
      to calculate ChIP-seq signals. All files can be either ungzipped or 
      gzipped with a suffix '.gz' or '.gzip'. When this option is specified, the
      option '--bowtie-path <path>' must be defined and the option 
      '--partition-model <string>' will be set to 'cmb_lgt' automatically.
    inputBinding:
      position: 106
      prefix: --chipseq-read-files-multi-targets
  - id: chipseq_target_read_files
    type:
      - 'null'
      - File
    doc: Comma-separated full path of FASTQ read file(s) for ChIP-seq target. 
      This option is used when running prior-enhanced RSEM. It provides 
      information to calculate ChIP-seq peaks and signals. The file(s) can be 
      either ungzipped or gzipped with a suffix '.gz' or '.gzip'. The options 
      '--bowtie-path <path>' and '--chipseq-control-read-files <string>' must be
      defined when this option is specified.
    inputBinding:
      position: 106
      prefix: --chipseq-target-read-files
  - id: ci_credibility_level
    type:
      - 'null'
      - float
    doc: The credibility level for credibility intervals.
    inputBinding:
      position: 106
      prefix: --ci-credibility-level
  - id: ci_memory
    type:
      - 'null'
      - int
    doc: Maximum size (in memory, MB) of the auxiliary buffer used for computing
      credibility intervals (CI).
    inputBinding:
      position: 106
      prefix: --ci-memory
  - id: ci_number_of_samples_per_count_vector
    type:
      - 'null'
      - int
    doc: The number of read generating probability vectors sampled per sampled 
      count vector. The crebility intervals are calculated by first sampling P(C
      | D) and then sampling P(Theta | C) for each sampled count vector. This 
      option controls how many Theta vectors are sampled per sampled count 
      vector.
    inputBinding:
      position: 106
      prefix: --ci-number-of-samples-per-count-vector
  - id: estimate_rspd
    type:
      - 'null'
      - boolean
    doc: Set this option if you want to estimate the read start position 
      distribution (RSPD) from data. Otherwise, RSEM will use a uniform RSPD.
    inputBinding:
      position: 106
      prefix: --estimate-rspd
  - id: fai
    type:
      - 'null'
      - File
    doc: If the header section of input alignment file does not contain 
      reference sequence information, this option should be turned on. <file> is
      a FAI format file containing each reference sequence's name and length. 
      Please refer to the SAM official website for the details of FAI format.
    inputBinding:
      position: 106
      prefix: --fai
  - id: forward_prob
    type:
      - 'null'
      - float
    doc: Probability of generating a read from the forward strand of a 
      transcript. Set to 1 for a strand-specific protocol where all (upstream) 
      reads are derived from the forward strand, 0 for a strand-specific 
      protocol where all (upstream) read are derived from the reverse strand, or
      0.5 for a non-strand-specific protocol.
    inputBinding:
      position: 106
      prefix: --forward-prob
  - id: fragment_length_max
    type:
      - 'null'
      - int
    doc: Maximum read/insert length allowed. This is also the value for the 
      Bowtie/Bowtie 2 -X option.
    inputBinding:
      position: 106
      prefix: --fragment-length-max
  - id: fragment_length_mean
    type:
      - 'null'
      - float
    doc: '(single-end data only) The mean of the fragment length distribution, which
      is assumed to be a Gaussian. (Default: -1, which disables use of the fragment
      length distribution)'
    inputBinding:
      position: 106
      prefix: --fragment-length-mean
  - id: fragment_length_min
    type:
      - 'null'
      - int
    doc: Minimum read/insert length allowed. This is also the value for the 
      Bowtie/Bowtie2 -I option.
    inputBinding:
      position: 106
      prefix: --fragment-length-min
  - id: fragment_length_sd
    type:
      - 'null'
      - float
    doc: '(single-end data only) The standard deviation of the fragment length distribution,
      which is assumed to be a Gaussian. (Default: 0, which assumes that all fragments
      are of the same length, given by the rounded value of --fragment-length-mean)'
    inputBinding:
      position: 106
      prefix: --fragment-length-sd
  - id: gibbs_burnin
    type:
      - 'null'
      - int
    doc: The number of burn-in rounds for RSEM's Gibbs sampler. Each round 
      passes over the entire data set once. If RSEM can use multiple threads, 
      multiple Gibbs samplers will start at the same time and all samplers share
      the same burn-in number.
    inputBinding:
      position: 106
      prefix: --gibbs-burnin
  - id: gibbs_number_of_samples
    type:
      - 'null'
      - int
    doc: The total number of count vectors RSEM will collect from its Gibbs 
      samplers.
    inputBinding:
      position: 106
      prefix: --gibbs-number-of-samples
  - id: gibbs_sampling_gap
    type:
      - 'null'
      - int
    doc: The number of rounds between two succinct count vectors RSEM collects. 
      If the count vector after round N is collected, the count vector after 
      round N + <int> will also be collected.
    inputBinding:
      position: 106
      prefix: --gibbs-sampling-gap
  - id: hisat2_hca
    type:
      - 'null'
      - boolean
    doc: Use HISAT2 to align reads to the transcriptome according to Human Cell 
      Atlast SMART-Seq2 pipeline. In particular, we use HISAT parameters "-k 10 
      --secondary --rg-id=$sampleToken --rg SM:$sampleToken --rg LB:$sampleToken
      --rg PL:ILLUMINA --rg PU:$sampleToken --new-summary --summary-file 
      $sampleName.log --met-file $sampleName.hisat2.met.txt --met 5 --mp 1,1 
      --np 1 --score-min L,0,-0.1 --rdg 99999999,99999999 --rfg 
      99999999,99999999 --no-spliced-alignment --no-softclip --seed 12345". If 
      inputs are paired-end reads, we additionally use parameters "--no-mixed 
      --no-discordant".
    inputBinding:
      position: 106
      prefix: --hisat2-hca
  - id: hisat2_path
    type:
      - 'null'
      - File
    doc: "The path to HISAT2's executable. (Default: the path to HISAT2 executable
      is assumed to be in user's PATH environment variable)"
    inputBinding:
      position: 106
      prefix: --hisat2-path
  - id: keep_intermediate_files
    type:
      - 'null'
      - boolean
    doc: Keep temporary files generated by RSEM. RSEM creates a temporary 
      directory, 'sample_name.temp', into which it puts all intermediate output 
      files. If this directory already exists, RSEM overwrites all files 
      generated by previous RSEM runs inside of it. By default, after RSEM 
      finishes, the temporary directory is deleted. Set this option to prevent 
      the deletion of this directory and the intermediate files inside of it.
    inputBinding:
      position: 106
      prefix: --keep-intermediate-files
  - id: n_max_stacked_chipseq_reads
    type:
      - 'null'
      - int
    doc: The maximum number of stacked ChIP-seq reads to keep. This option is 
      used when running prior-enhanced RSEM, where prior is learned from 
      multiple complementary data sets. This option is only in use when the 
      option '--cap-stacked-chipseq-reads' is set.
    inputBinding:
      position: 106
      prefix: --n-max-stacked-chipseq-reads
  - id: no_bam_output
    type:
      - 'null'
      - boolean
    doc: Do not output any BAM file.
    inputBinding:
      position: 106
      prefix: --no-bam-output
  - id: no_qualities
    type:
      - 'null'
      - boolean
    doc: Input reads do not contain quality scores.
    inputBinding:
      position: 106
      prefix: --no-qualities
  - id: num_rspd_bins
    type:
      - 'null'
      - int
    doc: Number of bins in the RSPD. Only relevant when '--estimate-rspd' is 
      specified. Use of the default setting is recommended.
    inputBinding:
      position: 106
      prefix: --num-rspd-bins
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use. Both Bowtie/Bowtie2, expression estimation 
      and 'samtools sort' will use this many threads.
    inputBinding:
      position: 106
      prefix: --num-threads
  - id: output_genome_bam
    type:
      - 'null'
      - boolean
    doc: Generate a BAM file, 'sample_name.genome.bam', with alignments mapped 
      to genomic coordinates and annotated with their posterior probabilities. 
      In addition, RSEM will call samtools (included in RSEM package) to sort 
      and index the bam file. 'sample_name.genome.sorted.bam' and 
      'sample_name.genome.sorted.bam.bai' will be generated.
    inputBinding:
      position: 106
      prefix: --output-genome-bam
  - id: paired_end
    type:
      - 'null'
      - boolean
    doc: Input reads are paired-end reads.
    inputBinding:
      position: 106
      prefix: --paired-end
  - id: partition_model
    type:
      - 'null'
      - string
    doc: "A keyword to specify the partition model used by prior-enhanced RSEM. It
      must be one of the following keywords:\n\n        - pk\n          Partitioned
      by whether an isoform has a ChIP-seq peak overlapping\n          with its transcription
      start site (TSS) region. The TSS region is\n          defined as [TSS-500bp,
      TSS+500bp]. For simplicity, we refer this\n          type of peak as 'TSS peak'
      when explaining other keywords.\n\n        - pk_lgtnopk\n          First partitioned
      by TSS peak. Then, for isoforms in the 'no TSS\n          peak' set, a logistic
      model is employed to further classify them\n          into two partitions.\n\
      \n        - lm3, lm4, lm5, or lm6\n          Based on their ChIP-seq signals,
      isoforms are classified into 3, 4, 5, or 6 partitions by a linear regression
      model.\n\n        - nopk_lm2pk, nopk_lm3pk, nopk_lm4pk, or nopk_lm5pk\n    \
      \      First partitioned by TSS peak. Then, for isoforms in the 'with TSS\n\
      \          peak' set, a linear regression model is employed to further\n   \
      \       classify them into 2, 3, 4, or 5 partitions.\n\n        - pk_lm2nopk,
      pk_lm3nopk, pk_lm4nopk, or pk_lm5nopk\n          First partitioned by TSS peak.
      Then, for isoforms in the 'no TSS\n          peak' set, a linear regression
      model is employed to further\n          classify them into 2, 3, 4, or 5 partitions.\n\
      \n        - cmb_lgt\n          Using a logistic regression to combine TSS signals
      from multiple\n          complementary data sets and partition training set
      isoform into\n          'expressed' and 'not expressed'. This partition model
      is only in\n          use when either '--chipseq-read-files-multi-targets <string>'
      or\n          '--chipseq-bed-files-multi-targets <string> is specified.\n\n\
      \        Parameters for all the above models are learned from a training set.\n\
      \        For detailed explanations, please see prior-enhanced RSEM's paper.\n\
      \        (Default: 'pk')"
    inputBinding:
      position: 106
      prefix: --partition-model
  - id: phred33_quals
    type:
      - 'null'
      - boolean
    doc: Input quality scores are encoded as Phred+33. This option is used by 
      Bowtie, Bowtie 2 and HISAT2.
    inputBinding:
      position: 106
      prefix: --phred33-quals
  - id: phred64_quals
    type:
      - 'null'
      - boolean
    doc: Input quality scores are encoded as Phred+64 (default for GA Pipeline 
      ver. >= 1.3). This option is used by Bowtie, Bowtie 2 and HISAT2.
    inputBinding:
      position: 106
      prefix: --phred64-quals
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress the output of logging information.
    inputBinding:
      position: 106
      prefix: --quiet
  - id: run_pRSEM
    type:
      - 'null'
      - boolean
    doc: Running prior-enhanced RSEM (pRSEM). Prior parameters, i.e. isoform's 
      initial pseudo-count for RSEM's Gibbs sampling, will be learned from input
      RNA-seq data and an external data set. When pRSEM needs and only needs 
      ChIP-seq peak information to partition isoforms (e.g. in pRSEM's default 
      partition model), either ChIP-seq peak file (with the 
      '--chipseq-peak-file' option) or ChIP-seq FASTQ files for target and input
      and the path for Bowtie executables are required (with the 
      '--chipseq-target-read-files <string>', '--chipseq-control-read-files 
      <string>', and '--bowtie-path <path>' options), otherwise, ChIP-seq FASTQ 
      files for target and control and the path to Bowtie executables are 
      required.
    inputBinding:
      position: 106
      prefix: --run-pRSEM
  - id: sam
    type:
      - 'null'
      - boolean
    doc: Inputs are alignments in SAM format.
    inputBinding:
      position: 106
      prefix: --sam
  - id: sampling_for_bam
    type:
      - 'null'
      - boolean
    doc: When RSEM generates a BAM file, instead of outputting all alignments a 
      read has with their posterior probabilities, one alignment is sampled 
      according to the posterior probabilities. The sampling procedure includes 
      the alignment to the "noise" transcript, which does not appear in the BAM 
      file. Only the sampled alignment has a weight of 1. All other alignments 
      have weight 0. If the "noise" transcript is sampled, all alignments 
      appeared in the BAM file should have weight 0.
    inputBinding:
      position: 106
      prefix: --sampling-for-bam
  - id: seed
    type:
      - 'null'
      - string
    doc: Set the seed for the random number generators used in calculating 
      posterior mean estimates and credibility intervals. The seed must be a 
      non-negative 32 bit integer.
    inputBinding:
      position: 106
      prefix: --seed
  - id: seed_length
    type:
      - 'null'
      - int
    doc: Seed length used by the read aligner. Providing the correct value is 
      important for RSEM. If RSEM runs Bowtie, it uses this value for Bowtie's 
      seed length parameter. Any read with its or at least one of its mates' 
      (for paired-end reads) length less than this value will be ignored. If the
      references are not added poly(A) tails, the minimum allowed value is 5, 
      otherwise, the minimum allowed value is 25. Note that this script will 
      only check if the value >= 5 and give a warning message if the value < 25 
      but >= 5.
    inputBinding:
      position: 106
      prefix: --seed-length
  - id: single_cell_prior
    type:
      - 'null'
      - boolean
    doc: By default, RSEM uses Dirichlet(1) as the prior to calculate posterior 
      mean estimates and credibility intervals. However, much less genes are 
      expressed in single cell RNA-Seq data. Thus, if you want to compute 
      posterior mean estimates and/or credibility intervals and you have 
      single-cell RNA-Seq data, you are recommended to turn on this option. Then
      RSEM will use Dirichlet(0.1) as the prior which encourage the sparsity of 
      the expression levels.
    inputBinding:
      position: 106
      prefix: --single-cell-prior
  - id: solexa_quals
    type:
      - 'null'
      - boolean
    doc: Input quality scores are solexa encoded (from GA Pipeline ver. < 1.3). 
      This option is used by Bowtie, Bowtie 2 and HISAT2.
    inputBinding:
      position: 106
      prefix: --solexa-quals
  - id: sort_bam_by_coordinate
    type:
      - 'null'
      - boolean
    doc: Sort RSEM generated transcript and genome BAM files by coordinates and 
      build associated indices.
    inputBinding:
      position: 106
      prefix: --sort-bam-by-coordinate
  - id: sort_bam_by_read_name
    type:
      - 'null'
      - boolean
    doc: Sort BAM file aligned under transcript coordidate by read name. Setting
      this option on will produce deterministic maximum likelihood estimations 
      from independent runs. Note that sorting will take long time and lots of 
      memory.
    inputBinding:
      position: 106
      prefix: --sort-bam-by-read-name
  - id: sort_bam_memory_per_thread
    type:
      - 'null'
      - string
    doc: Set the maximum memory per thread that can be used by 'samtools sort'. 
      <string> represents the memory and accepts suffices 'K/M/G'. RSEM will 
      pass <string> to the '-m' option of 'samtools sort'. Note that the default
      used here is different from the default used by samtools.
    inputBinding:
      position: 106
      prefix: --sort-bam-memory-per-thread
  - id: star
    type:
      - 'null'
      - boolean
    doc: Use STAR to align reads. Alignment parameters are from ENCODE3's 
      STAR-RSEM pipeline. To save computational time and memory resources, 
      STAR's Output BAM file is unsorted. It is stored in RSEM's temporary 
      directory with name as 'sample_name.bam'. Each STAR job will have its own 
      private copy of the genome in memory.
    inputBinding:
      position: 106
      prefix: --star
  - id: star_bzipped_read_file
    type:
      - 'null'
      - boolean
    doc: (STAR parameter) Input read file(s) is compressed by bzip2.
    inputBinding:
      position: 106
      prefix: --star-bzipped-read-file
  - id: star_gzipped_read_file
    type:
      - 'null'
      - boolean
    doc: (STAR parameter) Input read file(s) is compressed by gzip.
    inputBinding:
      position: 106
      prefix: --star-gzipped-read-file
  - id: star_output_genome_bam
    type:
      - 'null'
      - boolean
    doc: (STAR parameter) Save the BAM file from STAR alignment under genomic 
      coordinate to 'sample_name.STAR.genome.bam'. This file is NOT sorted by 
      genomic coordinate. In this file, according to STAR's manual, 'paired ends
      of an alignment are always adjacent, and multiple alignments of a read are
      adjacent as well'.
    inputBinding:
      position: 106
      prefix: --star-output-genome-bam
  - id: star_path
    type:
      - 'null'
      - File
    doc: "The path to STAR's executable. (Default: the path to STAR executable is
      assumed to be in user's PATH environment variable)"
    inputBinding:
      position: 106
      prefix: --star-path
  - id: strand_specific
    type:
      - 'null'
      - boolean
    doc: Equivalent to '--strandedness forward'.
    inputBinding:
      position: 106
      prefix: --strand-specific
  - id: strandedness
    type:
      - 'null'
      - string
    doc: "This option defines the strandedness of the RNA-Seq reads. It recognizes
      three values: 'none', 'forward', and 'reverse'. 'none' refers to non-strand-specific
      protocols. 'forward' means all (upstream) reads are derived from the forward
      strand. 'reverse' means all (upstream) reads are derived from the reverse strand.
      If 'forward'/'reverse' is set, the '--norc'/'--nofw' Bowtie/Bowtie 2 option
      will also be enabled to avoid aligning reads to the opposite strand. For Illumina
      TruSeq Stranded protocols, please use 'reverse'."
    inputBinding:
      position: 106
      prefix: --strandedness
  - id: tag
    type:
      - 'null'
      - string
    doc: The name of the optional field used in the SAM input for identifying a 
      read with too many valid alignments. The field should have the format 
      <tagName>:i:<value>, where a <value> bigger than 0 indicates a read with 
      too many alignments.
    inputBinding:
      position: 106
      prefix: --tag
  - id: temporary_folder
    type:
      - 'null'
      - string
    doc: Set where to put the temporary files generated by RSEM. If the folder 
      specified does not exist, RSEM will try to create it.
    inputBinding:
      position: 106
      prefix: --temporary-folder
  - id: time
    type:
      - 'null'
      - boolean
    doc: Output time consumed by each step of RSEM to 'sample_name.time'.
    inputBinding:
      position: 106
      prefix: --time
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
stdout: rsem_rsem-calculate-expression.out
