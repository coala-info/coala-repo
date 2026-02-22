cwlVersion: v1.2
class: CommandLineTool
baseCommand: plip
label: plip
doc: "Protein-Ligand Interaction Profiler. (Note: The provided text contains system
  error messages regarding container execution and disk space rather than the tool's
  help documentation. As a result, no arguments could be extracted from the input.)\n\
  \nTool homepage: https://github.com/pharmai/plip"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/plip:v1.4.3bdfsg-2-deb_cv1
stdout: plip.out
