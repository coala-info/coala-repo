cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - autocycler
  - cluster
label: autocycler_cluster
doc: "cluster contigs in the unitig graph based on similarity\n\nTool homepage: https://github.com/rrwick/Autocycler"
inputs:
  - id: autocycler_dir
    type: Directory
    doc: Autocycler directory containing input_assemblies.gfa file (required)
    inputBinding:
      position: 101
      prefix: --autocycler_dir
  - id: cutoff
    type:
      - 'null'
      - float
    doc: cutoff distance threshold for hierarchical clustering
    default: '0.2'
    inputBinding:
      position: 101
      prefix: --cutoff
  - id: manual
    type:
      - 'null'
      - string
    doc: manually define clusters using tree node numbers
    default: automatic
    inputBinding:
      position: 101
      prefix: --manual
  - id: max_contigs
    type:
      - 'null'
      - int
    doc: refuse to run if mean contigs per assembly exceeds this value
    default: '25'
    inputBinding:
      position: 101
      prefix: --max_contigs
  - id: min_assemblies
    type:
      - 'null'
      - int
    doc: exclude clusters with fewer than this many assemblies
    default: automatic
    inputBinding:
      position: 101
      prefix: --min_assemblies
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/autocycler:0.5.2--h3ab6199_0
stdout: autocycler_cluster.out
