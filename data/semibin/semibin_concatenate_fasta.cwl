cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - SemiBin2
  - concatenate_fasta
label: semibin_concatenate_fasta
doc: 'Concatenate fasta files for multi-sample binning.


  Tool homepage: https://github.com/BigDataBiology/SemiBin'
inputs:
  - id: input_fasta
    type:
      type: array
      items: File
    doc: Path to the input fasta file.
    inputBinding:
      position: 1
      prefix: --input-fasta
  - id: output
    type: string
    doc: Output directory (will be created if non-existent)
    inputBinding:
      position: 1
      prefix: --output
  - id: min_len
    type:
      - 'null'
      - int
    doc: Discard sequences below this length (default:0)
    inputBinding:
      position: 1
      prefix: --min-len
  - id: compression
    type:
      - 'null'
      - string
    doc: 'Compression type for the output files (accepted values: gz [default]/xz/bz2/none).'
    inputBinding:
      position: 1
      prefix: --compression
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 1
      prefix: --verbose
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet output
    inputBinding:
      position: 1
      prefix: --quiet
  - id: separator
    type:
      - 'null'
      - string
    doc: Used when multiple samples binning to separate sample name and contig name
      (Default is :).
    inputBinding:
      position: 1
      prefix: --separator
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/semibin:2.2.1--pyhdfd78af_0
