cwlVersion: v1.2
class: CommandLineTool
baseCommand: BuildDatabase
label: repeatmodeler_BuildDatabase
doc: "The provided text is a container execution error log and does not contain the
  help documentation for the tool. As a result, no arguments could be extracted.\n
  \nTool homepage: https://www.repeatmasker.org/RepeatModeler"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/repeatmodeler:2.0.7--pl5321hdfd78af_0
stdout: repeatmodeler_BuildDatabase.out
