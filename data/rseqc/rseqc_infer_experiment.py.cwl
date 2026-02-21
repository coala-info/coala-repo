cwlVersion: v1.2
class: CommandLineTool
baseCommand: infer_experiment.py
label: rseqc_infer_experiment.py
doc: "The provided text does not contain help information for the tool; it contains
  container environment logs and a fatal error message regarding an OCI image build
  failure.\n\nTool homepage: https://rseqc.sourceforge.net"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
stdout: rseqc_infer_experiment.py.out
