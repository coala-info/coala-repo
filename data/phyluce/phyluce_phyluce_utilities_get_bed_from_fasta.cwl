cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyluce_utilities_get_bed_from_fasta
label: phyluce_phyluce_utilities_get_bed_from_fasta
doc: "Get a BED from fasta file\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: input
    type: File
    doc: "The fasta file to parse"
    inputBinding:
      position: 1
      prefix: --input
  - id: output
    type: string
    doc: "The BED file to create"
    inputBinding:
      position: 1
      prefix: --output
  - id: locus_prefix
    type:
      - 'null'
      - string
    doc: "A prefix to add to each locus name"
    inputBinding:
      position: 1
      prefix: --locus-prefix
outputs:
  - id: output_bed
    type: File
    doc: "The BED file"
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
