cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxon_collapser.py
label: phylofisher_taxon_collapser.py
doc: "Collapses dataset entries into a single taxon\n\nTool homepage: https://github.com/TheBrownLab/PhyloFisher"
inputs:
  - id: input_taxa
    type: File
    doc: "A .tsv containing a Unique ID, long name, higher taxonomy, lower taxonomy,
      and a list of Unique IDs to collapse\n                                  for
      each chimera with one on each line."
    inputBinding:
      position: 101
      prefix: --input
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylofisher:1.2.14--pyhdfd78af_0
stdout: phylofisher_taxon_collapser.py.out
