cwlVersion: v1.2
class: CommandLineTool
baseCommand: koeken_koeken.py
label: koeken_koeken.py
doc: "A tool for comparing microbial communities (typically used in meta-analysis
  of LEfSe results).\n\nTool homepage: https://github.com/twbattaglia/koeken"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/koeken:0.2.6--py27_0
stdout: koeken_koeken.py.out
