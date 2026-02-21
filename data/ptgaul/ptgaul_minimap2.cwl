cwlVersion: v1.2
class: CommandLineTool
baseCommand: ptgaul_minimap2
label: ptgaul_minimap2
doc: "The provided text does not contain help information for the tool, but appears
  to be a container runtime error log.\n\nTool homepage: https://github.com/Bean061/ptgaul"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ptgaul:1.0.5--pyhdfd78af_1
stdout: ptgaul_minimap2.out
