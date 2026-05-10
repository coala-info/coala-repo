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
    inputBinding:
      position: 102
      prefix: --bids
  - id: format
    type:
      - 'null'
      - string
    doc: output format [bins, contigs]
    inputBinding:
      position: 102
      prefix: --format
  - id: unbinned
    type:
      - 'null'
      - boolean
    doc: print unbinned contig IDs too
    inputBinding:
      position: 102
      prefix: --unbinned
  - id: outfile_path
    type: string
    doc: Output or path parameter `outfile_path`
    inputBinding:
      position: 103
      prefix: --outfile
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: print to file not STDOUT
    outputBinding:
      glob: $(inputs.outfile_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/groopm:0.3.4--pyhdfd78af_2
