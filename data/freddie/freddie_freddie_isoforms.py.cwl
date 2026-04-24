cwlVersion: v1.2
class: CommandLineTool
baseCommand: freddie_isoforms.py
label: freddie_freddie_isoforms.py
doc: "Extract alignment information from BAM/SAM file and splits reads into distinct\n\
  transcriptional intervals\n\nTool homepage: https://github.com/vpc-ccg/freddie"
inputs:
  - id: cluster_dir
    type: Directory
    doc: Path to directory of Freddie cluster
    inputBinding:
      position: 101
      prefix: --cluster-dir
  - id: correction_window
    type:
      - 'null'
      - int
    doc: "The +/- window around segment boundary to look for\n                   \
      \     read alignment boundaries to use for correcting the\n                \
      \        exon boundaries. Value of 0 means no correction."
    inputBinding:
      position: 101
      prefix: --correction-window
  - id: majority_threshold
    type:
      - 'null'
      - float
    doc: "Majority threshold of reads to adjust exon boundary\n                  \
      \      using the original alignments."
    inputBinding:
      position: 101
      prefix: --majority-threshold
  - id: split_dir
    type: Directory
    doc: Path to directory of Freddie segment
    inputBinding:
      position: 101
      prefix: --split-dir
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Path to output file.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/freddie:0.4--hdfd78af_0
