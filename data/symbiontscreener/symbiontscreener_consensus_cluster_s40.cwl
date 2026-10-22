cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sysc
  - consensus_cluster_s40
label: symbiontscreener_consensus_cluster_s40
doc: "Select reads with enough hits in the best and second best cluster (consensus clustering).\n\nTool homepage: https://github.com/BGI-Qingdao/Symbiont-Screener"
inputs:
  - id: cluster_dir
    type: Directory
    doc: Output directory of cluster_s40 (step03.1.s40)
  - id: min_hit
    type: ['null', int]
    doc: Minimum hits in the best and second best cluster
    inputBinding:
      position: 1
      prefix: --min_hit
outputs:
  - id: step03_2_s40
    type: Directory
    doc: Consensus directory step03.2.s40
    outputBinding:
      glob: step03.2.s40
  - id: stdout
    type: stdout
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entryname: step03.1.s40
        entry: $(inputs.cluster_dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/symbiontscreener:1.0.0--h5ca1c30_2
stdout: symbiontscreener_consensus_cluster_s40.stdout.txt
