cwlVersion: v1.2
class: CommandLineTool
baseCommand: diapysef_convert_multipleMzML.py
label: diapysef_convert_multipleMzML.py
doc: "A tool to convert multiple mzML files. Note: The provided help text contains
  only system error messages regarding container execution and does not list specific
  command-line arguments.\n\nTool homepage: https://github.com/Roestlab/dia-pasef"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/diapysef:1.0.10--pyh7cba7a3_0
stdout: diapysef_convert_multipleMzML.py.out
