cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - clinvar_tsv
  - normalize_tsv
label: clinvar-tsv_normalize_tsv
doc: "Normalize the variants of a parsed ClinVar TSV file against a reference FASTA
  (help text says: Parse the Clinvar XML).\n\nTool homepage: https://github.com/bihealth/clinvar-tsv"
inputs:
  - id: reference
    type: File
    secondaryFiles:
      - .fai
    doc: Path to reference FASTA file
    inputBinding:
      position: 101
      prefix: --reference
  - id: input_tsv
    type: File
    doc: Path to input TSV file.
    inputBinding:
      position: 101
      prefix: --input-tsv
  - id: output_tsv
    type: string
    doc: Path to output TSV file.
    inputBinding:
      position: 101
      prefix: --output-tsv
outputs:
  - id: output
    type: File
    doc: Normalized TSV file
    outputBinding:
      glob: $(inputs.output_tsv)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clinvar-tsv:0.6.3--pyhdfd78af_0
