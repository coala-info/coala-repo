cwlVersion: v1.2
class: CommandLineTool
baseCommand: groopm_dump
label: groopm_dump
doc: "Dump data from a groopm database.\n\nTool homepage: https://ecogenomics.github.io/GroopM/"
inputs:
  - id: dbname
    type: string
    doc: name of the database to open
    inputBinding:
      position: 1
  - id: fields
    type:
      - 'null'
      - string
    doc: "fields to extract: Build a comma separated list from [names, mers, gc, coverage,
      tcoverage, ncoverage, lengths, bins] or just use 'all']"
    default: names,bins
    inputBinding:
      position: 102
      prefix: --fields
  - id: no_headers
    type:
      - 'null'
      - boolean
    doc: don't add headers
    default: false
    inputBinding:
      position: 102
      prefix: --no_headers
  - id: separator
    type:
      - 'null'
      - string
    doc: data separator
    default: ','
    inputBinding:
      position: 102
      prefix: --separator
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: write data to this file
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/groopm:0.3.4--pyhdfd78af_2
