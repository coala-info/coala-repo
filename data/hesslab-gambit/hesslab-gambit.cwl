cwlVersion: v1.2
class: CommandLineTool
baseCommand: hesslab-gambit
label: hesslab-gambit
doc: "The provided text does not contain help information or a description of the
  tool; it contains error messages related to a container runtime failure (no space
  left on device).\n\nTool homepage: https://github.com/hesslab-gambit/gambit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hesslab-gambit:0.5.1--py39hbcbf7aa_1
stdout: hesslab-gambit.out
