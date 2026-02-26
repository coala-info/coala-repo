cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bcbio-rnaseq
  - compare
label: bcbio-rnaseq_compare
doc: "Compare RNA-seq experiments\n\nTool homepage: https://github.com/hbc/bcbioRNASeq"
inputs:
  - id: project_file
    type: File
    doc: A bcbio-nextgen project file
    inputBinding:
      position: 1
  - id: key
    type: string
    doc: Key in the metadata field to do pairwise comparisons
    inputBinding:
      position: 2
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of cores
    default: 1
    inputBinding:
      position: 103
      prefix: --cores
  - id: counts_only
    type:
      - 'null'
      - boolean
    doc: Only run count-based analyses
    inputBinding:
      position: 103
      prefix: --counts-only
  - id: seqc
    type:
      - 'null'
      - boolean
    doc: Data is from a SEQC alignment
    inputBinding:
      position: 103
      prefix: --seqc
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcbio-rnaseq:1.2.0--r3.3.2_3
stdout: bcbio-rnaseq_compare.out
