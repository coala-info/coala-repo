cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - capC-MAP
  - genomedigest
label: capc-map_genomedigest
doc: "Generate list of restriction enzyme fragments from a fasta file for the reference genome.\n\nTool homepage: https://capc-map.readthedocs.io/"
inputs:
  - id: input_fasta
    type: File
    doc: "input fasta file of genome"
    inputBinding:
      position: 1
      prefix: -i
  - id: enzyme_name
    type: string
    doc: "name of supported enzyme, or cutting sequence"
    inputBinding:
      position: 1
      prefix: -r
  - id: output_bed
    type: string
    doc: "output bed file of restriction fragments"
    inputBinding:
      position: 1
      prefix: -o
outputs:
  - id: fragments_bed
    type: File
    doc: "bed file of restriction fragments"
    outputBinding:
      glob: $(inputs.output_bed)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/capc-map:1.1.3--py36h8619c78_0
