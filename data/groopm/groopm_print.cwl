cwlVersion: v1.2
class: CommandLineTool
baseCommand: groopm_print
label: groopm_print
doc: "Print information from a groopm database.\n\nTool homepage: https://ecogenomics.github.io/GroopM/"
inputs:
  - id: dbname
    type: string
    doc: name of the database to open
    inputBinding:
      position: 1
  - id: bids
    type:
      - 'null'
      - type: array
        items: string
    doc: bin ids to print (None for all)
    default: None
    inputBinding:
      position: 102
      prefix: --bids
  - id: format
    type:
      - 'null'
      - string
    doc: output format [bins, contigs]
    default: bins
    inputBinding:
      position: 102
      prefix: --format
  - id: unbinned
    type:
      - 'null'
      - boolean
    doc: print unbinned contig IDs too
    default: false
    inputBinding:
      position: 102
      prefix: --unbinned
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: print to file not STDOUT
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/groopm:0.3.4--pyhdfd78af_2
