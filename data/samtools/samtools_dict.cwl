cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- dict
label: samtools_dict
doc: 'Create a sequence dictionary file from a fasta file


  Tool homepage: https://github.com/samtools/samtools'
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
inputs:
- id: fasta_file
  type: File
  doc: Input FASTA file (optionally gzip compressed).
  inputBinding:
    position: 104
- id: assembly
  type:
  - 'null'
  - string
  doc: Assembly name (AS tag).
  inputBinding:
    position: 103
    prefix: --assembly
- id: alias
  type:
  - 'null'
  - boolean
  doc: Add AN tag by adding/removing 'chr'.
  inputBinding:
    position: 103
    prefix: --alias
- id: no_header
  type:
  - 'null'
  - boolean
  doc: Do not print @HD line.
  inputBinding:
    position: 103
    prefix: --no-header
- id: alt_file
  type:
  - 'null'
  - File
  doc: Add AH:* tag to alternate locus sequences listed in this file.
  inputBinding:
    position: 103
    prefix: --alt
- id: output_filename
  type: string
  doc: File to write the dict file to (-o).
  default: reference.dict
  inputBinding:
    position: 103
    prefix: -o
- id: species
  type:
  - 'null'
  - string
  doc: Species (SP tag).
  inputBinding:
    position: 103
    prefix: --species
- id: uri
  type:
  - 'null'
  - string
  doc: URI [file:///abs/path/to/file.fa].
  inputBinding:
    position: 103
    prefix: --uri
outputs:
- id: output
  type: File
  doc: Sequence dictionary.
  outputBinding:
    glob: $(inputs.output_filename)
