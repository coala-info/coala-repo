cwlVersion: v1.2
class: CommandLineTool
baseCommand: ProbabilityPlot
label: rnastructure_ProbabilityPlot
doc: "The provided text does not contain help information for the tool, but appears
  to be a container runtime error log. No arguments could be extracted.\n\nTool homepage:
  http://rna.urmc.rochester.edu/RNAstructure.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnastructure:6.5--hde5307d_0
stdout: rnastructure_ProbabilityPlot.out
