cwlVersion: v1.2
class: CommandLineTool
baseCommand: mmult_cpgcdifenrich
label: mmult_cpgcdifenrich
doc: "The provided text does not contain help information or argument definitions;
  it is a system error message regarding a container execution failure (no space left
  on device).\n\nTool homepage: https://github.com/lijinbio/MMULT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmult:0.0.0.2--r40h8b68381_0
stdout: mmult_cpgcdifenrich.out
