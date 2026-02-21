cwlVersion: v1.2
class: CommandLineTool
baseCommand: phist_phist.py
label: phist_phist.py
doc: "PHage-host Interaction Search Tool (PHIST) - A tool for predicting phage-host
  interactions.\n\nTool homepage: https://github.com/refresh-bio/PHIST"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phist:1.0.0--py311h2de2dd3_1
stdout: phist_phist.py.out
