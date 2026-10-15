cwlVersion: v1.2
class: CommandLineTool
baseCommand: xerxes
label: poseidon-xerxes_fstats
doc: 'Compute f-statistics on groups and invidiuals within and across Poseidon packages


  Tool homepage: https://poseidon-framework.github.io/#/'
arguments:
  - position: 50
    valueFrom: fstats
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
  - id: stat
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --stat
    doc: A summary statistic to compute, for example F4(a,b,c,d), F3(a,b,c), F3star(a,b,c),
      F2(a,b), PWM(a,b), FST(a,b) or Het(a). Can be given multiple times.
    inputBinding:
      position: 100
  - id: stat_config
    type:
      - 'null'
      - File
    doc: A yaml file with the F-statistics and group configurations.
    inputBinding:
      position: 100
      prefix: --statConfig
  - id: stat_file
    type:
      - 'null'
      - File
    doc: A file with F-statistics specified as for --stat, one line per statistic
      and no new-line at the end.
    inputBinding:
      position: 100
      prefix: --statFile
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
  - id: table_out_file
    type:
      - 'null'
      - string
    doc: A file to which results are written as tab-separated file.
    inputBinding:
      position: 100
      prefix: --tableOutFile
  - id: block_table_file
    type:
      - 'null'
      - string
    doc: A file to which the per-block results are written as tab-separated file.
    inputBinding:
      position: 100
      prefix: --blockTableFile
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Log messages written by the tool
  - id: table_out
    type:
      - 'null'
      - File
    doc: Result table written with --tableOutFile.
    outputBinding:
      glob: $(inputs.table_out_file)
  - id: block_table
    type:
      - 'null'
      - File
    doc: Per-block result table written with --blockTableFile.
    outputBinding:
      glob: $(inputs.block_table_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poseidon-xerxes:1.0.1.1--hf48d1a7_0
stdout: poseidon-xerxes_fstats.out
stderr: poseidon-xerxes_fstats.err
