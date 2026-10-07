cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - clinvar-this
  - data
  - acmg-class-by-freq
label: clinvar-this_data_acmg_class_by_freq
doc: "Create a report of ACMG classification by allele frequency from ClinVar JSONL
  records (help text says: Create links between gene and phenotype).\n\nTool homepage:
  https://github.com/bihealth/clinvar-this"
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
  - id: thresholds
    type:
      - 'null'
      - string
    doc: Frequency thresholds, comma-separated
    inputBinding:
      position: 101
      prefix: --thresholds
outputs:
  - id: output
    type: File
    doc: Output JSONL file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clinvar-this:0.18.5--pyhdfd78af_0
