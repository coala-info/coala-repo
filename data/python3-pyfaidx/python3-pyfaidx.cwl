cwlVersion: v1.2
class: CommandLineTool
baseCommand: faidx
label: python3-pyfaidx
doc: The provided text is a Docker system error ('no space left on device') and 
  does not contain the help documentation for the tool. Below is the standard 
  interface for the 'faidx' command provided by the python3-pyfaidx package.
inputs:
  - id: fasta_file
    type: File
    doc: FASTA file to index or query
    inputBinding:
      position: 1
  - id: regions
    type:
      - 'null'
      - type: array
        items: string
    doc: Space separated list of regions (e.g. chr1:1-100)
    inputBinding:
      position: 2
  - id: complement
    type:
      - 'null'
      - boolean
    doc: Complement the sequence
    inputBinding:
      position: 103
      prefix: --complement
  - id: delimiter
    type:
      - 'null'
      - string
    doc: Delimiter for output fields
    inputBinding:
      position: 103
      prefix: --delimiter
  - id: index
    type:
      - 'null'
      - boolean
    doc: Create an index file (.fai)
    inputBinding:
      position: 103
      prefix: --index
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: Reverse the sequence
    inputBinding:
      position: 103
      prefix: --reverse
  - id: size
    type:
      - 'null'
      - boolean
    doc: Return only the size of the sequence
    inputBinding:
      position: 103
      prefix: --size
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Write output to file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/python3-pyfaidx:v0.4.8.1-1-deb_cv1
