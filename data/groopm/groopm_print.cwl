cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - groopm
  - print
label: groopm_print
doc: "Print information from a groopm database.\n\nTool homepage: https://ecogenomics.github.io/GroopM/"
inputs:
  - id: database
    type: File
    doc: GroopM database file to open (created by groopm parse)
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
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
    type:
      - 'null'
      - string
    doc: print to file not STDOUT
    inputBinding:
      position: 103
      prefix: --outfile
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (bins or contigs table when outfile_path is not set)
  - id: outfile
    type:
      - 'null'
      - File
    doc: print to file not STDOUT
    outputBinding:
      glob: $(inputs.outfile_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.database.basename)
        entry: $(inputs.database)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/groopm:0.3.4--pyhdfd78af_2
stdout: groopm_print.out
