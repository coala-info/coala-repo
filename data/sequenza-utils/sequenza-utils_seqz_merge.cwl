cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sequenza-utils
  - seqz_merge
label: sequenza-utils_seqz_merge
doc: 'Merge two seqz files.


  Tool homepage: http://sequenza-utils.readthedocs.org'
inputs:
  - id: seqz1
    type: File
    doc: First input file. If both input files contain the same line, the information in the first file is used.
    inputBinding:
      position: 1
      prefix: --seqz1
  - id: seqz2
    type: File
    doc: Second input file.
    inputBinding:
      position: 2
      prefix: --seqz2
  - id: output_name
    type: string
    doc: Output file. For gzip compressed output name the file ending in .gz. Default STDOUT.
    inputBinding:
      position: 3
      prefix: --output
  - id: tabix
    type:
      - 'null'
      - string
    doc: Path of the tabix binary. Default "tabix".
    inputBinding:
      position: 4
      prefix: --tabix
outputs:
  - id: output_seqz
    type: File
    doc: Merged seqz file.
    outputBinding:
      glob: $(inputs.output_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequenza-utils:3.0.0--py311h8ddd9a4_8
