cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deeparg
  - download_data
label: deeparg_download_data
doc: "Download data for deeparg\n\nTool homepage: https://bitbucket.org/gusphdproj/deeparg-ss/"
inputs:
  - id: output_path
    type: string
    doc: 'Output directory where to download data [Default: deepARG instalation
      directory]'
    default: deeparg_data
    inputBinding:
      position: 101
      prefix: -o
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: data_dir
    type: Directory
    doc: Downloaded deepARG data (database, model, gg13 and bin folders)
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deeparg:1.0.4--pyhdfd78af_0
stdout: deeparg_download_data.out
