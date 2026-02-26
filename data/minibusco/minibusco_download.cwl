cwlVersion: v1.2
class: CommandLineTool
baseCommand: minibusco_download
label: minibusco_download
doc: "Download BUSCO lineage datasets.\n\nTool homepage: https://github.com/huangnengCSU/minibusco"
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
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minibusco:0.2.1--pyh7cba7a3_0
stdout: minibusco_download.out
