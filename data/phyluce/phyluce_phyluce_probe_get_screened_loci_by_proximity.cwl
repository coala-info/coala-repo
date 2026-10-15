cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyluce_probe_get_screened_loci_by_proximity
label: phyluce_phyluce_probe_get_screened_loci_by_proximity
doc: "Given a FASTA file of properly formatted sequences (and header), screen for\
  \ distance\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: input_file
    type: File
    doc: The FASTA file of input sequences
    inputBinding:
      prefix: --input
  - id: output_path
    type: string
    doc: The output FASTA file of filtered sequences
    inputBinding:
      prefix: --output
  - id: distance
    type:
      - 'null'
      - int
    doc: The minimum distance on which to filter
    inputBinding:
      prefix: --distance
  - id: length
    type:
      - 'null'
      - int
    doc: The minimum length of sequences to filter
    inputBinding:
      prefix: --length
outputs:
  - id: output
    type: File
    doc: The FASTA file of filtered sequences.
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
