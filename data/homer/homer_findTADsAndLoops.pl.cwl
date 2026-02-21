cwlVersion: v1.2
class: CommandLineTool
baseCommand: homer_findTADsAndLoops.pl
label: homer_findTADsAndLoops.pl
doc: "A tool from the HOMER suite for identifying Topologically Associating Domains
  (TADs) and chromatin loops from Hi-C data. (Note: The provided input text contains
  system error messages regarding container execution and does not include the actual
  help documentation for the tool's arguments.)\n\nTool homepage: http://homer.ucsd.edu/homer/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/homer:5.1--pl5262h9948957_0
stdout: homer_findTADsAndLoops.pl.out
