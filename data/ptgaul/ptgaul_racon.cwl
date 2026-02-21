cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ptgaul
  - racon
label: ptgaul_racon
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container execution or build process.\n\nTool homepage:
  https://github.com/Bean061/ptgaul"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ptgaul:1.0.5--pyhdfd78af_1
stdout: ptgaul_racon.out
