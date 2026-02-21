cwlVersion: v1.2
class: CommandLineTool
baseCommand: monovar_monovar.py
label: monovar_monovar.py
doc: "Single nucleotide variant (SNV) calling for single-cell sequencing data. (Note:
  The provided text contains system error logs rather than help documentation; no
  arguments could be extracted.)\n\nTool homepage: https://bitbucket.org/hamimzafar/monovar"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/monovar:v0.0.1--py27_0
stdout: monovar_monovar.py.out
