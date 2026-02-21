cwlVersion: v1.2
class: CommandLineTool
baseCommand: MethylExtract.pl
label: methylextract_MethylExtract.pl
doc: "MethylExtract is a tool for the analysis of DNA methylation from bisulfite sequencing
  data. (Note: The provided help text contained only system error messages regarding
  container execution and did not list specific command-line arguments).\n\nTool homepage:
  http://bioinfo2.ugr.es/MethylExtract/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methylextract:1.9.1--0
stdout: methylextract_MethylExtract.pl.out
