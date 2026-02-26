cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mikrokondo-tools
  - download
label: mikrokondo-tools_download
doc: "Download a external file for use in mikrokondo. This script only downloads\n\
  the file and will not untar or unzip them.\n\nTool homepage: https://pypi.org/project/mikrokondo-tools"
inputs:
  - id: file
    type: string
    doc: Pick an option from the list to download
    inputBinding:
      position: 101
      prefix: --file
  - id: output
    type:
      - 'null'
      - Directory
    doc: An existing directory to download files to.
    default: /
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mikrokondo-tools:0.0.1rc0--pyhdfd78af_0
stdout: mikrokondo-tools_download.out
