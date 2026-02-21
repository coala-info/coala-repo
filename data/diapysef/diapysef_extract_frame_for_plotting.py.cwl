cwlVersion: v1.2
class: CommandLineTool
baseCommand: diapysef_extract_frame_for_plotting.py
label: diapysef_extract_frame_for_plotting.py
doc: "Extract frames for plotting from diapysef data. (Note: The provided help text
  contains only system error messages and no argument information.)\n\nTool homepage:
  https://github.com/Roestlab/dia-pasef"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/diapysef:1.0.10--pyh7cba7a3_0
stdout: diapysef_extract_frame_for_plotting.py.out
