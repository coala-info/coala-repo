cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - args_oap
  - stage_one
label: args_oap_stage_one
doc: "Stage one of the ARGs-OAP pipeline for antibiotic resistance genes (ARGs) analysis.\n
  \nTool homepage: https://github.com/xinehc/args_oap"
inputs:
  - id: database
    type:
      - 'null'
      - File
    doc: Customized database (indexed) other than SARG.
    inputBinding:
      position: 101
      prefix: --database
  - id: e1
    type:
      - 'null'
      - float
    doc: E-value cutoff for GreenGenes.
    inputBinding:
      position: 101
      prefix: --e1
  - id: e2
    type:
      - 'null'
      - float
    doc: E-value cutoff for Essential Single Copy Marker Genes.
    inputBinding:
      position: 101
      prefix: --e2
  - id: format
    type:
      - 'null'
      - string
    doc: File format in input folder (--indir), gzipped (*.gz) optional.
    inputBinding:
      position: 101
      prefix: --format
  - id: identity
    type:
      - 'null'
      - float
    doc: Identity cutoff (in percentage) for Essential Single Copy Marker Genes.
    inputBinding:
      position: 101
      prefix: --id
  - id: indir
    type: Directory
    doc: Input folder.
    inputBinding:
      position: 101
      prefix: --indir
  - id: keep
    type:
      - 'null'
      - boolean
    doc: Keep all temporary files (*.tmp) in output folder (--outdir).
    inputBinding:
      position: 101
      prefix: --keep
  - id: query_cover
    type:
      - 'null'
      - float
    doc: Query cover cutoff (in percentage) for Essential Single Copy Marker Genes.
    inputBinding:
      position: 101
      prefix: --qcov
  - id: skip
    type:
      - 'null'
      - boolean
    doc: Skip cell number and 16S copy number estimation.
    inputBinding:
      position: 101
      prefix: --skip
  - id: thread
    type:
      - 'null'
      - int
    doc: Number of threads.
    inputBinding:
      position: 101
      prefix: --thread
outputs:
  - id: outdir
    type: Directory
    doc: Output folder.
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/args_oap:3.2.4--pyhdfd78af_0
