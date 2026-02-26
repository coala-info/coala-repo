cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deeparg
  - download_data
label: deeparg_download_data
doc: "Download data for deeparg\n\nTool homepage: https://bitbucket.org/gusphdproj/deeparg-ss/"
inputs:
  - id: output_path
    type:
      - 'null'
      - Directory
    doc: Path to save the downloaded data
    inputBinding:
      position: 101
      prefix: --output-path
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deeparg:1.0.4--pyhdfd78af_0
stdout: deeparg_download_data.out
