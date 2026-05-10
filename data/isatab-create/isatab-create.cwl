cwlVersion: v1.2
class: CommandLineTool
baseCommand: cli.py
label: isatab-create
doc: "Create ISA-Tab files from Galaxy JSON input.\n\nTool homepage: https://github.com/phnmnl/container-isatab-create"
inputs:
  - id: galaxy_parameters_file
    type: File
    doc: Path to JSON file containing input Galaxy JSON
    inputBinding:
      position: 101
      prefix: --galaxy_parameters_file
  - id: target_dir_path
    type: string
    doc: Output path to write
    inputBinding:
      position: 102
      prefix: --target_dir
outputs:
  - id: target_dir
    type: Directory
    doc: Output path to write
    outputBinding:
      glob: $(inputs.target_dir_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/isatab-create:v0.9.5_cv0.3.14
