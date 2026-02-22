cwlVersion: v1.2
class: CommandLineTool
baseCommand: string-diff
label: perl-string-diff
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to pull or build the container image due to insufficient
  disk space.\n\nTool homepage: https://github.com/yappo/p5-String-Diff"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-string-diff:0.11--pl5321hdfd78af_0
stdout: perl-string-diff.out
