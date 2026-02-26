cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tooldistillator.py
  - refseqmasher
label: tooldistillator_refseqmasher
doc: "Extract information from output(s) of refseqmasher (OUTPUT.tsv)\n\nTool homepage:
  https://gitlab.com/ifb-elixirfr/abromics"
inputs:
  - id: report
    type: File
    doc: Path to report(s)
    inputBinding:
      position: 1
  - id: analysis_software_version
    type:
      - 'null'
      - string
    doc: refseqmasher version number for refseqmasher
    inputBinding:
      position: 102
      prefix: --analysis_software_version
  - id: hid
    type:
      - 'null'
      - string
    doc: Historic ID to refseq result from Galaxy for refseqmasher
    inputBinding:
      position: 102
      prefix: --hid
  - id: reference_database_version
    type:
      - 'null'
      - string
    doc: DB version for refseqmasher
    inputBinding:
      position: 102
      prefix: --reference_database_version
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output location
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
