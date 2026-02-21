cwlVersion: v1.2
class: CommandLineTool
baseCommand: ms2rescore
label: ms2rescore
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a container runtime failure (no space left
  on device).\n\nTool homepage: https://compomics.github.io/projects/ms2rescore/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ms2rescore:3.2.0.post1--pyhdfd78af_0
stdout: ms2rescore.out
