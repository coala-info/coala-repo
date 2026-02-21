cwlVersion: v1.2
class: CommandLineTool
baseCommand: ptgaul_combine_gfa.py
label: ptgaul_combine_gfa.py
doc: "A tool to combine GFA files (Note: The provided text contains execution logs/errors
  rather than help documentation, so specific arguments could not be parsed).\n\n
  Tool homepage: https://github.com/Bean061/ptgaul"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ptgaul:1.0.5--pyhdfd78af_1
stdout: ptgaul_combine_gfa.py.out
