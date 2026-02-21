cwlVersion: v1.2
class: CommandLineTool
baseCommand: mtbl-labs-uploader
label: mtbl-labs-uploader
doc: "A tool for uploading data to MTBL labs (description not provided in help text).\n
  \nTool homepage: https://github.com/phnmnl/container-mtbl-labs-uploader"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mtbl-labs-uploader:phenomenal-v0.1.1_cv0.5.16
stdout: mtbl-labs-uploader.out
