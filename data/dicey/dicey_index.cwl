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
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dicey:0.3.4--h4d20210_0
