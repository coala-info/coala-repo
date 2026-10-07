cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - clinvar_tsv
  - parse_xml
label: clinvar-tsv_clinvar_tsv parse_xml
doc: "Parse ClinVar XML file into TSV format.\n\nTool homepage: https://github.com/bihealth/clinvar-tsv"
inputs:
  - id: clinvar_xml
    type: File
    doc: Path to Clinvar XML file.
    inputBinding:
      position: 101
      prefix: --clinvar-xml
  - id: max_rcvs
    type:
      - 'null'
      - int
    doc: Maximal number of RCV records to process.
    inputBinding:
      position: 101
      prefix: --max-rcvs
  - id: output_b37_small_path
    type: string
    inputBinding:
      position: 102
      prefix: --output-b37-small
  - id: output_b37_sv_path
    type: string
    inputBinding:
      position: 103
      prefix: --output-b37-sv
  - id: output_b38_small_path
    type: string
    inputBinding:
      position: 104
      prefix: --output-b38-small
  - id: output_b38_sv_path
    type: string
    inputBinding:
      position: 105
      prefix: --output-b38-sv
outputs:
  - id: output_b37_small
    type: File
    doc: Output path for small vars GRCh37 file.
    outputBinding:
      glob: $(inputs.output_b37_small_path)
  - id: output_b37_sv
    type: File
    doc: Output path for SV GRCh37 file.
    outputBinding:
      glob: $(inputs.output_b37_sv_path)
  - id: output_b38_small
    type: File
    doc: Output path for small vars GRCh38 file.
    outputBinding:
      glob: $(inputs.output_b38_small_path)
  - id: output_b38_sv
    type: File
    doc: Output path for SV GRCh38 file.
    outputBinding:
      glob: $(inputs.output_b38_sv_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clinvar-tsv:0.6.3--pyhdfd78af_0
