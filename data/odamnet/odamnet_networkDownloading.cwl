cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - odamnet
  - networkDownloading
label: odamnet_networkDownloading
doc: "Download networks from NDEx using the UUID network. Create SIF (3 columns\n\
  \  with header) or GR (2 columns without header) network\n\nTool homepage: https://pypi.org/project/ODAMNet/1.1.0/"
inputs:
  - id: netuuid
    type: string
    doc: NDEx network ID
    inputBinding:
      position: 101
      prefix: --netUUID
  - id: network_file
    type: string
    doc: Network file name to write (.sif, or .gr with --simple True)
    inputBinding:
      position: 101
      prefix: --networkFile
  - id: simple
    type:
      - 'null'
      - string
    doc: Remove interaction column and header
    inputBinding:
      position: 101
      prefix: --simple
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: network
    type: File
    doc: Downloaded network file
    outputBinding:
      glob: $(inputs.network_file)
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/odamnet:1.1.0--pyhdfd78af_0
stdout: odamnet_networkDownloading.out
