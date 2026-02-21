cwlVersion: v1.2
class: CommandLineTool
baseCommand: scxa-plots
label: scxa-plots
doc: "A tool for generating plots for the Single Cell Expression Atlas (SCXA). Note:
  The provided input text contains system error logs regarding a container build failure
  ('no space left on device') rather than the standard help documentation, so no specific
  arguments could be extracted.\n\nTool homepage: https://github.com/ebi-gene-expression-group/scxa-plots"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scxa-plots:0.0.1--hdfd78af_1
stdout: scxa-plots.out
