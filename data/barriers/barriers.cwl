cwlVersion: v1.2
class: CommandLineTool
baseCommand: barriers
label: barriers
doc: "Compute local minima and energy barriers of a landscape\n\nTool homepage: https://www.tbi.univie.ac.at/RNA/Barriers/"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Energy sorted list of conformations of a landscape
    inputBinding:
      position: 1
  - id: bsize
    type:
      - 'null'
      - boolean
    doc: Print the size of of each basin in output.
    inputBinding:
      position: 102
      prefix: --bsize
  - id: connected
    type:
      - 'null'
      - boolean
    doc: Restrict the output to the connected component.
    inputBinding:
      position: 102
      prefix: --connected
  - id: graph
    type:
      - 'null'
      - string
    doc: Define type of the graph, i.e. configuration space.
    inputBinding:
      position: 102
      prefix: --graph
  - id: mapstruc
    type:
      - 'null'
      - File
    doc: Map conformations to minima in the tree.
    inputBinding:
      position: 102
      prefix: --mapstruc
  - id: max_minima
    type:
      - 'null'
      - int
    doc: Compute only the lowest <num> local minima.
    inputBinding:
      position: 102
      prefix: --max
  - id: min_barrier_height
    type:
      - 'null'
      - float
    doc: Print only minima with energy barrier greater than delta.
    inputBinding:
      position: 102
      prefix: --minh
  - id: moves
    type:
      - 'null'
      - string
    doc: Select the move-set for generating neighbors of a configuration (if 
      Graph allows several different ones).
    inputBinding:
      position: 102
      prefix: --moves
  - id: path
    type:
      - 'null'
      - string
    doc: Backtrack an optimal path between local minimum l2 and l1.
    inputBinding:
      position: 102
      prefix: --path
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Be quiet (also inhibit PS tree output).
    inputBinding:
      position: 102
      prefix: --quiet
  - id: rates
    type:
      - 'null'
      - boolean
    doc: Compute rates between macro states (basins).
    inputBinding:
      position: 102
      prefix: --rates
  - id: saddle
    type:
      - 'null'
      - boolean
    doc: Print the saddle point conformations in output.
    inputBinding:
      position: 102
      prefix: --saddle
  - id: ssize
    type:
      - 'null'
      - boolean
    doc: Print saddle component sizes.
    inputBinding:
      position: 102
      prefix: --ssize
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be verbose, i.e. print more information.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/barriers:1.8.1--pl5321h503566f_4
stdout: barriers.out
