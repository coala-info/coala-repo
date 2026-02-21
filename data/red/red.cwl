cwlVersion: v1.2
class: CommandLineTool
baseCommand: Red
label: red
doc: "Red (REpeat Detector) is an automated tool for detecting repeats in genomic
  sequences.\n\nTool homepage: http://toolsmith.ens.utulsa.edu"
inputs:
  - id: format
    type:
      - 'null'
      - int
    doc: 'Format of the output (0: fasta, 1: bed, 2: table)'
    inputBinding:
      position: 101
      prefix: -frm
  - id: genome_dir
    type: Directory
    doc: Directory containing the genome files (fasta/fa)
    inputBinding:
      position: 101
      prefix: -gnm
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: K-mer size
    inputBinding:
      position: 101
      prefix: -k
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum length of the repeat
    inputBinding:
      position: 101
      prefix: -len
  - id: min_occurrences
    type:
      - 'null'
      - int
    doc: Minimum number of occurrences
    inputBinding:
      position: 101
      prefix: -min
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: output_dir
    type: Directory
    doc: Directory where the output files will be written
    outputBinding:
      glob: $(inputs.output_dir)
  - id: masked_dir
    type:
      - 'null'
      - Directory
    doc: Directory for masked genome files
    outputBinding:
      glob: $(inputs.masked_dir)
  - id: repeats_dir
    type:
      - 'null'
      - Directory
    doc: Directory for repeat files
    outputBinding:
      glob: $(inputs.repeats_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/red:2018.09.10--h9948957_3
