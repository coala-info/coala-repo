cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rgi
  - tab
label: rgi_rgi_tab
doc: "Creates a tab-delimited file from an RGI JSON result file.\n\nTool homepage: https://card.mcmaster.ca"
inputs:
  - id: afile
    type: File
    doc: must be a rgi json result file
    inputBinding:
      position: 101
      prefix: --afile
outputs:
  - id: tab_file
    type: File
    doc: Tab-delimited table written next to the input (input name with .txt)
    outputBinding:
      glob: $(inputs.afile.nameroot).txt
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.afile)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rgi:6.0.5--pyh05cac1d_0
