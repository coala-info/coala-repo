cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - variant_recoder
label: ensembl-vep_variant_recoder
doc: "Translate between variant identifiers and notations (rsID, HGVS genomic, transcript and protein, SPDI, VCF) using the Ensembl database.\n\nTool homepage: https://www.ensembl.org/info/docs/tools/vep/recoder/index.html"
inputs:
  - id: input_data
    type:
      - 'null'
      - string
    doc: "Input as string (for example an rsID, an HGVS string or a VCF-like string)"
    inputBinding:
      position: 101
      prefix: --input_data
  - id: input_file
    type:
      - 'null'
      - File
    doc: "Input file"
    inputBinding:
      position: 101
      prefix: --input_file
  - id: species
    type:
      - 'null'
      - string
    doc: "Species to use [default: \"human\"]"
    inputBinding:
      position: 101
      prefix: --species
  - id: pretty
    type:
      - 'null'
      - boolean
    doc: "Print prettified JSON"
    inputBinding:
      position: 101
      prefix: --pretty
outputs:
  - id: stdout
    type: stdout
    doc: Recoded variants as JSON
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ensembl-vep:115.2--pl5321h2a3209d_1
stdout: ensembl-vep_variant_recoder.out
