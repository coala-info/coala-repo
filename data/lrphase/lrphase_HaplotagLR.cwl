cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lrphase
  - HaplotagLR
label: lrphase_HaplotagLR
doc: "The provided text does not contain help information or usage instructions. It
  contains system error messages related to a container runtime failure (no space
  left on device).\n\nTool homepage: https://github.com/Boyle-Lab/LRphase.git"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lrphase:1.1.2--pyhdfd78af_0
stdout: lrphase_HaplotagLR.out
