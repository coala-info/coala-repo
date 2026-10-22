cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tigr-glimmer
  - entropy-profile
label: tigr-glimmer_entropy-profile
doc: "Read multi-fasta-format gene sequences from stdin. Translate each to its protein product and then print the natural and entropy distributions of the amino acids. Output goes to stdout.\n\nTool homepage: https://ccb.jhu.edu/software/glimmer/"
inputs:
  - id: input_file
    type: File
    doc: Multi-fasta-format gene sequences, read from standard input
  - id: brief
    type:
      - 'null'
      - boolean
    doc: 'Brief output: 3 columns with header line'
    inputBinding:
      position: 1
      prefix: --brief
  - id: minlen
    type:
      - 'null'
      - int
    doc: Do not output any sequence shorter than <n> characters
    inputBinding:
      position: 1
      prefix: --minlen
outputs:
  - id: stdout
    type: stdout
    doc: Natural and entropy distributions of the amino acids
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/tigr-glimmer:v3.02b-2-deb_cv1
stdin: $(inputs.input_file.path)
stdout: tigr-glimmer_entropy-profile.out
