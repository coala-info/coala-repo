cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gtdbtk
  - export_msa
label: gtdbtk_export_msa
doc: "Export MSA from GTDB-Tk\n\nTool homepage: http://pypi.python.org/pypi/gtdbtk/"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: create intermediate files for debugging purposes
    default: false
    inputBinding:
      position: 101
      prefix: --debug
  - id: domain
    type: string
    doc: domain to export
    inputBinding:
      position: 101
      prefix: --domain
outputs:
  - id: output
    type: File
    doc: output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtdbtk:2.6.1--pyh1f0d9b5_2
