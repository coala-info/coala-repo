cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnachisel
label: dnachisel
doc: "DNA Chisel Command Line Interface\n\nTool homepage: https://github.com/Edinburgh-Genome-Foundry/DnaChisel"
inputs:
  - id: source
    type: File
    doc: A fasta or Genbank file
    inputBinding:
      position: 1
  - id: target
    type: string
    doc: A folder name, a zip name (.zip), or a Genbank file (.gb)
    inputBinding:
      position: 2
  - id: circular
    type:
      - 'null'
      - boolean
    doc: Treat the source sequence as circular
    inputBinding:
      position: 103
      prefix: --circular
  - id: mute
    type:
      - 'null'
      - boolean
    doc: Suppress output messages
    inputBinding:
      position: 103
      prefix: --mute
  - id: with_sequence_edits
    type:
      - 'null'
      - boolean
    doc: Annotate edits in the Genbank file
    inputBinding:
      position: 103
      prefix: --with_sequence_edits
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: target_output
    type:
      - 'null'
      - File
      - Directory
    doc: The optimized result written to the target (a folder, a .zip file, or
      a Genbank file)
    outputBinding:
      glob: $(inputs.target)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnachisel:3.2.16--pyh7e72e81_0
stdout: dnachisel.out
