cwlVersion: v1.2
class: CommandLineTool
baseCommand: COGclassifier
label: cogclassifier_COGclassifier
doc: "A tool for classifying prokaryote protein sequences into COG functional category\n\
  \nTool homepage: https://github.com/moshi4/COGclassifier/"
inputs:
  - id: download_dir
    type:
      - 'null'
      - Directory
    doc: Download COG & CDD resources directory
    inputBinding:
      position: 101
      prefix: --download_dir
  - id: evalue
    type:
      - 'null'
      - float
    doc: RPS-BLAST e-value parameter
    inputBinding:
      position: 101
      prefix: --evalue
  - id: infile
    type: File
    doc: Input query protein fasta file
    inputBinding:
      position: 101
      prefix: --infile
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: No print log on screen
    inputBinding:
      position: 101
      prefix: --quiet
  - id: thread_num
    type:
      - 'null'
      - int
    doc: RPS-BLAST num_thread parameter
    inputBinding:
      position: 101
      prefix: --thread_num
outputs:
  - id: outdir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cogclassifier:2.0.0--pyhdfd78af_0
