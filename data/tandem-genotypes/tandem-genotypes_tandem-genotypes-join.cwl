cwlVersion: v1.2
class: CommandLineTool
baseCommand: tandem-genotypes-join
label: tandem-genotypes_tandem-genotypes-join
doc: "Join and re-rank outputs of tandem-genotypes.\n\nTool homepage: https://github.com/mcfrith/tandem-genotypes"
inputs:
  - id: positive_files
    type:
      type: array
      items: File
    doc: positive (patient/case) files, outputs of tandem-genotypes
    inputBinding:
      position: 1
  - id: negative_files
    type:
      - 'null'
      - type: array
        items: File
    doc: negative (control) files, given after a colon
    inputBinding:
      position: 2
      prefix: ':'
  - id: change
    type:
      - 'null'
      - int
    doc: "get importance from: most-changed non-outlier read (0), most-changed allele (1), least-changed allele (2)"
    inputBinding:
      position: 101
      prefix: --change
  - id: shrink
    type:
      - 'null'
      - boolean
    doc: shrink the output
    inputBinding:
      position: 101
      prefix: --shrink
  - id: mean
    type:
      - 'null'
      - int
    doc: "type of mean for positive/patient/case files: 1=ordinary, 3=cubic"
    inputBinding:
      position: 101
      prefix: --mean
  - id: scores_file
    type:
      - 'null'
      - File
    doc: importance scores for gene parts
    inputBinding:
      position: 101
      prefix: --scores
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: show more details
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tandem-genotypes:1.9.2--pyh7e72e81_0
stdout: tandem-genotypes-join.out
