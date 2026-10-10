cwlVersion: v1.2
class: CommandLineTool
baseCommand: single_cov2
label: multiz_single_cov2
doc: "single_cov2: screen out overlapped regions of a pairwise MAF so each position is covered once. Usage: single_cov2 pairwise.maf [R=species] [F=deleted.maf]. The result goes to standard output.\n\nTool homepage: http://www.bx.psu.edu/miller_lab/"
inputs:
  - id: pairwise_maf
    type: File
    doc: Pairwise MAF file; the first rows of all blocks must be one species and the second rows another
    inputBinding:
      position: 1
  - id: reference
    type:
      - 'null'
      - string
    doc: "R, species for which single coverage is done (default both species)"
    inputBinding:
      position: 2
      prefix: R=
      separate: false
  - id: deleted_path
    type:
      - 'null'
      - string
    doc: "F, file name for the deleted alignment parts"
    inputBinding:
      position: 3
      prefix: F=
      separate: false
outputs:
  - id: single_coverage
    type: stdout
    doc: Single-coverage MAF (standard output)
  - id: deleted
    type:
      - 'null'
      - File
    doc: Deleted alignment parts
    outputBinding:
      glob: $(inputs.deleted_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/multiz:11.2--hec16e2b_3
stdout: single_cov2.maf
