cwlVersion: v1.2
class: CommandLineTool
baseCommand: chexalign_chexalign.jar
label: chexalign_chexalign.jar
doc: "The provided text does not contain help information for the tool, but rather
  error logs related to a container build failure (no space left on device).\n\nTool
  homepage: https://github.com/seqcode/chexalign"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chexalign:0.12--hdfd78af_1
stdout: chexalign_chexalign.jar.out
