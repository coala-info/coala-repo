cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - faidx
label: pyfaidx_faidx
doc: "Efficient pythonic random access to fasta files. (Note: The provided text contains
  system error logs rather than help text; no arguments could be extracted.)\n\nTool
  homepage: https://github.com/mdshw5/pyfaidx"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfaidx:0.9.0.3--pyhdfd78af_0
stdout: pyfaidx_faidx.out
