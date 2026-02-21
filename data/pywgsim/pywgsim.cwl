cwlVersion: v1.2
class: CommandLineTool
baseCommand: pywgsim
label: pywgsim
doc: "A tool for simulating whole genome sequencing reads. (Note: The provided text
  contains system error messages from a container runtime and does not include the
  tool's help documentation or argument list.)\n\nTool homepage: https://github.com/ialbert/pywgsim"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pywgsim:0.6.0--py310h397c9d8_0
stdout: pywgsim.out
