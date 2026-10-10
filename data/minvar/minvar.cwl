cwlVersion: v1.2
class: CommandLineTool
baseCommand: minvar
label: minvar
doc: "optional arguments:\n\nTool homepage: https://git.io/minvar"
inputs:
  - id: fastq
    type: File
    doc: input reads in fastq format
    inputBinding:
      position: 101
      prefix: --fastq
  - id: keep
    type:
      - 'null'
      - boolean
    doc: keep intermediate files
    inputBinding:
      position: 101
      prefix: --keep
  - id: recal
    type:
      - 'null'
      - boolean
    doc: turn on recalibration with GATK
    inputBinding:
      position: 101
      prefix: --recal
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: final_mutations
    type:
      - 'null'
      - File
    doc: Mutations called on the codon-phased consensus
    outputBinding:
      glob: final.csv
  - id: annotated_mutations
    type:
      - 'null'
      - File
    doc: Annotated drug-resistance mutations
    outputBinding:
      glob: merged_muts_drm_annotated.csv
  - id: report
    type:
      - 'null'
      - File
    doc: Report in markdown format
    outputBinding:
      glob: report.md
  - id: log
    type:
      - 'null'
      - File
    doc: Run log
    outputBinding:
      glob: minvar.log
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minvar:2.2.2--py35_0
stdout: minvar.out
