cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mikrokondo-tools
  - download
label: mikrokondo-tools_download
doc: "Download an external file for use in mikrokondo. This script only downloads the file and will not\
  \ untar or unzip it.\n\nTool homepage: https://pypi.org/project/mikrokondo-tools"
inputs:
  - id: file
    type: string
    doc: 'File to download: gtdb-sketch, gtdb-shigella, dehost, kraken-std, bakta-light or bakta-full.'
    inputBinding:
      position: 101
      prefix: --file
  - id: output
    type:
      - 'null'
      - string
    doc: Directory to download the file into (created in the working directory).
    default: mikrokondo_download
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: downloaded
    type: Directory
    doc: Directory holding the downloaded file.
    outputBinding:
      glob: $(inputs.output)
  - id: log
    type: stdout
    doc: Standard output.
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$({''class'': ''Directory'', ''basename'': inputs.output ? inputs.output : ''mikrokondo_download'',
          ''listing'': []})'
        writable: true
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mikrokondo-tools:0.0.1rc0--pyhdfd78af_0
stdout: mikrokondo-tools_download.out
