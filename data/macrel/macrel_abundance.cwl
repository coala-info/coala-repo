cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - macrel
  - abundance
label: macrel_abundance
doc: "Map reads to a reference peptide FASTA file with Paladin and report AMP abundance profiles.\n\nTool homepage: https://github.com/BigDataBiology/macrel"
inputs:
  - id: reads1
    type: File
    doc: "Path to the first (or single-end) read file (FASTQ)"
    inputBinding:
      position: 102
      prefix: --reads1
  - id: reads2
    type:
      - 'null'
      - File
    doc: "Path to the second read file (FASTQ) for paired-end data"
    inputBinding:
      position: 102
      prefix: --reads2
  - id: fasta_file
    type: File
    doc: "path to the reference peptide FASTA file (can be gzipped)"
    inputBinding:
      position: 102
      prefix: --fasta
  - id: output_dir
    type: string
    default: "macrel_out"
    doc: "path to the output directory (must not exist yet)"
    inputBinding:
      position: 102
      prefix: --output
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use"
    inputBinding:
      position: 102
      prefix: --threads
  - id: outtag
    type:
      - 'null'
      - string
    doc: "Set output tag (prefix of the output file names; default: macrel.out)"
    inputBinding:
      position: 102
      prefix: --tag
  - id: force
    type:
      - 'null'
      - boolean
    doc: "Overwrite the output folder if it already exists"
    inputBinding:
      position: 102
      prefix: --force
  - id: tmpdir
    type:
      - 'null'
      - string
    doc: "Temporary directory to use (default: $TMPDIR in the environment or /tmp)"
    inputBinding:
      position: 102
      prefix: --tmpdir
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Print debug information"
    inputBinding:
      position: 102
      prefix: --verbose
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Print only errors"
    inputBinding:
      position: 102
      prefix: --quiet
  - id: log_file
    type:
      - 'null'
      - string
    doc: "Path to the output logfile"
    inputBinding:
      position: 102
      prefix: --log-file
  - id: log_append
    type:
      - 'null'
      - boolean
    doc: "If set, then the log file is appended to (default: overwrite existing file)"
    inputBinding:
      position: 102
      prefix: --log-append
outputs:
  - id: output
    type: Directory
    doc: "Macrel output directory"
    outputBinding:
      glob: $(inputs.output_dir)
  - id: log
    type:
      - 'null'
      - File
    doc: "Log file"
    outputBinding:
      glob: $(inputs.log_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macrel:1.6.0--pyh7e72e81_1
