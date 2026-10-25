cwlVersion: v1.2
class: CommandLineTool
baseCommand: qacAgpLift
label: ucsc-qacagplift
doc: "Use an AGP file to combine per-scaffold qac files into a per-chromosome qac
  file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: scaffold_to_chrom_agp
    type: File
    doc: AGP file describing how scaffolds are placed on chromosomes.
    inputBinding:
      position: 10
  - id: scaffolds_qac
    type: File
    doc: Input per-scaffold quality score file (.qac).
    inputBinding:
      position: 11
  - id: chrom_qac
    type: string
    doc: Output per-chromosome quality score file name (.qac).
    inputBinding:
      position: 12
  - id: m_score
    type:
      - 'null'
      - int
    doc: Score to use for missing data (otherwise fail); range 0-99, recommended
      values are 98 (low quality) or 99 (high quality).
    inputBinding:
      position: 1
      prefix: -mScore=
      separate: false
outputs:
  - id: chrom_qac_file
    type: File
    doc: Output per-chromosome quality score file.
    outputBinding:
      glob: $(inputs.chrom_qac)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-qacagplift:482--h0b57e2e_0
