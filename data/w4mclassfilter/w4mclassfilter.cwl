cwlVersion: v1.2
class: CommandLineTool
baseCommand: w4mclassfilter
label: w4mclassfilter
doc: "A tool for filtering classes in Workflow4Metabolomics (W4M) datasets. Note:
  The provided text contains container build logs and error messages rather than command-line
  help documentation, so no arguments could be extracted.\n\nTool homepage: https://github.com/HegemanLab/w4mclassfilter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/w4mclassfilter:0.98.19--r44hdfd78af_5
stdout: w4mclassfilter.out
