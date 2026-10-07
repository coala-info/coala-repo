cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - clinvar-this
  - data
  - gene-phenotype-links
label: clinvar-this_data_gene_phenotype_links
doc: "Create links between gene and phenotype.\n\nTool homepage: https://github.com/bihealth/clinvar-this"
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
  - id: needs_hpo_terms
    type:
      - 'null'
      - boolean
    doc: 'Whether to filter to rows with HPO terms (default: true)'
    inputBinding:
      position: 101
      prefix: --needs-hpo-terms
  - id: no_needs_hpo_terms
    type:
      - 'null'
      - boolean
    doc: Do not filter to rows with HPO terms
    inputBinding:
      position: 101
      prefix: --no-needs-hpo-terms
outputs:
  - id: output
    type: File
    doc: Output JSONL file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clinvar-this:0.18.5--pyhdfd78af_0
