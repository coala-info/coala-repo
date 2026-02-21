cwlVersion: v1.2
class: CommandLineTool
baseCommand: vambcore
label: vambcore
doc: "The provided text does not contain help information for vambcore; it contains
  container runtime logs and a fatal error message regarding image retrieval.\n\n
  Tool homepage: https://github.com/jakobnissen/vambcore"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vambcore:0.1.2--py311hb6b3792_1
stdout: vambcore.out
