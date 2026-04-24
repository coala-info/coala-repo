cwlVersion: v1.2
class: CommandLineTool
baseCommand: mason_simulator
label: mason_mason_simulator
doc: "Simulate NUM reads/pairs from the reference sequence IN.fa, potentially with
  variants from IN.vcf.\n\nTool homepage: https://www.seqan.de/apps/mason.html"
inputs:
  - id: _background_noise_mean
    type:
      - 'null'
      - float
    doc: Mean of lognormal distribution to use for the noise. In range [0..inf].
    inputBinding:
      position: 101
      prefix: --454-background-noise-mean
  - id: _background_noise_stddev
    type:
      - 'null'
      - float
    doc: Standard deviation of lognormal distribution to use for the noise. In 
      range [0..inf].
    inputBinding:
      position: 101
      prefix: --454-background-noise-stddev
  - id: _no_sqrt_in_std_dev
    type:
      - 'null'
      - boolean
    doc: For error model, if set then (sigma = k * r)) is used, otherwise (sigma
      = k * sqrt(r)).
    inputBinding:
      position: 101
      prefix: --454-no-sqrt-in-std-dev
  - id: _proportionality_factor
    type:
      - 'null'
      - float
    doc: Proportionality factor for calculating the standard deviation 
      proportional to the read length. In range [0..inf].
    inputBinding:
      position: 101
      prefix: --454-proportionality-factor
  - id: _read_length_max
    type:
      - 'null'
      - int
    doc: The maximal read length when the read length is sampled uniformly. In 
      range [0..inf].
    inputBinding:
      position: 101
      prefix: --454-read-length-max
  - id: _read_length_mean
    type:
      - 'null'
      - float
    doc: The mean read length when the read length is sampled with normal 
      distribution. In range [0..inf].
    inputBinding:
      position: 101
      prefix: --454-read-length-mean
  - id: _read_length_min
    type:
      - 'null'
      - int
    doc: The minimal read length when the read length is sampled uniformly. In 
      range [0..inf].
    inputBinding:
      position: 101
      prefix: --454-read-length-min
  - id: _read_length_model
    type:
      - 'null'
      - string
    doc: The model to use for sampling the 454 read length. One of normal and 
      uniform.
    inputBinding:
      position: 101
      prefix: --454-read-length-model
  - id: _read_length_stddev
    type:
      - 'null'
      - float
    doc: The read length standard deviation when the read length is sampled with
      normal distribution. In range [0..inf].
    inputBinding:
      position: 101
      prefix: --454-read-length-stddev
  - id: bs_seq_conversion_rate
    type:
      - 'null'
      - float
    doc: Conversion rate for unmethylated Cs to become Ts. In range [0..1].
    inputBinding:
      position: 101
      prefix: --bs-seq-conversion-rate
  - id: bs_seq_protocol
    type:
      - 'null'
      - string
    doc: Protocol to use for BS-Seq simulation. One of directional and 
      undirectional.
    inputBinding:
      position: 101
      prefix: --bs-seq-protocol
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: Number of fragments to simulate in one batch. See note about 
      Parallelism at the end of the help page. In range [1..inf].
    inputBinding:
      position: 101
      prefix: --chunk-size
  - id: embed_read_info
    type:
      - 'null'
      - boolean
    doc: Whether or not to embed read information.
    inputBinding:
      position: 101
      prefix: --embed-read-info
  - id: enable_bs_seq
    type:
      - 'null'
      - boolean
    doc: Enable BS-seq simulation.
    inputBinding:
      position: 101
      prefix: --enable-bs-seq
  - id: force_single_end
    type:
      - 'null'
      - boolean
    doc: Force single-end simulation although --out-right file is given.
    inputBinding:
      position: 101
      prefix: --force-single-end
  - id: fragment_max_size
    type:
      - 'null'
      - int
    doc: Largest fragment size to use when using uniform fragment size 
      simulation. In range [1..inf].
    inputBinding:
      position: 101
      prefix: --fragment-max-size
  - id: fragment_mean_size
    type:
      - 'null'
      - int
    doc: Mean fragment size for normally distributed fragment size simulation. 
      In range [1..inf].
    inputBinding:
      position: 101
      prefix: --fragment-mean-size
  - id: fragment_min_size
    type:
      - 'null'
      - int
    doc: Smallest fragment size to use when using uniform fragment size 
      simulation. In range [1..inf].
    inputBinding:
      position: 101
      prefix: --fragment-min-size
  - id: fragment_size_model
    type:
      - 'null'
      - string
    doc: The model to use for the fragment size simulation. One of normal and 
      uniform.
    inputBinding:
      position: 101
      prefix: --fragment-size-model
  - id: fragment_size_std_dev
    type:
      - 'null'
      - int
    doc: Fragment size standard deviation when using normally distributed 
      fragment size simulation. In range [1..inf].
    inputBinding:
      position: 101
      prefix: --fragment-size-std-dev
  - id: illumina_error_profile_file
    type:
      - 'null'
      - File
    doc: 'Path to file with Illumina error profile. The file must be a text file with
      floating point numbers separated by space, each giving a positional error rate.
      Valid filetype is: .txt.'
    inputBinding:
      position: 101
      prefix: --illumina-error-profile-file
  - id: illumina_left_template_fastq
    type:
      - 'null'
      - File
    doc: 'FASTQ file to use for a template for left-end reads. Valid filetypes are:
      .sam[.*], .raw[.*], .gbk[.*], .frn[.*], .fq[.*], .fna[.*], .ffn[.*], .fastq[.*],
      .fasta[.*], .fas[.*], .faa[.*], .fa[.*], .embl[.*], and .bam, where * is any
      of the following extensions: gz, bz2, and bgzf for transparent (de)compression.'
    inputBinding:
      position: 101
      prefix: --illumina-left-template-fastq
  - id: illumina_mismatch_quality_mean_begin
    type:
      - 'null'
      - float
    doc: 'Mean PHRED quality for mismatch bases of first base in Illumina sequencing.
      Default: 40.0.'
    inputBinding:
      position: 101
      prefix: --illumina-mismatch-quality-mean-begin
  - id: illumina_mismatch_quality_mean_end
    type:
      - 'null'
      - float
    doc: 'Mean PHRED quality for mismatch bases of last base in Illumina sequencing.
      Default: 30.0.'
    inputBinding:
      position: 101
      prefix: --illumina-mismatch-quality-mean-end
  - id: illumina_mismatch_quality_stddev_begin
    type:
      - 'null'
      - float
    doc: 'Standard deviation of PHRED quality for mismatch bases of first base in
      Illumina sequencing. Default: 3.0.'
    inputBinding:
      position: 101
      prefix: --illumina-mismatch-quality-stddev-begin
  - id: illumina_mismatch_quality_stddev_end
    type:
      - 'null'
      - float
    doc: 'Standard deviation of PHRED quality for mismatch bases of last base in Illumina
      sequencing. Default: 15.0.'
    inputBinding:
      position: 101
      prefix: --illumina-mismatch-quality-stddev-end
  - id: illumina_position_raise
    type:
      - 'null'
      - float
    doc: Point where the error curve raises in relation to read length. In range
      [0.0..1.0].
    inputBinding:
      position: 101
      prefix: --illumina-position-raise
  - id: illumina_prob_deletion
    type:
      - 'null'
      - float
    doc: Insert per-base probability for deletion in Illumina sequencing. In 
      range [0..1].
    inputBinding:
      position: 101
      prefix: --illumina-prob-deletion
  - id: illumina_prob_insert
    type:
      - 'null'
      - float
    doc: Insert per-base probability for insertion in Illumina sequencing. In 
      range [0..1].
    inputBinding:
      position: 101
      prefix: --illumina-prob-insert
  - id: illumina_prob_mismatch
    type:
      - 'null'
      - float
    doc: Average per-base mismatch probability in Illumina sequencing. In range 
      [0.0..1.0].
    inputBinding:
      position: 101
      prefix: --illumina-prob-mismatch
  - id: illumina_prob_mismatch_begin
    type:
      - 'null'
      - float
    doc: Per-base mismatch probability of first base in Illumina sequencing. In 
      range [0.0..1.0].
    inputBinding:
      position: 101
      prefix: --illumina-prob-mismatch-begin
  - id: illumina_prob_mismatch_end
    type:
      - 'null'
      - float
    doc: Per-base mismatch probability of last base in Illumina sequencing. In 
      range [0.0..1.0].
    inputBinding:
      position: 101
      prefix: --illumina-prob-mismatch-end
  - id: illumina_prob_mismatch_scale
    type:
      - 'null'
      - float
    doc: Scaling factor for Illumina mismatch probability. In range [0..inf].
    inputBinding:
      position: 101
      prefix: --illumina-prob-mismatch-scale
  - id: illumina_quality_mean_begin
    type:
      - 'null'
      - float
    doc: 'Mean PHRED quality for non-mismatch bases of first base in Illumina sequencing.
      Default: 40.0.'
    inputBinding:
      position: 101
      prefix: --illumina-quality-mean-begin
  - id: illumina_quality_mean_end
    type:
      - 'null'
      - float
    doc: 'Mean PHRED quality for non-mismatch bases of last base in Illumina sequencing.
      Default: 39.5.'
    inputBinding:
      position: 101
      prefix: --illumina-quality-mean-end
  - id: illumina_quality_stddev_begin
    type:
      - 'null'
      - float
    doc: 'Standard deviation of PHRED quality for non-mismatch bases of first base
      in Illumina sequencing. Default: 0.05.'
    inputBinding:
      position: 101
      prefix: --illumina-quality-stddev-begin
  - id: illumina_quality_stddev_end
    type:
      - 'null'
      - float
    doc: 'Standard deviation of PHRED quality for non-mismatch bases of last base
      in Illumina sequencing. Default: 10.0.'
    inputBinding:
      position: 101
      prefix: --illumina-quality-stddev-end
  - id: illumina_read_length
    type:
      - 'null'
      - int
    doc: Read length for Illumina simulation. In range [1..inf].
    inputBinding:
      position: 101
      prefix: --illumina-read-length
  - id: illumina_right_template_fastq
    type:
      - 'null'
      - File
    doc: 'FASTQ file to use for a template for right-end reads. Valid filetypes are:
      .sam[.*], .raw[.*], .gbk[.*], .frn[.*], .fq[.*], .fna[.*], .ffn[.*], .fastq[.*],
      .fasta[.*], .fas[.*], .faa[.*], .fa[.*], .embl[.*], and .bam, where * is any
      of the following extensions: gz, bz2, and bgzf for transparent (de)compression.'
    inputBinding:
      position: 101
      prefix: --illumina-right-template-fastq
  - id: input_reference
    type: File
    doc: "Path to FASTA file to read the reference from. Many contigs in a reference
      might be a problem due to many file handles that need to be opened. Check the
      hard limit of file handles with 'ulimit -Hn' and increase the soft limit to
      the hard limit with 'ulimit -Sn <number>' if necessary. Valid filetypes are:
      .sam[.*], .raw[.*], .gbk[.*], .frn[.*], .fq[.*], .fna[.*], .ffn[.*], .fastq[.*],
      .fasta[.*], .fas[.*], .faa[.*], .fa[.*], .embl[.*], and .bam, where * is any
      of the following extensions: gz, bz2, and bgzf for transparent (de)compression."
    inputBinding:
      position: 101
      prefix: --input-reference
  - id: input_vcf
    type:
      - 'null'
      - File
    doc: 'Path to the VCF file with variants to apply. Valid filetype is: .vcf[.*],
      where * is any of the following extensions: gz, bz2, and bgzf for transparent
      (de)compression.'
    inputBinding:
      position: 101
      prefix: --input-vcf
  - id: meth_cg_mu
    type:
      - 'null'
      - float
    doc: Median of beta distribution for methylation level of CpG loci. In range
      [0..1].
    inputBinding:
      position: 101
      prefix: --meth-cg-mu
  - id: meth_cg_sigma
    type:
      - 'null'
      - float
    doc: Standard deviation of beta distribution for methylation level of CpG 
      loci. In range [0..1].
    inputBinding:
      position: 101
      prefix: --meth-cg-sigma
  - id: meth_chg_mu
    type:
      - 'null'
      - float
    doc: Median of beta distribution for methylation level of CHG loci. In range
      [0..1].
    inputBinding:
      position: 101
      prefix: --meth-chg-mu
  - id: meth_chg_sigma
    type:
      - 'null'
      - float
    doc: Standard deviation of beta distribution for methylation level of CHG 
      loci. In range [0..1].
    inputBinding:
      position: 101
      prefix: --meth-chg-sigma
  - id: meth_chh_mu
    type:
      - 'null'
      - float
    doc: Median of beta distribution for methylation level of CHH loci. In range
      [0..1].
    inputBinding:
      position: 101
      prefix: --meth-chh-mu
  - id: meth_chh_sigma
    type:
      - 'null'
      - float
    doc: Standard deviation of beta distribution for methylation level of CHH 
      loci. In range [0..1].
    inputBinding:
      position: 101
      prefix: --meth-chh-sigma
  - id: meth_fasta_in
    type:
      - 'null'
      - File
    doc: 'FASTA file with methylation levels of the input file. Valid filetypes are:
      .sam[.*], .raw[.*], .gbk[.*], .frn[.*], .fq[.*], .fna[.*], .ffn[.*], .fastq[.*],
      .fasta[.*], .fas[.*], .faa[.*], .fa[.*], .embl[.*], and .bam, where * is any
      of the following extensions: gz, bz2, and bgzf for transparent (de)compression.'
    inputBinding:
      position: 101
      prefix: --meth-fasta-in
  - id: meth_seed
    type:
      - 'null'
      - int
    doc: Seed to use for methylation level random number generator.
    inputBinding:
      position: 101
      prefix: --meth-seed
  - id: methylation_levels
    type:
      - 'null'
      - boolean
    doc: Enable methylation level simulation.
    inputBinding:
      position: 101
      prefix: --methylation-levels
  - id: num_fragments
    type: int
    doc: Number of reads/pairs to simulate. In range [1..inf].
    inputBinding:
      position: 101
      prefix: --num-fragments
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.See note about Parallelism at the end of the 
      help page. In range [1..inf].
    inputBinding:
      position: 101
      prefix: --num-threads
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Low verbosity.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: read_name_prefix
    type:
      - 'null'
      - string
    doc: Read names will have this prefix.
    inputBinding:
      position: 101
      prefix: --read-name-prefix
  - id: sanger_prob_deletion_begin
    type:
      - 'null'
      - float
    doc: Per-base deletion probability of first base in Sanger sequencing. In 
      range [0.0..1.0].
    inputBinding:
      position: 101
      prefix: --sanger-prob-deletion-begin
  - id: sanger_prob_deletion_end
    type:
      - 'null'
      - float
    doc: Per-base deletion probability of last base in Sanger sequencing. In 
      range [0.0..1.0].
    inputBinding:
      position: 101
      prefix: --sanger-prob-deletion-end
  - id: sanger_prob_insertion_begin
    type:
      - 'null'
      - float
    doc: Per-base insertion probability of first base in Sanger sequencing. In 
      range [0.0..1.0].
    inputBinding:
      position: 101
      prefix: --sanger-prob-insertion-begin
  - id: sanger_prob_insertion_end
    type:
      - 'null'
      - float
    doc: Per-base insertion probability of last base in Sanger sequencing. In 
      range [0.0..1.0].
    inputBinding:
      position: 101
      prefix: --sanger-prob-insertion-end
  - id: sanger_prob_mismatch_begin
    type:
      - 'null'
      - float
    doc: Per-base mismatch probability of first base in Sanger sequencing. In 
      range [0.0..1.0].
    inputBinding:
      position: 101
      prefix: --sanger-prob-mismatch-begin
  - id: sanger_prob_mismatch_end
    type:
      - 'null'
      - float
    doc: Per-base mismatch probability of last base in Sanger sequencing. In 
      range [0.0..1.0].
    inputBinding:
      position: 101
      prefix: --sanger-prob-mismatch-end
  - id: sanger_prob_mismatch_scale
    type:
      - 'null'
      - float
    doc: Scaling factor for Sanger mismatch probability. In range [0..inf].
    inputBinding:
      position: 101
      prefix: --sanger-prob-mismatch-scale
  - id: sanger_quality_error_end_mean
    type:
      - 'null'
      - float
    doc: 'Mean PHRED quality for erroneous bases of last base in Sanger sequencing.
      Default: 20.'
    inputBinding:
      position: 101
      prefix: --sanger-quality-error-end-mean
  - id: sanger_quality_error_end_stddev
    type:
      - 'null'
      - float
    doc: 'Mean PHRED quality for erroneous bases of last base in Sanger sequencing.
      Default: 5.'
    inputBinding:
      position: 101
      prefix: --sanger-quality-error-end-stddev
  - id: sanger_quality_error_start_mean
    type:
      - 'null'
      - float
    doc: 'Mean PHRED quality for erroneous bases of first base in Sanger sequencing.
      Default: 30.'
    inputBinding:
      position: 101
      prefix: --sanger-quality-error-start-mean
  - id: sanger_quality_error_start_stddev
    type:
      - 'null'
      - float
    doc: 'Mean PHRED quality for erroneous bases of first base in Sanger sequencing.
      Default: 2.'
    inputBinding:
      position: 101
      prefix: --sanger-quality-error-start-stddev
  - id: sanger_quality_match_end_mean
    type:
      - 'null'
      - float
    doc: 'Mean PHRED quality for non-mismatch bases of last base in Sanger sequencing.
      Default: 39.5.'
    inputBinding:
      position: 101
      prefix: --sanger-quality-match-end-mean
  - id: sanger_quality_match_end_stddev
    type:
      - 'null'
      - float
    doc: 'Mean PHRED quality for non-mismatch bases of last base in Sanger sequencing.
      Default: 2.'
    inputBinding:
      position: 101
      prefix: --sanger-quality-match-end-stddev
  - id: sanger_quality_match_start_mean
    type:
      - 'null'
      - float
    doc: 'Mean PHRED quality for non-mismatch bases of first base in Sanger sequencing.
      Default: 40.0.'
    inputBinding:
      position: 101
      prefix: --sanger-quality-match-start-mean
  - id: sanger_quality_match_start_stddev
    type:
      - 'null'
      - float
    doc: 'Mean PHRED quality for non-mismatch bases of first base in Sanger sequencing.
      Default: 0.1.'
    inputBinding:
      position: 101
      prefix: --sanger-quality-match-start-stddev
  - id: sanger_read_length_error
    type:
      - 'null'
      - float
    doc: The read length standard deviation when the read length is sampled 
      uniformly. In range [0..inf].
    inputBinding:
      position: 101
      prefix: --sanger-read-length-error
  - id: sanger_read_length_max
    type:
      - 'null'
      - int
    doc: The maximal read length when the read length is sampled uniformly. In 
      range [0..inf].
    inputBinding:
      position: 101
      prefix: --sanger-read-length-max
  - id: sanger_read_length_mean
    type:
      - 'null'
      - float
    doc: The mean read length when the read length is sampled with normal 
      distribution. In range [0..inf].
    inputBinding:
      position: 101
      prefix: --sanger-read-length-mean
  - id: sanger_read_length_min
    type:
      - 'null'
      - int
    doc: The minimal read length when the read length is sampled uniformly. In 
      range [0..inf].
    inputBinding:
      position: 101
      prefix: --sanger-read-length-min
  - id: sanger_read_length_model
    type:
      - 'null'
      - string
    doc: The model to use for sampling the Sanger read length. One of normal and
      uniform.
    inputBinding:
      position: 101
      prefix: --sanger-read-length-model
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed to use for random number generator.
    inputBinding:
      position: 101
      prefix: --seed
  - id: seed_spacing
    type:
      - 'null'
      - int
    doc: Offset for seeds to use when multi-threading.
    inputBinding:
      position: 101
      prefix: --seed-spacing
  - id: seq_mate_orientation
    type:
      - 'null'
      - string
    doc: Orientation for paired reads. See section Read Orientation below. One 
      of FR, RF, FF, and FF2.
    inputBinding:
      position: 101
      prefix: --seq-mate-orientation
  - id: seq_strands
    type:
      - 'null'
      - string
    doc: Strands to simulate from, only applicable to paired sequencing 
      simulation. One of forward, reverse, and both.
    inputBinding:
      position: 101
      prefix: --seq-strands
  - id: seq_technology
    type:
      - 'null'
      - string
    doc: Set sequencing technology to simulate. One of illumina, 454, and 
      sanger.
    inputBinding:
      position: 101
      prefix: --seq-technology
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Higher verbosity.
    inputBinding:
      position: 101
      prefix: --verbose
  - id: version_check
    type:
      - 'null'
      - boolean
    doc: Turn this option off to disable version update notifications of the 
      application. One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO.
    inputBinding:
      position: 101
      prefix: --version-check
  - id: very_verbose
    type:
      - 'null'
      - boolean
    doc: Highest verbosity.
    inputBinding:
      position: 101
      prefix: --very-verbose
