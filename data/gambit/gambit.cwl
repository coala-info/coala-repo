cwlVersion: v1.2
class: CommandLineTool
baseCommand: gambit
label: gambit
doc: "Genomic Analysis and Multi-level Bioinformatics Integration Tool (Note: The
  provided text contains system error logs rather than help documentation; no arguments
  could be extracted from the input).\n\nTool homepage: https://github.com/jlumpe/gambit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gambit:1.1.0--py39hbcbf7aa_2
stdout: gambit.out
