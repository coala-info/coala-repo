cwlVersion: v1.2
class: CommandLineTool
baseCommand: cyvcf
label: cyvcf
doc: "The provided text does not contain help information or usage instructions; it
  is a system error log indicating a failure to pull or build the container image
  due to insufficient disk space.\n\nTool homepage: https://github.com/brentp/cyvcf2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cyvcf:0.8.0--py36_0
stdout: cyvcf.out
