cwlVersion: v1.2
class: CommandLineTool
baseCommand: partition-graph.py
label: khmer_partition-graph.py
doc: Partition a sequence graph based upon waypoint connectivity
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.graph_files)
inputs:
  - id: graph_files
    type:
      type: array
      items: File
    doc: Nodegraph and tagset files (for example x and x.tagset from load-graph.py); their names must start with basename.
  - id: basename
    type: string
    doc: basename of the input k-mer nodegraph + tagset files
    inputBinding:
      position: 1
  - id: info
    type:
      - 'null'
      - boolean
    doc: print citation information
    inputBinding:
      position: 102
      prefix: --info
  - id: stoptags
    type:
      - 'null'
      - File
    doc: Use stoptags in this file during partitioning
    inputBinding:
      position: 102
      prefix: --stoptags
  - id: subset_size
    type:
      - 'null'
      - int
    doc: Set subset size (usually 1e5-1e6 is good)
    inputBinding:
      position: 102
      prefix: --subset-size
  - id: no_big_traverse
    type:
      - 'null'
      - boolean
    doc: Truncate graph joins at big traversals
    inputBinding:
      position: 102
      prefix: --no-big-traverse
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite output file if it exists
    inputBinding:
      position: 102
      prefix: --force
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of simultaneous threads to execute
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: pmap_files
    type:
      type: array
      items: File
    doc: Partition maps saved as ${basename}.subset.#.pmap
    outputBinding:
      glob: $(inputs.basename).subset.*.pmap
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
stdout: khmer_partition-graph.py.out
s:url: https://khmer.readthedocs.io/
$namespaces:
  s: https://schema.org/
