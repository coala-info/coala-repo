cwlVersion: v1.2
class: CommandLineTool
baseCommand: suvtk taxonomy
label: suvtk_taxonomy
doc: "This command uses MMseqs2 to assign taxonomy to sequences using protein sequences
  from ICTV taxa in the nr database.\n\nTool homepage: https://github.com/LanderDC/suvtk"
inputs:
  - id: database
    type: Directory
    doc: Path to the suvtk database folder.
    inputBinding:
      position: 101
      prefix: --database
  - id: identity
    type:
      - 'null'
      - float
    doc: Minimum sequence identity for hits to be considered
    inputBinding:
      position: 101
      prefix: --identity
  - id: input
    type: File
    doc: Input fasta file
    inputBinding:
      position: 101
      prefix: --input
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/suvtk:0.1.6--pyh64700be_0
