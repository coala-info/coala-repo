cwlVersion: v1.2
class: CommandLineTool
baseCommand: ptgaul_ptGAUL.sh
label: ptgaul_ptGAUL.sh
doc: "The provided text contains container runtime logs and a fatal error message
  rather than help documentation for the tool. As a result, no arguments or usage
  information could be extracted.\n\nTool homepage: https://github.com/Bean061/ptgaul"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ptgaul:1.0.5--pyhdfd78af_1
stdout: ptgaul_ptGAUL.sh.out
