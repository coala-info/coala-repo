cwlVersion: v1.2
class: CommandLineTool
baseCommand: damidseq_pipeline
label: damidseq_pipeline
doc: "Copyright 2013-25, Owen Marshall\n\nTool homepage: https://github.com/owenjm/damidseq_pipeline"
inputs:
  - id: as_gatc
    type:
      - 'null'
      - boolean
    doc: Output files at GATC resolution
    default: true
    inputBinding:
      position: 101
      prefix: --as_gatc
  - id: bamfiles
    type:
      - 'null'
      - boolean
    doc: Only process BAM files
    inputBinding:
      position: 101
      prefix: --bamfiles
  - id: bedtools_path
    type:
      - 'null'
      - string
    doc: path to BEDTools executable (leave blank if in path)
    inputBinding:
      position: 101
      prefix: --bedtools_path
  - id: bins
    type:
      - 'null'
      - int
    doc: Width of bins to use for mapping reads
    default: 75
    inputBinding:
      position: 101
      prefix: --bins
  - id: bowtie
    type:
      - 'null'
      - boolean
    doc: Perform bowtie2 alignment [1/0]
    default: true
    inputBinding:
      position: 101
      prefix: --bowtie
  - id: bowtie2_add_flags
    type:
      - 'null'
      - string
    doc: Additional flags to use for bowtie2 alignment
    inputBinding:
      position: 101
      prefix: --bowtie2_add_flags
  - id: bowtie2_genome_dir
    type:
      - 'null'
      - Directory
    doc: Directory and basename for bowtie2 .bt2 indices
    inputBinding:
      position: 101
      prefix: --bowtie2_genome_dir
  - id: bowtie2_path
    type:
      - 'null'
      - string
    doc: path to bowtie2 executable (leave blank if in path)
    inputBinding:
      position: 101
      prefix: --bowtie2_path
  - id: catada
    type:
      - 'null'
      - boolean
    doc: Generate coverage files for CATaDa. Alias for --just_coverage
    inputBinding:
      position: 101
      prefix: --catada
  - id: chipseq
    type:
      - 'null'
      - boolean
    doc: Process ChIP-seq data (Equivalent to --just_coverage --as_gatc=0 
      --remdups --unique --extension_method=full --full_data_files)
    inputBinding:
      position: 101
      prefix: --chipseq
  - id: coverage
    type:
      - 'null'
      - boolean
    doc: Save individual coverage bedgraphs
    inputBinding:
      position: 101
      prefix: --coverage
  - id: dam
    type:
      - 'null'
      - File
    doc: Specify file to use as Dam control
    inputBinding:
      position: 101
      prefix: --dam
  - id: datadir
    type:
      - 'null'
      - Directory
    doc: Process all files in this directory
    inputBinding:
      position: 101
      prefix: --datadir
  - id: exp_prefix
    type:
      - 'null'
      - string
    doc: Common text string immediately preceding experiment name (e.g. if 
      filename is Dam_Exp1_n1.fq.gz, use _ as the prefix)
    default: _
    inputBinding:
      position: 101
      prefix: --exp_prefix
  - id: exp_suffix
    type:
      - 'null'
      - string
    doc: Common text string immediately proceding experiment name (Takes 
      --rep_prefix if not set; or, if filename is 
      Dam_Exp1_some-other-text_n1.fq.gz, use _ as the suffix)
    inputBinding:
      position: 101
      prefix: --exp_suffix
  - id: extend_reads
    type:
      - 'null'
      - boolean
    doc: Perform read extension [1/0]
    default: true
    inputBinding:
      position: 101
      prefix: --extend_reads
  - id: extension_method
    type:
      - 'null'
      - string
    doc: 'Read extension method to use; options are: full: Method used by version
      1.3 and earlier. Extends all reads to the value set with --len. gatc: Default
      for version 1.4 and above. Extends reads to --len or to the next GATC site,
      whichever is shorter. Using this option increases peak resolution.'
    default: gatc
    inputBinding:
      position: 101
      prefix: --extension_method
  - id: full_data_files
    type:
      - 'null'
      - boolean
    doc: Output full binned ratio files (not only GATC array)
    inputBinding:
      position: 101
      prefix: --full_data_files
  - id: gatc_frag_file
    type:
      - 'null'
      - File
    doc: GFF file containing all instances of the sequence GATC
    inputBinding:
      position: 101
      prefix: --gatc_frag_file
  - id: just_align
    type:
      - 'null'
      - boolean
    doc: Just align the FASTQ files, generate BAM files, and exit
    inputBinding:
      position: 101
      prefix: --just_align
  - id: just_coverage
    type:
      - 'null'
      - boolean
    doc: Align, generate BAMs and calculate coverage; do generate ratio files
    inputBinding:
      position: 101
      prefix: --just_coverage
  - id: kde_inline
    type:
      - 'null'
      - boolean
    doc: Use Inline::C for KDE normalisation calculations
    default: true
    inputBinding:
      position: 101
      prefix: --kde_inline
  - id: kde_plot
    type:
      - 'null'
      - boolean
    doc: create an Rplot of the kernel density fit for normalisation (requires 
      R)
    inputBinding:
      position: 101
      prefix: --kde_plot
  - id: keep_original_bams
    type:
      - 'null'
      - boolean
    doc: Keep unextended BAM files if using single-end reads
    inputBinding:
      position: 101
      prefix: --keep_original_bams
  - id: len
    type:
      - 'null'
      - int
    doc: Length to extend reads to
    default: 300
    inputBinding:
      position: 101
      prefix: --len
  - id: load_defaults
    type:
      - 'null'
      - string
    doc: Load this saved set of defaults (use 'list' to list current saved 
      options)
    inputBinding:
      position: 101
      prefix: --load_defaults
  - id: markdup
    type:
      - 'null'
      - boolean
    doc: 'Mark PCR duplicate reads with samtools. *NB: for ChIP-seq alignment only;
      do NOT use with DamID data.'
    inputBinding:
      position: 101
      prefix: --markdup
  - id: max_norm_value
    type:
      - 'null'
      - float
    doc: Maximum log2 value to limit normalisation search at (default = +5)
    default: 5.0
    inputBinding:
      position: 101
      prefix: --max_norm_value
  - id: method_subtract
    type:
      - 'null'
      - boolean
    doc: Output values are (Dam_fusion - Dam) instead of log2(Dam_fusion/Dam) 
      (not recommended)
    inputBinding:
      position: 101
      prefix: --method_subtract
  - id: min_norm_value
    type:
      - 'null'
      - float
    doc: Minimum log2 value to limit normalisation search at (default = -5)
    default: -5.0
    inputBinding:
      position: 101
      prefix: --min_norm_value
  - id: n
    type:
      - 'null'
      - boolean
    doc: Dry-run only; do not process files
    inputBinding:
      position: 101
      prefix: --n
  - id: ncbam
    type:
      - 'null'
      - boolean
    doc: Don't clobber BAM files, skip if existing
    inputBinding:
      position: 101
      prefix: --ncbam
  - id: no_file_filters
    type:
      - 'null'
      - boolean
    doc: Do not trim filenames for output
    default: true
    inputBinding:
      position: 101
      prefix: --no_file_filters
  - id: nogroups
    type:
      - 'null'
      - boolean
    doc: Do not try to group experiments and replicates, and just process all 
      samples as per v1.5.3 and earlier
    inputBinding:
      position: 101
      prefix: --nogroups
  - id: norm_method
    type:
      - 'null'
      - string
    doc: 'Normalisation method to use; options are: kde: use kernel density estimation
      of log2 GATC fragment ratio (default) rpm: use readcounts per million reads
      (not recommended for most use cases) rawbins: process raw counts with external
      normalisation command (set with --rawbins_cmd)'
    default: kde
    inputBinding:
      position: 101
      prefix: --norm_method
  - id: norm_override
    type:
      - 'null'
      - float
    doc: Normalise by this amount instead
    inputBinding:
      position: 101
      prefix: --norm_override
  - id: norm_steps
    type:
      - 'null'
      - int
    doc: Number of points in normalisation routine (default = 300)
    default: 300
    inputBinding:
      position: 101
      prefix: --norm_steps
  - id: out_name
    type:
      - 'null'
      - string
    doc: Use this as the fusion-protein name when saving the final ratio
    inputBinding:
      position: 101
      prefix: --out_name
  - id: output_format
    type:
      - 'null'
      - string
    doc: Output tracks in this format [gff/bedgraph]
    default: bedgraph
    inputBinding:
      position: 101
      prefix: --output_format
  - id: paired
    type:
      - 'null'
      - boolean
    doc: 'Process paired-end reads (deprecated: PE/SE detection should happen automagically)'
    inputBinding:
      position: 101
      prefix: --paired
  - id: paired_match
    type:
      - 'null'
      - string
    doc: characters to search for that, directly in front of [1|2], that marks 
      paired-reads (regex format)
    default: R|_
    inputBinding:
      position: 101
      prefix: --paired_match
  - id: ps_debug
    type:
      - 'null'
      - boolean
    doc: Print extra debugging info on pseudocount calculations in log file
    inputBinding:
      position: 101
      prefix: --ps_debug
  - id: ps_factor
    type:
      - 'null'
      - float
    doc: Value of c in c*(reads/bins) formula for calculating pseudocounts 
      (default = 10)
    default: 10.0
    inputBinding:
      position: 101
      prefix: --ps_factor
  - id: pseudocounts
    type:
      - 'null'
      - float
    doc: 'Add this value of psuedocounts instead (default: optimal number of pseudocounts
      determined algorithmically)'
    inputBinding:
      position: 101
      prefix: --pseudocounts
  - id: q
    type:
      - 'null'
      - int
    doc: Cutoff average Q score for aligned reads
    default: 30
    inputBinding:
      position: 101
      prefix: --q
  - id: qscore1max
    type:
      - 'null'
      - float
    doc: max decile for normalising from Dam array
    default: 1.0
    inputBinding:
      position: 101
      prefix: --qscore1max
  - id: qscore1min
    type:
      - 'null'
      - float
    doc: min decile for normalising from Dam array
    default: 0.4
    inputBinding:
      position: 101
      prefix: --qscore1min
  - id: qscore2max
    type:
      - 'null'
      - float
    doc: max decile for normalising from fusion-protein array
    default: 0.9
    inputBinding:
      position: 101
      prefix: --qscore2max
  - id: rawbins_cmd
    type:
      - 'null'
      - string
    doc: Command to process raw tsv counts for --norm_method=rawbins Output of 
      command should be the normalisation factor (use with caution)
    inputBinding:
      position: 101
      prefix: --rawbins_cmd
  - id: remdups
    type:
      - 'null'
      - boolean
    doc: 'Remove PCR duplicate reads (implies --markdup). *NB: for ChIP-seq alignment
      only; do NOT use with DamID data.'
    inputBinding:
      position: 101
      prefix: --remdups
  - id: rep_prefix
    type:
      - 'null'
      - string
    doc: Common text string denoting replicates (e.g. if filename is 
      Dam_Exp1_n1.fq.gz, use _n as the rep_prefix)
    default: _n
    inputBinding:
      position: 101
      prefix: --rep_prefix
  - id: reset_defaults
    type:
      - 'null'
      - boolean
    doc: Delete user-defined parameters
    inputBinding:
      position: 101
      prefix: --reset_defaults
  - id: samtools_path
    type:
      - 'null'
      - string
    doc: path to samtools executable (leave blank if in path)
    inputBinding:
      position: 101
      prefix: --samtools_path
  - id: save_defaults
    type:
      - 'null'
      - string
    doc: Save runtime parameters as default (provide a name to differentiate 
      different genomes -- these can be loaded with 'load_defaults')
    inputBinding:
      position: 101
      prefix: --save_defaults
  - id: scores_as_rpm
    type:
      - 'null'
      - boolean
    doc: Calculate coverage scores (before normalisation) as reads per million 
      (RPM)
    default: true
    inputBinding:
      position: 101
      prefix: --scores_as_rpm
  - id: threads
    type:
      - 'null'
      - int
    doc: threads for bowtie2 to use
    default: 7
    inputBinding:
      position: 101
      prefix: --threads
  - id: unique
    type:
      - 'null'
      - boolean
    doc: Only map uniquely aligning reads
    inputBinding:
      position: 101
      prefix: --unique
  - id: write_raw
    type:
      - 'null'
      - boolean
    doc: Write TSV file with raw counts for each Dam, sample pair
    inputBinding:
      position: 101
      prefix: --write_raw
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/damidseq_pipeline:1.6.2--pl5321hdfd78af_0
stdout: damidseq_pipeline.out
