cwlVersion: v1.2
class: CommandLineTool
baseCommand: mea_mea_eval
label: mea_mea_eval
doc: "A tool for evaluating Maximum Expected Accuracy (MEA) predictions. (Note: The
  provided text contains system error logs rather than help documentation, so no arguments
  could be extracted.)\n\nTool homepage: http://www.bioinf.uni-leipzig.de/Software/mea/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mea:0.6.4--h9948957_10
stdout: mea_mea_eval.out
