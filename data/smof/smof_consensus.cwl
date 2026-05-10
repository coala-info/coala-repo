cwlVersion: v1.2
class: CommandLineTool
baseCommand: smof
label: smof_consensus
doc: "Calculates the consensus sequence from a set of sequences.\n\nTool homepage:
  https://github.com/incertae-sedis/smof"
inputs:
  - id: generator
    type: string
    doc: A generator of sequences (e.g., a FASTA file).
    inputBinding:
      position: 1
  - id: transpose
    type:
      - 'null'
      - boolean
    doc: Transpose the output matrix.
    inputBinding:
      position: 102
      prefix: --transpose
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 103
      prefix: --output-file
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Path to write the consensus sequence to.
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
