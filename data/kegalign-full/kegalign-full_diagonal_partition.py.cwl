cwlVersion: v1.2
class: CommandLineTool
baseCommand: diagonal_partition.py
label: kegalign-full_diagonal_partition.py
doc: "Partitions a large alignment file into smaller chunks based on diagonal blocks.\n\
  \nTool homepage: https://github.com/galaxyproject/KegAlign"
inputs:
  - id: chunk_size
    type: int
    doc: The size of each chunk (number of sequences).
    inputBinding:
      position: 1
  - id: input_alignment
    type: File
    doc: The input alignment file (e.g., FASTA, FASTQ).
    inputBinding:
      position: 2
  - id: output_prefix
    type: string
    doc: A prefix for the output chunk files.
    inputBinding:
      position: 3
  - id: diagonal_threshold
    type:
      - 'null'
      - float
    doc: The threshold for considering sequences as part of the same diagonal 
      block. Default is 0.9.
    default: 0.9
    inputBinding:
      position: 104
      prefix: --diagonal-threshold
  - id: min_diagonal_size
    type:
      - 'null'
      - int
    doc: The minimum number of sequences required to form a diagonal block. 
      Default is 100.
    default: 100
    inputBinding:
      position: 104
      prefix: --min-diagonal-size
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: The directory to save the output chunk files. Defaults to the current 
      directory.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kegalign-full:0.1.2.8--hdfd78af_0
