cwlVersion: v1.2
class: CommandLineTool
baseCommand: cistrome_beta
label: cistrome_beta
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a failed container build/pull process.\n\nTool homepage:
  https://github.com/hanfeisun/BETA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cistrome-ceas:1.0.2b1--py27_1
stdout: cistrome_beta.out
