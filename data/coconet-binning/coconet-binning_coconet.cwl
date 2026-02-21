cwlVersion: v1.2
class: CommandLineTool
baseCommand: coconet
label: coconet-binning_coconet
doc: "CoCoNet: Contig binning with CO-occurrence NETworks. (Note: The provided help
  text contains only container runtime error messages and does not list command-line
  arguments.)\n\nTool homepage: https://github.com/Puumanamana/CoCoNet"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coconet-binning:1.1.0--py_0
stdout: coconet-binning_coconet.out
