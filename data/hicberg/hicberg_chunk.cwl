cwlVersion: v1.2
class: CommandLineTool
baseCommand: hicberg chunk
label: hicberg_chunk
doc: "Chunk provided inputs in a desired number of pieces.\n\nTool homepage: https://github.com/sebgra/hicberg"
inputs:
  - id: input1
    type: string
    doc: First input
    inputBinding:
      position: 1
  - id: input2
    type: string
    doc: Second input
    inputBinding:
      position: 2
  - id: chunks
    type:
      - 'null'
      - int
    doc: Number of chunks to generate.
    default: 2
    inputBinding:
      position: 103
      prefix: --chunks
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: Output folder to save the chunks.
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicberg:1.0.1--py312hcf36b3e_0
stdout: hicberg_chunk.out
