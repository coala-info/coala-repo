cwlVersion: v1.2
class: CommandLineTool
baseCommand: pydownsampler
label: pydownsampler
doc: "A tool for downsampling (Note: The provided text contains container build logs
  and error messages rather than the tool's help documentation. No arguments could
  be extracted.)\n\nTool homepage: https://github.com/LindoNkambule/pydownsampler"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pydownsampler:1.0--py_0
stdout: pydownsampler.out
