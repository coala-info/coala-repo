cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sysc
  - consensus_cluster_k21
label: symbiontscreener_consensus_cluster_k21
doc: "Select reads with enough hits in the best and second best cluster (consensus clustering).\n\nTool homepage: https://github.com/BGI-Qingdao/Symbiont-Screener"
inputs:
  - id: cluster_dir
    type: Directory
    doc: Output directory of cluster_k21 (step03.1.k21)
  - id: min_hit
    type: ['null', int]
    doc: Minimum hits in the best and second best cluster
    inputBinding:
      position: 1
      prefix: --min_hit
outputs:
  - id: step03_2_k21
    type: Directory
    doc: Consensus directory step03.2.k21
    outputBinding:
      glob: step03.2.k21
  - id: stdout
    type: stdout
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entryname: step03.1.k21
        entry: $(inputs.cluster_dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/symbiontscreener:1.0.0--h5ca1c30_2
stdout: symbiontscreener_consensus_cluster_k21.stdout.txt
