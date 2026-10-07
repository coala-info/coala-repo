cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dicey
  - index
label: dicey_index
doc: "Index a genome FASTA file\n\nTool homepage: https://github.com/gear-genomics/dicey"
inputs:
  - id: genome_fa_gz
    type: File
    doc: Input genome FASTA file (gzipped)
    inputBinding:
      position: 1
  - id: output_file_path
    type: string
    doc: output file
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file_path)
    secondaryFiles:
      - pattern: _check
        required: false
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dicey:0.3.4--h4d20210_0
