cwlVersion: v1.2
class: CommandLineTool
baseCommand: spades.py
label: spades_spades.py
doc: "SPAdes genome assembler (Note: The provided text contains container build logs
  and error messages rather than the tool's help output. No arguments could be extracted
  from the provided text.)\n\nTool homepage: https://github.com/ablab/spades"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spades:4.2.0--h8d6e82b_2
stdout: spades_spades.py.out
