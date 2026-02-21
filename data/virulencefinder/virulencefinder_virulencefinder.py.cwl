cwlVersion: v1.2
class: CommandLineTool
baseCommand: virulencefinder.py
label: virulencefinder_virulencefinder.py
doc: "VirulenceFinder identifies virulence genes in total or partial sequenced isolates
  of bacteria. (Note: The provided text is a container runtime error log and does
  not contain help documentation or argument definitions.)\n\nTool homepage: https://bitbucket.org/genomicepidemiology/virulencefinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virulencefinder:3.2.0--pyhdfd78af_0
stdout: virulencefinder_virulencefinder.py.out
