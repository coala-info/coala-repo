cwlVersion: v1.2
class: CommandLineTool
baseCommand: select_taxa.py
label: phylofisher_select_taxa.py
doc: "Selects taxa to be included in super matrix construction\n\nTool homepage: https://github.com/TheBrownLab/PhyloFisher"
inputs:
  - id: chimeras
    type:
      - 'null'
      - File
    doc: A .tsv containing a Unique ID, higher and lower taxonomic designations,
      long name, and the Unique IDs of the taxa to collapse, for each chimera 
      one per line
    inputBinding:
      position: 101
      prefix: --chimeras
  - id: to_exclude
    type:
      - 'null'
      - File
    doc: List of taxa to exclude.
    inputBinding:
      position: 101
      prefix: --to_exclude
  - id: to_include
    type:
      - 'null'
      - File
    doc: List of taxa to include.
    inputBinding:
      position: 101
      prefix: --to_include
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylofisher:1.2.14--pyhdfd78af_0
stdout: phylofisher_select_taxa.py.out
