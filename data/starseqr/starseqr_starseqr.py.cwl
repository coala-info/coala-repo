cwlVersion: v1.2
class: CommandLineTool
baseCommand: starseqr_starseqr.py
label: starseqr_starseqr.py
doc: "The provided text does not contain help information or usage instructions; it
  is a log of a failed container build process. No arguments could be extracted.\n
  \nTool homepage: https://github.com/ExpressionAnalysis/STAR-SEQR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/starseqr:0.6.7--py27h7eb728f_0
stdout: starseqr_starseqr.py.out
