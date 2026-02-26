cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - repic
  - get_cliques
label: repic_get_cliques
doc: "Finds cliques of particles based on proximity in 3D space.\n\nTool homepage:
  https://github.com/ccameron/REPIC"
inputs:
  - id: in_dir
    type: Directory
    doc: path to input directory containing subdirectories of particle bounding 
      box coordinate files
    inputBinding:
      position: 1
  - id: out_dir
    type: Directory
    doc: path to output directory (WARNING - script will delete directory if it 
      exists)
    inputBinding:
      position: 2
  - id: box_size
    type: int
    doc: particle bounding box size (in int[pixels])
    inputBinding:
      position: 3
  - id: get_cc
    type:
      - 'null'
      - boolean
    doc: filters cliques for those in the largest Connected Component (CC)
    inputBinding:
      position: 104
      prefix: --get_cc
  - id: multi_out
    type:
      - 'null'
      - boolean
    doc: set output of cliques to be members sorted by picker name
    inputBinding:
      position: 104
      prefix: --multi_out
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/repic:1.0.0--pyhdfd78af_0
stdout: repic_get_cliques.out
