cwlVersion: v1.2
class: CommandLineTool
baseCommand: structureHarvester.py
label: structureharvester
doc: "A program to harvest and archive the results of STRUCTURE output files and implement
  the Evanno method.\n\nTool homepage: http://alumni.soe.ucsc.edu/~dearl/software/structureHarvester/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/structureharvester:0.6.94--py27_0
stdout: structureharvester.out
