cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - capcruncher
  - interactions
label: capcruncher_interactions
doc: "Reporter counting, storing, comparison and pileups\n\nTool homepage: https://github.com/sims-lab/CapCruncher.git"
inputs:
  - id: compare
    type:
      - 'null'
      - boolean
    doc: Compare bedgraphs and CapCruncher cooler files.
    inputBinding:
      position: 101
  - id: count
    type:
      - 'null'
      - boolean
    doc: Determines the number of captured restriction...
    inputBinding:
      position: 101
  - id: counts_to_cooler
    type:
      - 'null'
      - boolean
    doc: Stores restriction fragment interaction combinations...
    inputBinding:
      position: 101
  - id: deduplicate
    type:
      - 'null'
      - boolean
    doc: Identifies and removes duplicated aligned fragments.
    inputBinding:
      position: 101
  - id: fragments_to_bins
    type:
      - 'null'
      - boolean
    doc: Convert a cooler group containing restriction...
    inputBinding:
      position: 101
  - id: merge
    type:
      - 'null'
      - boolean
    doc: Merges capcruncher HDF5 files together.
    inputBinding:
      position: 101
  - id: pileup
    type:
      - 'null'
      - boolean
    doc: Extracts reporters from a capture experiment and...
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/capcruncher:0.3.14--pyhdfd78af_1
stdout: capcruncher_interactions.out
