cwlVersion: v1.2
class: CommandLineTool
baseCommand: shapeit
label: shapeit_bcftools
doc: "The provided text does not contain help information or usage instructions. It
  is a log of a failed container build/execution due to insufficient disk space.\n
  \nTool homepage: https://github.com/odelaneau/shapeit4"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shapeit:2.r837--h09b0a5c_1
stdout: shapeit_bcftools.out
