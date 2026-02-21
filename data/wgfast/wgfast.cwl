cwlVersion: v1.2
class: CommandLineTool
baseCommand: wgfast
label: wgfast
doc: "The provided text does not contain help documentation or usage instructions
  for the tool. It consists of container runtime logs (Singularity/Apptainer) and
  a fatal error message regarding an OCI image build failure.\n\nTool homepage: https://github.com/jasonsahl/wgfast"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wgfast:1.0.4--py_0
stdout: wgfast.out
