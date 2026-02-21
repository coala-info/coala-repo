cwlVersion: v1.2
class: CommandLineTool
baseCommand: optbuild
label: optbuild
doc: "The provided text does not contain help information or usage instructions; it
  consists of system logs and a fatal error message regarding container image conversion
  and disk space.\n\nTool homepage: http://noble.gs.washington.edu/~mmh1/software/optbuild/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/optbuild:0.2.1--pyh864c0ab_1
stdout: optbuild.out
