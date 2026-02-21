cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyfba_assigned_functions_to_reactions.py
label: pyfba_assigned_functions_to_reactions.py
doc: "The provided text does not contain help information for the tool, but appears
  to be a container execution error log.\n\nTool homepage: https://linsalrob.github.io/PyFBA/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfba:2.62--py38h3df17bf_5
stdout: pyfba_assigned_functions_to_reactions.py.out
