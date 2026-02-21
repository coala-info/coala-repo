cwlVersion: v1.2
class: CommandLineTool
baseCommand: rcx-tk
label: rcx-tk
doc: "The provided text does not contain help information or usage instructions; it
  is a log of a failed container build process. No arguments or descriptions could
  be extracted.\n\nTool homepage: https://github.com/RECETOX/rcx-tk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rcx-tk:0.1.0--pyhdfd78af_0
stdout: rcx-tk.out
