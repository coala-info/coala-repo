cwlVersion: v1.2
class: CommandLineTool
label: isatab-validator
doc: "Validates ISA-Tab files and writes a JSON report and an HTML report. The container
  entrypoint is isatab_validator.py, which takes the ISA-Tab directory (or a zip archive),
  the JSON report path and the HTML report path as positional arguments.\n\nTool homepage:
  https://github.com/ISA-tools/ISAValidatorWS"
inputs:
  - id: input_isatab
    type:
      - Directory
      - File
    doc: ISA-Tab directory, or a zip archive of the ISA-Tab files
    inputBinding:
      position: 1
  - id: json_output_path
    type: string
    doc: Path to save the JSON validation report
    inputBinding:
      position: 2
  - id: html_output_path
    type: string
    doc: Path to save the HTML validation report
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: json_report
    type: File
    doc: JSON validation report
    outputBinding:
      glob: $(inputs.json_output_path)
  - id: html_report
    type: File
    doc: HTML validation report
    outputBinding:
      glob: $(inputs.html_output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/isatab-validator:phenomenal-v0.10.0_cv0.7.1.42
stdout: isatab-validator.out
