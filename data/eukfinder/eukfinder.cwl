cwlVersion: v1.2
class: CommandLineTool
baseCommand: eukfinder
label: eukfinder
doc: "EukFinder is a tool for identifying and retrieving eukaryotic sequences from
  metagenomic datasets. (Note: The provided text contains container runtime errors
  and does not include the help menu; therefore, no arguments could be extracted.)\n
  \nTool homepage: https://github.com/RogerLab/Eukfinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eukfinder:1.2.4--py36h503566f_0
stdout: eukfinder.out
