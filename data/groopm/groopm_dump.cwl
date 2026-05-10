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
    inputBinding:
      position: 102
      prefix: --fields
  - id: no_headers
    type:
      - 'null'
      - boolean
    doc: don't add headers
    inputBinding:
      position: 102
      prefix: --no_headers
  - id: separator
    type:
      - 'null'
      - string
    doc: data separator
    inputBinding:
      position: 102
      prefix: --separator
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
    doc: write data to this file
    outputBinding:
      glob: $(inputs.outfile_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/groopm:0.3.4--pyhdfd78af_2
