cwlVersion: v1.2
class: CommandLineTool
baseCommand: chamois_annotate
label: chamois_annotate
doc: "Annotate BGC sequences with protein domains and gene features.\n\nTool homepage:
  https://chamois.readthedocs.io/"
inputs:
  - id: cds
    type:
      - 'null'
      - boolean
    doc: Use CDS features in the GenBank input as genes instead of running 
      Pyrodigal.
    inputBinding:
      position: 101
      prefix: --cds
  - id: disentangle
    type:
      - 'null'
      - boolean
    doc: Remove overlapping domains by best P-value.
    inputBinding:
      position: 101
      prefix: --disentangle
  - id: hmm
    type:
      - 'null'
      - File
    doc: The path to the HMM file containing protein domains for annotation.
    inputBinding:
      position: 101
      prefix: --hmm
  - id: input
    type: File
    doc: The input BGC sequences to process.
    inputBinding:
      position: 101
      prefix: --input
outputs:
  - id: output
    type: File
    doc: The path where to write the sequence annotations in HDF5 format.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chamois:0.2.2--pyhdfd78af_0