outputs:
  - id: out_left
    type: File
    doc: 'Output of single-end/left end reads. Valid filetypes are: .sam[.*], .raw[.*],
      .frn[.*], .fq[.*], .fna[.*], .ffn[.*], .fastq[.*], .fasta[.*], .fas[.*], .faa[.*],
      .fa[.*], and .bam, where * is any of the following extensions: gz, bz2, and
      bgzf for transparent (de)compression.'
    outputBinding:
      glob: $(inputs.out_left)
  - id: out_right
    type:
      - 'null'
      - File
    doc: 'Output of right reads. Giving this options enables paired-end simulation.
      Valid filetypes are: .sam[.*], .raw[.*], .frn[.*], .fq[.*], .fna[.*], .ffn[.*],
      .fastq[.*], .fasta[.*], .fas[.*], .faa[.*], .fa[.*], and .bam, where * is any
      of the following extensions: gz, bz2, and bgzf for transparent (de)compression.'
    outputBinding:
      glob: $(inputs.out_right)
  - id: out_alignment
    type:
      - 'null'
      - File
    doc: 'SAM/BAM file with alignments. Valid filetypes are: .sam[.*] and .bam, where
      * is any of the following extensions: gz, bz2, and bgzf for transparent (de)compression.'
    outputBinding:
      glob: $(inputs.out_alignment)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mason:2.0.13--h7f3286b_0
