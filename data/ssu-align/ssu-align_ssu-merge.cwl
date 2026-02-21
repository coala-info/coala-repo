cwlVersion: v1.2
class: CommandLineTool
baseCommand: ssu-merge
label: ssu-align_ssu-merge
doc: "The provided text does not contain help information for the tool. It contains
  container runtime logs and a fatal error message regarding an OCI image build failure.\n
  \nTool homepage: http://eddylab.org/software/ssu-align/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ssu-align:0.1.1--h7b50bb2_7
stdout: ssu-align_ssu-merge.out
