cwlVersion: v1.2
class: CommandLineTool
baseCommand: scTagger.py
label: sctagger_scTagger.py
doc: "The provided text does not contain help information for the tool. It contains
  system error logs related to a failed container build (no space left on device).\n
  \nTool homepage: https://github.com/vpc-ccg/sctagger"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sctagger:1.1.1--hdfd78af_0
stdout: sctagger_scTagger.py.out
