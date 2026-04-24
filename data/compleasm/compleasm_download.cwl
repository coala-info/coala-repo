cwlVersion: v1.2
class: CommandLineTool
baseCommand: compleasm download
label: compleasm_download
doc: "Download BUSCO lineages.\n\nTool homepage: https://github.com/huangnengCSU/compleasm"
inputs:
  - id: lineages
    type:
      type: array
      items: string
    doc: Specify the names of the BUSCO lineages to be downloaded. (e.g. 
      eukaryota, primates, saccharomycetes etc.)
    inputBinding:
      position: 1
  - id: library_path
    type:
      - 'null'
      - Directory
    doc: The destination folder to store the downloaded lineage files.If not 
      specified, a folder named "mb_downloads" will be created on the current 
      running path.
    inputBinding:
      position: 102
      prefix: --library_path
  - id: odb
    type:
      - 'null'
      - string
    doc: OrthoDB version
    inputBinding:
      position: 102
      prefix: --odb
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/compleasm:0.2.7--pyh7e72e81_1
stdout: compleasm_download.out
