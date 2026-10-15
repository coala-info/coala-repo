cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - polypolish
  - polish
label: polypolish_polish
doc: "polish a long-read assembly using short-read alignments\n\nTool homepage: https://github.com/rrwick/Polypolish"
inputs:
  - id: assembly
    type: File
    doc: Assembly to polish (one file in FASTA format)
    inputBinding:
      position: 1
  - id: sam_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Short read alignments (one or more files in SAM format)
    inputBinding:
      position: 2
  - id: debug
    type:
      - 'null'
      - string
    doc: Optional file to store per-base information for debugging purposes
    inputBinding:
      position: 101
      prefix: --debug
  - id: fraction_invalid
    type:
      - 'null'
      - float
    doc: 'A base must make up less than this fraction of the read depth to be considered
      invalid [default: 0.2]'
    inputBinding:
      position: 101
      prefix: --fraction_invalid
  - id: fraction_valid
    type:
      - 'null'
      - float
    doc: 'A base must make up at least this fraction of the read depth to be considered
      valid [default: 0.5]'
    inputBinding:
      position: 101
      prefix: --fraction_valid
  - id: max_errors
    type:
      - 'null'
      - int
    doc: 'Ignore alignments with more than this many mismatches and indels [default:
      10]'
    inputBinding:
      position: 101
      prefix: --max_errors
  - id: min_depth
    type:
      - 'null'
      - int
    doc: 'A base must occur at least this many times in the pileup to be considered
      valid [default: 5]'
    inputBinding:
      position: 101
      prefix: --min_depth
  - id: careful
    type:
      - 'null'
      - boolean
    doc: Ignore any reads with multiple alignments
    inputBinding:
      position: 101
      prefix: --careful
outputs:
  - id: polished_assembly
    type: stdout
    doc: Polished assembly in FASTA format (standard output)
  - id: log
    type: stderr
    doc: Polypolish report (standard error)
  - id: debug_file
    type:
      - 'null'
      - File
    doc: Per-base debugging information
    outputBinding:
      glob: $(inputs.debug)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/polypolish:0.6.1--h3ab6199_0
stdout: polypolish_polish.fasta
stderr: polypolish_polish.log
