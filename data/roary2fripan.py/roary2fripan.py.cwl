cwlVersion: v1.2
class: CommandLineTool
baseCommand: roary2fripan.py
label: roary2fripan.py
doc: 'A script to convert Roary output to Fripan format. (Note: The provided text
  contains container execution errors rather than command-line help documentation;
  therefore, specific arguments could not be extracted from the input.)'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/roary2fripan.py:0.1--py27_0
stdout: roary2fripan.py.out
