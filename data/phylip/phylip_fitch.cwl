cwlVersion: v1.2
class: CommandLineTool
baseCommand: fitch
label: phylip_fitch
doc: "The provided text does not contain help information for the tool; it appears
  to be a container engine error log. Phylip fitch is typically used for Fitch-Margoliash
  and Least-Squares Distance Methods in phylogeny.\n\nTool homepage: http://evolution.genetics.washington.edu/phylip/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylip:3.697--h470a237_0
stdout: phylip_fitch.out
