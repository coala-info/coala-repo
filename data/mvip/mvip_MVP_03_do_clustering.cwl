cwlVersion: v1.2
class: CommandLineTool
baseCommand: mvip MVP_03_do_clustering
label: mvip_MVP_03_do_clustering
doc: "Sequence clustering based on pairwise ANI.\n\nTool homepage: https://gitlab.com/ccoclet/mvp"
inputs:
  - id: metadata_path
    type: File
    doc: Path to your metadata that you want to use to run MVP.
    inputBinding:
      position: 101
      prefix: --metadata
  - id: min_ani
    type:
      - 'null'
      - float
    doc: Minimum ANI value for clustering
    inputBinding:
      position: 101
      prefix: --min_ani
  - id: min_qcov
    type:
      - 'null'
      - float
    doc: Minimum coverage of the query sequence
    inputBinding:
      position: 101
      prefix: --min_qcov
  - id: min_tcov
    type:
      - 'null'
      - float
    doc: Minimum coverage of the target sequence
    inputBinding:
      position: 101
      prefix: --min_tcov
  - id: read_type
    type:
      - 'null'
      - string
    doc: Sequencing data type (e.g. short vs long reads).
    inputBinding:
      position: 101
      prefix: --read-type
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: unfiltered_protein_file
    type:
      - 'null'
      - boolean
    doc: Create protein FASTA file from unfiltered virus sequence. Default = 
      False. Warning = If argument provided, the script might run for a long 
      period of time.
    inputBinding:
      position: 101
      prefix: --unfiltered_protein_file
  - id: working_directory_path
    type: Directory
    doc: Path to your working directory where you want to run MVP.
    inputBinding:
      position: 101
      prefix: --input
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mvip:1.1.5--pyhdfd78af_1
stdout: mvip_MVP_03_do_clustering.out
