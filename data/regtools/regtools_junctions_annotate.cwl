cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - regtools
  - junctions
  - annotate
label: regtools_junctions_annotate
doc: "Annotate the junctions.\n\nTool homepage: https://github.com/griffithlab/regtools"
inputs:
  - id: include_single_exon_genes
    type:
      - 'null'
      - boolean
    doc: "include single exon genes"
    inputBinding:
      position: 1
      prefix: -S
  - id: output_file
    type: string
    doc: "The file to write output to."
    inputBinding:
      position: 1
      prefix: -o
  - id: junctions
    type: File
    doc: "Junctions in BED12 format (junctions.bed)."
    inputBinding:
      position: 100
  - id: reference
    type: File
    doc: "Reference genome FASTA (ref.fa)."
    secondaryFiles:
      - pattern: .fai
        required: true
    inputBinding:
      position: 101
  - id: annotations
    type: File
    doc: "Gene annotations in GTF format."
    inputBinding:
      position: 102
outputs:
  - id: out_output_file
    type: File
    doc: "Annotated junctions"
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/regtools:1.0.0--h077b44d_5
