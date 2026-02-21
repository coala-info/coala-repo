cwlVersion: v1.2
class: CommandLineTool
baseCommand: structureharvester_struct_harvest.pl
label: structureharvester_struct_harvest.pl
doc: "A tool for harvesting results from STRUCTURE output files (Note: The provided
  text contains system logs/errors rather than help documentation; no arguments could
  be extracted from the input).\n\nTool homepage: http://alumni.soe.ucsc.edu/~dearl/software/structureHarvester/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/structureharvester:0.6.94--py27_0
stdout: structureharvester_struct_harvest.pl.out
