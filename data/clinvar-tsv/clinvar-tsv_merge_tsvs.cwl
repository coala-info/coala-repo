cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - clinvar_tsv
  - merge_tsvs
label: clinvar-tsv_merge_tsvs
doc: "Merge TSV file (result: one per VCV)\n\nTool homepage: https://github.com/bihealth/clinvar-tsv"
inputs:
  - id: input_tsv
    type: File
    doc: Path to input TSV file (plain text, sorted so that rows of one VCV are 
      adjacent).
    inputBinding:
      position: 101
      prefix: --input-tsv
  - id: output_tsv
    type: string
    doc: Path to output TSV file.
    inputBinding:
      position: 101
      prefix: --output-tsv
  - id: clinvar_version
    type: string
    doc: String to put as clinvar version
    inputBinding:
      position: 101
      prefix: --clinvar-version
outputs:
  - id: output
    type: File
    doc: Merged TSV file, one row per VCV
    outputBinding:
      glob: $(inputs.output_tsv)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clinvar-tsv:0.6.3--pyhdfd78af_0
