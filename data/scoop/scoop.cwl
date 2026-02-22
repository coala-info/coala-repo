cwlVersion: v1.2
class: CommandLineTool
baseCommand: scoop
label: scoop
doc: "The provided text does not contain help information or a description for the
  tool 'scoop'. It appears to be a log of a failed container image conversion (Singularity/SIF)
  due to insufficient disk space.\n\nTool homepage: https://github.com/soravux/scoop"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scoop:0.7.2.0--pyhdfd78af_0
stdout: scoop.out
