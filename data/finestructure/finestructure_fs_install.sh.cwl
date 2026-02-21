cwlVersion: v1.2
class: CommandLineTool
baseCommand: finestructure_fs_install.sh
label: finestructure_fs_install.sh
doc: "Installation script for fineStructure. (Note: The provided text contains execution
  logs and error messages rather than standard help documentation; no command-line
  arguments were identified in the input.)\n\nTool homepage: https://people.maths.bris.ac.uk/~madjl/finestructure/finestructure.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/finestructure:4.1.1--pl5321hdfd78af_0
stdout: finestructure_fs_install.sh.out
