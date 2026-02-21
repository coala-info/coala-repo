cwlVersion: v1.2
class: CommandLineTool
baseCommand: trawler
label: trawler
doc: "The provided text is a container execution error log (Apptainer/Singularity)
  and does not contain help information or argument definitions for the tool 'trawler'.\n
  \nTool homepage: https://trawler.erc.monash.edu.au/help.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trawler:2.0--0
stdout: trawler.out
