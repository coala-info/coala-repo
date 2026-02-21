cwlVersion: v1.2
class: CommandLineTool
baseCommand: Trinotate
label: trinotate
doc: "Trinotate is a comprehensive annotation suite for functional annotation of transcriptomes,
  particularly de novo assembled transcriptomes. (Note: The provided text is an error
  log indicating a 'no space left on device' failure during container extraction and
  does not contain CLI help information.)\n\nTool homepage: https://trinotate.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trinotate:4.0.2--pl5321hdfd78af_0
stdout: trinotate.out
