cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fgsv
  - FilterAndMerge
label: fgsv_FilterAndMerge
doc: "Filters and merges SVPileup output.\n\nTool homepage: https://github.com/fulcrumgenomics/fgsv"
inputs:
  - id: async_io
    type:
      - 'null'
      - boolean
    doc: Use asynchronous I/O where possible, e.g. for SAM and BAM files.
    inputBinding:
      position: 101
      prefix: --async-io
  - id: compression
    type:
      - 'null'
      - int
    doc: Default GZIP compression level, BAM compression level.
    inputBinding:
      position: 101
      prefix: --compression
  - id: input
    type: File
    doc: The input pileup file from SvPileup
    inputBinding:
      position: 101
      prefix: --input
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Minimum severity log-level to emit. Options: Debug, Info, Warning, Error,
      Fatal.'
    inputBinding:
      position: 101
      prefix: --log-level
  - id: min_post
    type:
      - 'null'
      - int
    doc: 'The minimum # of observations to output a site'
    inputBinding:
      position: 101
      prefix: --min-post
  - id: min_pre
    type:
      - 'null'
      - int
    doc: 'The minimum # of observations to examine an input site'
    inputBinding:
      position: 101
      prefix: --min-pre
  - id: sam_validation_stringency
    type:
      - 'null'
      - string
    doc: 'Validation stringency for SAM/BAM reading. Options: STRICT, LENIENT, SILENT.'
    inputBinding:
      position: 101
      prefix: --sam-validation-stringency
  - id: slop
    type:
      - 'null'
      - int
    doc: 'The maximum # bases between a breakend across adjacent sites'
    inputBinding:
      position: 101
      prefix: --slop
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Directory to use for temporary files.
    inputBinding:
      position: 101
      prefix: --tmp-dir
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: The output filtered and merged SvPileup file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgsv:0.2.1--hdfd78af_1
