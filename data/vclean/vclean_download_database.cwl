cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vclean
  - download_database
label: vclean_download_database
doc: "Download the latest version of vClean's database\n\nTool homepage: https://github.com/TsumaR/vclean"
inputs:
  - id: destination
    type: Directory
    doc: Directory where the database will be downloaded to.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vclean:0.2.1--pyhdfd78af_0
stdout: vclean_download_database.out
