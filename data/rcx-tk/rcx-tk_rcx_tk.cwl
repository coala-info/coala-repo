cwlVersion: v1.2
class: CommandLineTool
baseCommand: rcx-tk
label: rcx-tk_rcx_tk
doc: "The provided text does not contain help information for the tool, but appears
  to be a container engine error log. No arguments or descriptions could be extracted
  from the input.\n\nTool homepage: https://github.com/RECETOX/rcx-tk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rcx-tk:0.1.0--pyhdfd78af_0
stdout: rcx-tk_rcx_tk.out
