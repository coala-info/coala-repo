cwlVersion: v1.2
class: CommandLineTool
baseCommand: [pxbdsim]
label: phyx_pxbdsim
doc: |-
  Birth-death tree simulator.

  Tool homepage: https://github.com/FePhyFoFum/phyx
inputs:
  - id: extant
    type: ['null', int]
    doc: "number of extant species, alt to time"
    inputBinding:
      prefix: -e
  - id: time
    type: ['null', float]
    doc: "timespan of simulation (age of root), alt to extant"
    inputBinding:
      prefix: -t
  - id: birth
    type: ['null', float]
    doc: "birth rate, default=1"
    inputBinding:
      prefix: -b
  - id: death
    type: ['null', float]
    doc: "death rate, default=0"
    inputBinding:
      prefix: -d
  - id: nreps
    type: ['null', int]
    doc: "number of replicates, default=1"
    inputBinding:
      prefix: -n
  - id: out_file_path
    type: string
    doc: "output file name"
    inputBinding:
      prefix: -o
  - id: showextinct
    type: ['null', boolean]
    doc: "show lineages that went extinct, default=false"
    inputBinding:
      prefix: -s
  - id: seed
    type: ['null', int]
    doc: "random number seed, clock otherwise"
    inputBinding:
      prefix: -x
outputs:
  - id: out_file
    type: File
    doc: "simulated trees (newick, one per line)"
    outputBinding:
      glob: $(inputs.out_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyx:1.1--hc0837bd_5
