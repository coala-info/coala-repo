cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pvacseq
  - config_files
label: pvacseq_config_files
doc: "Retrieve more information for specific config file types\n\nTool homepage: https://github.com/griffithlab/pVAC-Seq"
inputs:
  - id: config_file_type
    type: string
    doc: The config file type to retrieve more information for (e.g., 
      additional_input_file_list)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pvacseq:4.0.10--py36_0
stdout: pvacseq_config_files.out
