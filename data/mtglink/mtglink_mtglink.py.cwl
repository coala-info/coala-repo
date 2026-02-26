cwlVersion: v1.2
class: CommandLineTool
baseCommand: mtglink_mtglink.py
label: mtglink_mtglink.py
doc: "Local assembly with linked read data, using either a De Bruijn Graph (DBG) algorithm
  or an Iterative Read Overlap (IRO) algorithm\n\nTool homepage: https://github.com/anne-gcd/MTG-Link"
inputs:
  - id: module
    type: string
    doc: MTGLink module used for the Local Assembly step
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtglink:2.4.1--hdfd78af_0
stdout: mtglink_mtglink.py.out
