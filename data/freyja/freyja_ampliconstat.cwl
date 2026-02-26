cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - freyja
  - ampliconstat
label: freyja_ampliconstat
doc: "Calculate amplicon statistics from a FASTA file.\n\nTool homepage: https://github.com/andersen-lab/Freyja"
inputs:
  - id: primer
    type: File
    doc: BED file containing primer locations.
    inputBinding:
      position: 101
      prefix: --primer
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file for statistics.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/freyja:2.0.3--pyhdfd78af_0
