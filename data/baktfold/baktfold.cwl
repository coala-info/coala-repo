cwlVersion: v1.2
class: CommandLineTool
baseCommand: baktfold
label: baktfold
doc: "Note: The provided text is a container build/execution error log and does not
  contain command-line help information or argument definitions.\n\nTool homepage:
  https://github.com/gbouras13/baktfold"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/baktfold:0.0.3--pyhdfd78af_0
stdout: baktfold.out
