cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hotspot3d
  - sigclus
label: hotspot3d_sigclus
doc: "Calculate significance of clusters using simulations\n\nTool homepage: https://github.com/ding-lab/hotspot3d"
inputs:
  - id: clusters
    type:
      - 'null'
      - File
    doc: Cluster file (pancan19.intra.20..05.10.clusters)
    inputBinding:
      position: 101
      prefix: --clusters
  - id: pairwise
    type:
      - 'null'
      - File
    doc: Pairwise file (pancan19.pairwise)
    inputBinding:
      position: 101
      prefix: --pairwise
  - id: prep_dir
    type:
      - 'null'
      - Directory
    doc: Preprocessing directory
    inputBinding:
      position: 101
      prefix: --prep-dir
  - id: simulations
    type:
      - 'null'
      - int
    doc: Number of simulations
    inputBinding:
      position: 101
      prefix: --simulations
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: Output file prefix (pancan19.intra.20..05.10)
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hotspot3d:1.8.2--pl526_0
