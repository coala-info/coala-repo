cwlVersion: v1.2
class: CommandLineTool
baseCommand: kf2vec
label: kf2vec
doc: "The provided text does not contain help information or usage instructions for
  kf2vec; it contains system error logs related to a container runtime failure (no
  space left on device).\n\nTool homepage: https://github.com/noraracht/kf2vec"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kf2vec:1.0.62--pyh5e193fb_0
stdout: kf2vec.out
