cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - flair
  - diffexp
label: flair_diffexp
doc: "Differential expression analysis of isoforms using flair. It performs parallel
  DRIMSeq and filters isoforms based on expression thresholds.\n\nTool homepage: https://github.com/BrooksLabUCSC/flair"
inputs:
  - id: counts_matrix
    type: File
    doc: Tab-delimited isoform count matrix from flair quantify module.
    inputBinding:
      position: 101
      prefix: --counts_matrix
  - id: exp_thresh
    type:
      - 'null'
      - int
    doc: Read count expression threshold. Isoforms in which both conditions contain
      fewer than E reads are filtered out (Default E=10)
    inputBinding:
      position: 101
      prefix: --exp_thresh
  - id: out_dir_force
    type:
      - 'null'
      - boolean
    doc: Specify this argument to force overwriting of files in an existing output
      directory
    inputBinding:
      position: 101
      prefix: --out_dir_force
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads for parallel DRIMSeq.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: out_dir
    type: Directory
    doc: Output directory for tables and plots.
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flair:3.0.0--pyhdfd78af_0
