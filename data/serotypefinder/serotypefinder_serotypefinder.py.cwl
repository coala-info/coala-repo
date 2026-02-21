cwlVersion: v1.2
class: CommandLineTool
baseCommand: serotypefinder.py
label: serotypefinder_serotypefinder.py
doc: "SerotypeFinder identifies the serotype in total or partial genome sequences
  of E. coli.\n\nTool homepage: https://bitbucket.org/genomicepidemiology/serotypefinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/serotypefinder:2.0.2--py312hdfd78af_1
stdout: serotypefinder_serotypefinder.py.out
