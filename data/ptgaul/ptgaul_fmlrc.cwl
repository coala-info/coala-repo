cwlVersion: v1.2
class: CommandLineTool
baseCommand: ptgaul_fmlrc
label: ptgaul_fmlrc
doc: "FMLRC (Functional Multi-Layered Run-Length Compressed) is a BWT-based tool for
  long read error correction. (Note: The provided text contains system error logs
  rather than help documentation; no arguments could be extracted).\n\nTool homepage:
  https://github.com/Bean061/ptgaul"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ptgaul:1.0.5--pyhdfd78af_1
stdout: ptgaul_fmlrc.out
