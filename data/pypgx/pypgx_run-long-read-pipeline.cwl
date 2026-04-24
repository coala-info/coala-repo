cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pypgx
  - run-long-read-pipeline
label: pypgx_run-long-read-pipeline
doc: "Run genotyping pipeline for long-read sequencing data.\n\nTool homepage: https://github.com/sbslee/pypgx"
inputs:
  - id: gene
    type: string
    doc: Target gene.
    inputBinding:
      position: 1
  - id: output
    type: Directory
    doc: Output directory.
    inputBinding:
      position: 2
  - id: variants
    type: File
    doc: Input VCF file must be already BGZF compressed (.gz) and indexed (.tbi)
      to allow random access.
    inputBinding:
      position: 3
  - id: assembly
    type:
      - 'null'
      - string
    doc: "Reference genome assembly (default: 'GRCh37') (choices: 'GRCh37', 'GRCh38')."
    inputBinding:
      position: 104
      prefix: --assembly
  - id: exclude
    type:
      - 'null'
      - boolean
    doc: Exclude specified samples.
    inputBinding:
      position: 104
      prefix: --exclude
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite output directory if it already exists.
    inputBinding:
      position: 104
      prefix: --force
  - id: samples
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify which samples should be included for analysis by providing a 
      text file (.txt, .tsv, .csv, or .list) containing one sample per line. 
      Alternatively, you can provide a list of samples.
    inputBinding:
      position: 104
      prefix: --samples
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
stdout: pypgx_run-long-read-pipeline.out
