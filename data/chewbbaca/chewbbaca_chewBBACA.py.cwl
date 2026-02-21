cwlVersion: v1.2
class: CommandLineTool
baseCommand: chewBBACA.py
label: chewbbaca_chewBBACA.py
doc: "A suite of tools for the gene-by-gene typing and microbial genome analysis.\n
  \nTool homepage: https://github.com/B-UMMI/chewBBACA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chewbbaca:3.5.1--pyhdfd78af_0
stdout: chewbbaca_chewBBACA.py.out
