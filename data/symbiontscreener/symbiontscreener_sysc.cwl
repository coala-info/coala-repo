cwlVersion: v1.2
class: CommandLineTool
baseCommand: sysc
label: symbiontscreener_sysc
doc: "Symbiont Screener (SYSC) is a tool for analyzing microbial communities. It supports
  two main modes: strobemer mode (s40) and kmer mode (k21), with various actions for
  building, density analysis, clustering, and consensus clustering.\n\nTool homepage:
  https://github.com/BGI-Qingdao/Symbiont-Screener"
inputs:
  - id: action
    type: string
    doc: 'The action to perform. Available actions include: build_s40, build_k21,
      density_s40, density_k21, trio_result_s40, trio_result_k21, cluster_s40, cluster_k21,
      consensus_cluster_s40, consensus_cluster_k21.'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/symbiontscreener:1.0.0--h5ca1c30_2
stdout: symbiontscreener_sysc.out
