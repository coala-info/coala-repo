cwlVersion: v1.2
class: CommandLineTool
baseCommand: findMotifsGenome.pl
label: homer_findMotifsGenome.pl
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to build a container image due to insufficient disk space.\n
  \nTool homepage: http://homer.ucsd.edu/homer/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/homer:5.1--pl5262h9948957_0
stdout: homer_findMotifsGenome.pl.out
