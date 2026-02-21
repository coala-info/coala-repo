cwlVersion: v1.2
class: CommandLineTool
baseCommand: findMotifs.pl
label: homer_findMotifs.pl
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to build or run the container image (no space left on device).\n
  \nTool homepage: http://homer.ucsd.edu/homer/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/homer:5.1--pl5262h9948957_0
stdout: homer_findMotifs.pl.out
