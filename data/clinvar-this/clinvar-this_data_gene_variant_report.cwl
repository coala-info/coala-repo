cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - clinvar-this
  - data
  - gene-variant-report
label: clinvar-this_data_gene_variant_report
doc: "Create a gene variant summary report.\n\nTool homepage: https://github.com/bihealth/clinvar-this"
inputs:
  - id: input_file
    type: File
    doc: ClinVar records in JSONL format (as written by xml-to-jsonl)
    inputBinding:
      position: 1
  - id: output_file
    type: string
    doc: Output JSONL file
    inputBinding:
      position: 2
outputs:
  - id: output
    type: File
    doc: Output JSONL file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clinvar-this:0.18.5--pyhdfd78af_0
