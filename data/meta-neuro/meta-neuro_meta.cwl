cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - meta-neuro
  - meta
label: meta-neuro_meta
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error regarding container image acquisition (no
  space left on device).\n\nTool homepage: https://github.com/bagari/meta"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meta-neuro:2.0.1--py313h47f2c4e_0
stdout: meta-neuro_meta.out
