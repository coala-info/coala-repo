cwlVersion: v1.2
class: CommandLineTool
baseCommand: CARNAC-LR
label: carnac-lr
doc: "CARNAC-LR is a tool for clustering long reads (PacBio or Oxford Nanopore) for
  de novo assembly of transcriptomes.\n\nTool homepage: https://github.com/kamimrcht/CARNAC-LR"
inputs:
  - id: ground_truth
    type:
      - 'null'
      - File
    doc: Optional ground truth file for validation (e.g., in PAF format).
    inputBinding:
      position: 101
      prefix: -g
  - id: input_file
    type: File
    doc: Input fasta or fastq file containing the reads.
    inputBinding:
      position: 101
      prefix: -f
  - id: min_size
    type:
      - 'null'
      - int
    doc: Minimum number of reads in a cluster.
    inputBinding:
      position: 101
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    default: 1
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: output_file
    type: File
    doc: Output file name for the clusters.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/carnac-lr:1.0.0--h503566f_5
