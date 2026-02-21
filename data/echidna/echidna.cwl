cwlVersion: v1.2
class: CommandLineTool
baseCommand: echidna
label: echidna
doc: "The provided text does not contain help information for the tool 'echidna';
  it contains system logs and a fatal error message regarding a container runtime
  environment.\n\nTool homepage: https://github.com/azizilab/echidna"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/echidna:1.0.3--pyhdfd78af_0
stdout: echidna.out
