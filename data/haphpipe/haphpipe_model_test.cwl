cwlVersion: v1.2
class: CommandLineTool
baseCommand: haphpipe model_test
label: haphpipe_model_test
doc: "ModelTest-NG wrapper for HAPHpipe\n\nTool homepage: https://github.com/gwcbi/haphpipe"
inputs:
  - id: asc_bias
    type:
      - 'null'
      - string
    doc: 'Ascertainment bias correction: lewis, felsenstein, or stamatakis'
    inputBinding:
      position: 101
      prefix: --asc_bias
  - id: data_type
    type:
      - 'null'
      - string
    doc: 'Data type: nt or aa'
    inputBinding:
      position: 101
      prefix: --data_type
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print commands but do not run
    default: false
    inputBinding:
      position: 101
      prefix: --debug
  - id: force
    type:
      - 'null'
      - boolean
    doc: force output overriding
    default: false
    inputBinding:
      position: 101
      prefix: --force
  - id: frequencies
    type:
      - 'null'
      - string
    doc: 'Candidate model frequencies: e (estimated) or f (fixed)'
    inputBinding:
      position: 101
      prefix: --frequencies
  - id: het
    type:
      - 'null'
      - string
    doc: 'Set rate heterogeneity: u (uniform), i (invariant sites +I), g (gamma +G),
      or f (both invariant sites and gamma +I+G)'
    inputBinding:
      position: 101
      prefix: --het
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: Keep temporary directory
    default: false
    inputBinding:
      position: 101
      prefix: --keep_tmp
  - id: models
    type:
      - 'null'
      - File
    doc: Text file with candidate models, one per line
    inputBinding:
      position: 101
      prefix: --models
  - id: ncpu
    type:
      - 'null'
      - int
    doc: Number of CPU to use
    default: 1
    inputBinding:
      position: 101
      prefix: --ncpu
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory
    default: .
    inputBinding:
      position: 101
      prefix: --outdir
  - id: outname
    type:
      - 'null'
      - string
    doc: Name for output file
    default: modeltest_results
    inputBinding:
      position: 101
      prefix: --outname
  - id: partitions
    type:
      - 'null'
      - File
    doc: Partitions file
    inputBinding:
      position: 101
      prefix: --partitions
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not write output to console (silence stdout and stderr)
    default: false
    inputBinding:
      position: 101
      prefix: --quiet
  - id: run_id
    type:
      - 'null'
      - string
    doc: Prefix for output files
    inputBinding:
      position: 101
      prefix: --run_id
  - id: schemes
    type:
      - 'null'
      - int
    doc: 'Number of predefined DNA substitution schemes evaluated: 3, 5, 7, 11, or
      203'
    inputBinding:
      position: 101
      prefix: --schemes
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed for random number generator
    inputBinding:
      position: 101
      prefix: --seed
  - id: seqs
    type:
      - 'null'
      - File
    doc: Alignment in FASTA or PHYLIP format
    inputBinding:
      position: 101
      prefix: --seqs
  - id: template
    type:
      - 'null'
      - string
    doc: 'Set candidate models according to a specified tool: raxml, phyml, mrbayes,
      or paup'
    inputBinding:
      position: 101
      prefix: --template
  - id: topology
    type:
      - 'null'
      - string
    doc: 'Starting topology: ml, mp, fixed-ml-jc, fixed-ml-gtr, fixed-mp, random,
      or user'
    inputBinding:
      position: 101
      prefix: --topology
  - id: utree
    type:
      - 'null'
      - File
    doc: User-defined starting tree
    inputBinding:
      position: 101
      prefix: --utree
outputs:
  - id: logfile
    type:
      - 'null'
      - File
    doc: Name for log file (output)
    outputBinding:
      glob: $(inputs.logfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haphpipe:1.0.3--py_0
