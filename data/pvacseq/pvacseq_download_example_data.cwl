cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pvacseq
  - download_example_data
label: pvacseq_download_example_data
doc: "Download example data for pVACseq\n\nTool homepage: https://github.com/griffithlab/pVAC-Seq"
inputs:
  - id: destination_directory
    type: Directory
    doc: Directory for downloading example data
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pvacseq:4.0.10--py36_0
stdout: pvacseq_download_example_data.out
