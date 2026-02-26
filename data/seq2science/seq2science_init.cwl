cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seq2science
  - init
label: seq2science_init
doc: "Initialises a default configuration and samples file for a specific workflow.
  Supported workflows: scrna-seq, download-fastq, rna-seq, alignment, atac-seq, scatac-seq,
  chip-seq.\n\nTool homepage: https://vanheeringen-lab.github.io/seq2science"
inputs:
  - id: workflow
    type: string
    doc: The specific workflow to initialize (e.g., scrna-seq, rna-seq, etc.)
    inputBinding:
      position: 1
  - id: dir
    type:
      - 'null'
      - Directory
    doc: The path to the directory where to initialise the config and samples 
      files.
    inputBinding:
      position: 102
      prefix: --dir
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing samples.tsv and config.yaml silently.
    inputBinding:
      position: 102
      prefix: --force
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seq2science:1.2.4--pyhdfd78af_0
stdout: seq2science_init.out
