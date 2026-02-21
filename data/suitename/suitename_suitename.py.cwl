cwlVersion: v1.2
class: CommandLineTool
baseCommand: suitename
label: suitename_suitename.py
doc: "Suitename is a tool for RNA backbone conformer classification. It categorizes
  each suite (the sugar-to-sugar unit) into one of the defined clusters or as an outlier
  (out).\n\nTool homepage: https://github.com/rlabduke/suitename"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/suitename:v0.3.070628-2-deb_cv1
stdout: suitename_suitename.py.out
