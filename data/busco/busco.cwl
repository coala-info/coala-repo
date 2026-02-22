cwlVersion: v1.2
class: CommandLineTool
baseCommand: busco
label: busco
doc: "BUSCO: Assessing genome assembly and annotation completeness with Benchmarking
  Universal Single-Copy Orthologs\n\nTool homepage: https://busco.ezlab.org"
inputs:
  - id: augustus
    type:
      - 'null'
      - boolean
    doc: Use Augustus gene predictor for eukaryotic genomes
    inputBinding:
      position: 101
      prefix: --augustus
  - id: config_file
    type:
      - 'null'
      - File
    doc: Provide a custom BUSCO configuration file
    inputBinding:
      position: 101
      prefix: --config
  - id: cpu
    type:
      - 'null'
      - int
    doc: Specify the number of threads/cores to use
    default: 1
    inputBinding:
      position: 101
      prefix: --cpu
  - id: download_path
    type:
      - 'null'
      - Directory
    doc: Local path for storing BUSCO datasets
    inputBinding:
      position: 101
      prefix: --download_path
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force rewriting of existing results
    inputBinding:
      position: 101
      prefix: --force
  - id: input
    type: File
    doc: Input sequence file in FASTA format. Can be an assembly, a gene set, or
      a proteome.
    inputBinding:
      position: 101
      prefix: --in
  - id: lineage_dataset
    type: string
    doc: Specify the name of the BUSCO lineage to be used
    inputBinding:
      position: 101
      prefix: --lineage_dataset
  - id: long
    type:
      - 'null'
      - boolean
    doc: Optimization mode Augustus self-training
    inputBinding:
      position: 101
      prefix: --long
  - id: mode
    type: string
    doc: Specify which BUSCO analysis mode to run (genome, transcriptome, or 
      proteins)
    inputBinding:
      position: 101
      prefix: --mode
  - id: offline
    type:
      - 'null'
      - boolean
    doc: To run BUSCO in offline mode
    inputBinding:
      position: 101
      prefix: --offline
outputs:
  - id: output
    type: File
    doc: Give a name to the output folder and files
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/busco:6.0.0--pyhdfd78af_2
