cwlVersion: v1.2
class: CommandLineTool
baseCommand: scikits-datasmooth
label: scikits-datasmooth
doc: "The provided text does not contain help information or a description of the
  tool; it contains error messages related to a failed container execution.\n\nTool
  homepage: https://github.com/jjstickel/scikit-datasmooth/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scikits-datasmooth:0.7.1--pyh24bf2e0_0
stdout: scikits-datasmooth.out
