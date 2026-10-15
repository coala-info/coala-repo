cwlVersion: v1.2
class: CommandLineTool
baseCommand: xerxes
label: poseidon-xerxes_ras
doc: 'Compute RAS statistics on groups and individuals within and across Poseidon
  packages


  Tool homepage: https://poseidon-framework.github.io/#/'
arguments:
  - position: 50
    valueFrom: ras
inputs:
  - id: log_mode
    type:
      - 'null'
      - string
    doc: 'How information should be reported: NoLog, SimpleLog, DefaultLog, ServerLog
      or VerboseLog. (default: DefaultLog)'
    inputBinding:
      position: 1
      prefix: --logMode
  - id: err_length
    type:
      - 'null'
      - string
    doc: 'After how many characters should a potential error message be truncated.
      "Inf" for no truncation. (default: CharCount 1500)'
    inputBinding:
      position: 2
      prefix: --errLength
  - id: in_plink_pop_name
    type:
      - 'null'
      - string
    doc: 'Where to read the population/group name from the FAM file in Plink-format:
      asFamily (default) | asPhenotype | asBoth.'
    inputBinding:
      position: 3
      prefix: --inPlinkPopName
  - id: base_dir
    type: Directory
    doc: A base directory to search for Poseidon packages.
    inputBinding:
      position: 100
      prefix: --baseDir
  - id: jackknife
    type:
      - 'null'
      - string
    doc: Jackknife setting. An integer defines the block size in SNPs; "CHR" defines
      blocks as entire chromosomes. The default is 5000 SNPs.
    inputBinding:
      position: 100
      prefix: --jackknife
  - id: exclude_chroms
    type:
      - 'null'
      - string
    doc: Comma-separated list of chromosome names to exclude. Defaults to X, Y, MT,
      chrX, chrY, chrMT, 23, 24, 90.
    inputBinding:
      position: 100
      prefix: --excludeChroms
  - id: pop_config_file
    type: File
    doc: A yaml file containing the population configuration.
    inputBinding:
      position: 100
      prefix: --popConfigFile
  - id: min_ac
    type:
      - 'null'
      - int
    doc: A minimal allele-count cutoff for the RAS statistics.
    inputBinding:
      position: 100
      prefix: --minAC
  - id: min_freq
    type:
      - 'null'
      - float
    doc: A minimal allele-frequency cutoff for the RAS statistics.
    inputBinding:
      position: 100
      prefix: --minFreq
  - id: no_min_freq
    type:
      - 'null'
      - boolean
    doc: Switch off the minimum allele frequency filter.
    inputBinding:
      position: 100
      prefix: --noMinFreq
  - id: max_ac
    type:
      - 'null'
      - int
    doc: A maximal allele-count cutoff for the RAS statistics.
    inputBinding:
      position: 100
      prefix: --maxAC
  - id: max_freq
    type:
      - 'null'
      - float
    doc: A maximal allele-frequency cutoff for the RAS statistics.
    inputBinding:
      position: 100
      prefix: --maxFreq
  - id: no_max_freq
    type:
      - 'null'
      - boolean
    doc: Switch off the maximum allele frequency filter. This can help mimic Outgroup-F3.
    inputBinding:
      position: 100
      prefix: --noMaxFreq
  - id: max_missingness
    type:
      - 'null'
      - float
    doc: 'A maximal missingness for the right populations in the RAS statistics. (default:
      0.1)'
    inputBinding:
      position: 100
      prefix: --maxMissingness
  - id: block_table_file
    type:
      - 'null'
      - string
    doc: A file to which the per-block results are written as tab-separated file.
    inputBinding:
      position: 100
      prefix: --blockTableFile
  - id: f4_table_out_file
    type:
      - 'null'
      - string
    doc: A file to which F4 computations are written as tab-separated file.
    inputBinding:
      position: 100
      prefix: --f4TableOutFile
  - id: max_snps
    type:
      - 'null'
      - int
    doc: Stop after a maximum number of SNPs has been processed. Useful for short
      test runs.
    inputBinding:
      position: 100
      prefix: --maxSnps
  - id: no_transitions
    type:
      - 'null'
      - boolean
    doc: Skip transition SNPs and use only transversions.
    inputBinding:
      position: 100
      prefix: --noTransitions
  - id: bed_file
    type:
      - 'null'
      - File
    doc: An optional bed file that gives sites to be included in the analysis.
    inputBinding:
      position: 100
      prefix: --bedFile
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Log messages written by the tool
  - id: block_table
    type:
      - 'null'
      - File
    doc: Per-block result table written with --blockTableFile.
    outputBinding:
      glob: $(inputs.block_table_file)
  - id: f4_table
    type:
      - 'null'
      - File
    doc: F4 table written with --f4TableOutFile.
    outputBinding:
      glob: $(inputs.f4_table_out_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poseidon-xerxes:1.0.1.1--hf48d1a7_0
stdout: poseidon-xerxes_ras.out
stderr: poseidon-xerxes_ras.err
