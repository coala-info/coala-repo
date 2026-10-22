cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - trycycler
  - msa
label: trycycler_msa
doc: "multiple sequence alignment\n\nTool homepage: https://github.com/rrwick/Trycycler"
inputs:
  - id: cluster_dir
    type: Directory
    doc: Cluster directory (should contain a 1_contigs subdirectory)
    inputBinding:
      position: 101
      prefix: --cluster_dir
  - id: kmer
    type:
      - 'null'
      - int
    doc: K-mer size used for sequence partitioning
    inputBinding:
      position: 101
      prefix: --kmer
  - id: lookahead
    type:
      - 'null'
      - int
    doc: Look-ahead margin used for sequence partitioning
    inputBinding:
      position: 101
      prefix: --lookahead
  - id: step
    type:
      - 'null'
      - int
    doc: Step size used for sequence partitioning
    inputBinding:
      position: 101
      prefix: --step
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for multiple sequence alignment
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: cluster_dir_out
    type: Directory
    doc: The cluster directory with the results of this step added
    outputBinding:
      glob: $(inputs.cluster_dir.basename)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.cluster_dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trycycler:0.5.6--pyhdfd78af_0
