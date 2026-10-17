cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pvacseq
  - download_example_data
label: pvacseq_download_example_data
doc: "Download example data for pVACseq\n\nTool homepage: https://github.com/griffithlab/pVAC-Seq"
inputs:
  - id: destination_directory
    type: string
    doc: Directory for downloading example data (the tool writes an example_data
      folder inside it)
    inputBinding:
      position: 1
outputs:
  - id: example_data_dir
    type: Directory
    doc: Directory holding the copied example_data folder
    outputBinding:
      glob: $(inputs.destination_directory)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pvacseq:4.0.10--py36_0
stdout: pvacseq_download_example_data.out
