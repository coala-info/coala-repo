cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - matlock
  - cutsites
label: matlock_cutsites
doc: "Count cut sites (motifs) per sequence id of a fasta file.\n\nTool homepage:
  https://github.com/phasegenomics/matlock"
inputs:
  - id: input_fasta
    type: File
    doc: Input fasta file. Staged writable because matlock writes the .fai index beside it.
    inputBinding:
      position: 1
  - id: motifs
    type:
      type: array
      items: string
    doc: Motifs (cut sites) to count, for example GATC.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Cut site counts per sequence id
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_fasta)
        writable: true
stdout: matlock_cutsites.out
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/matlock:20181227--h665f8ca_8
