cwlVersion: v1.2
class: CommandLineTool
baseCommand: biskit
label: biskit
doc: "Biskit is a Python framework for structural bioinformatics, facilitating the
  manipulation and analysis of macromolecular structures, protein complexes, and molecular
  dynamics trajectories.\n\nTool homepage: http://biskit.pasteur.fr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biskit:3.0.1--pyh7e72e81_0
stdout: biskit.out
