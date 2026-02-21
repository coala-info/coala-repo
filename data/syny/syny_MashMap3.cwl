cwlVersion: v1.2
class: CommandLineTool
baseCommand: syny_MashMap3
label: syny_MashMap3
doc: "The provided text does not contain help information or usage instructions for
  the tool; it consists of container runtime logs and a fatal error message regarding
  an OCI image build failure.\n\nTool homepage: https://github.com/PombertLab/SYNY"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/syny:1.3.1--py312pl5321h7e72e81_0
stdout: syny_MashMap3.out
