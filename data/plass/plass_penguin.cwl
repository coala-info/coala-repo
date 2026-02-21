cwlVersion: v1.2
class: CommandLineTool
baseCommand: penguin
label: plass_penguin
doc: "protein-guided nucleotide assembler. Assemble nucleotide sequences by iterative
  greedy overlap assembly using protein and nucleotide information.\n\nTool homepage:
  https://github.com/soedinglab/plass"
inputs:
  - id: command
    type: string
    doc: The command to execute (guided_nuclassemble or nuclassemble)
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the specified command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plass:5.cf8933--hd6d6fdc_3
stdout: plass_penguin.out
