cwlVersion: v1.2
class: CommandLineTool
baseCommand: samhaplotag
label: samhaplotag
doc: "The provided text contains container environment logs and a fatal error message
  regarding an OCI image fetch failure. It does not contain the help text or usage
  information for the 'samhaplotag' tool, so no arguments could be extracted.\n\n
  Tool homepage: https://github.com/wtsi-hpag/SamHaplotag"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samhaplotag:0.0.4--h9948957_4
stdout: samhaplotag.out
