cwlVersion: v1.2
class: CommandLineTool
baseCommand: isatab_validator
label: isatab-validator
doc: "Validates ISA-Tab files.\n\nTool homepage: https://github.com/ISA-tools/ISAValidatorWS"
inputs:
  - id: input_directory
    type: Directory
    doc: Path to the ISA-Tab directory to validate.
    inputBinding:
      position: 1
  - id: output_directory
    type: string
    doc: Path to the directory where validation reports will be saved.
    inputBinding:
      position: 2
outputs:
  - id: html_output_path
    type: File
    doc: Path to save the HTML validation report.
    outputBinding:
      glob: '*.out'
  - id: output_directory_dir
    type:
      - 'null'
      - Directory
    doc: Path to the directory where validation reports will be saved.
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/isatab-validator:phenomenal-v0.10.0_cv0.7.1.42
