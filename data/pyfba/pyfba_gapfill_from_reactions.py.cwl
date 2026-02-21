cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyfba_gapfill_from_reactions.py
label: pyfba_gapfill_from_reactions.py
doc: "The provided text does not contain help information for the tool. It appears
  to be a container runtime error log.\n\nTool homepage: https://linsalrob.github.io/PyFBA/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfba:2.62--py38h3df17bf_5
stdout: pyfba_gapfill_from_reactions.py.out
