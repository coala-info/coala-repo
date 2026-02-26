cwlVersion: v1.2
class: CommandLineTool
baseCommand: marvel
label: marvel
doc: "Predict phage draft genomes in metagenomic bins.\n\nTool homepage: http://github.com/quadram-institute-bioscience/marvel/"
inputs:
  - id: cite
    type:
      - 'null'
      - boolean
    doc: Show citations
    inputBinding:
      position: 101
      prefix: --cite
  - id: confidence
    type:
      - 'null'
      - float
    doc: Confidence threshold
    inputBinding:
      position: 101
      prefix: --confidence
  - id: db
    type:
      - 'null'
      - Directory
    doc: Database directory
    inputBinding:
      position: 101
      prefix: --db
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable debug mode
    inputBinding:
      position: 101
      prefix: --debug
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite
    inputBinding:
      position: 101
      prefix: --force
  - id: input_folder
    type:
      - 'null'
      - Directory
    doc: Path to a folder containing metagenomic bins in .fa or .fasta format
    inputBinding:
      position: 101
      prefix: --input-dir
  - id: keep
    type:
      - 'null'
      - boolean
    doc: Keep all intermediate files
    inputBinding:
      position: 101
      prefix: --keep
  - id: min_len
    type:
      - 'null'
      - int
    doc: Bin minimum size
    inputBinding:
      position: 101
      prefix: --min-len
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU threads to be used by Prokka and hmmscan
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/marvel:0.2--py39hdfd78af_4
