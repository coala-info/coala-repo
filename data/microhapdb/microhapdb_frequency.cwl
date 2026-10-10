cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - microhapdb
  - frequency
label: microhapdb_frequency
doc: "Retrieve population allele frequencies\n\nTool homepage: https://github.com/bioforensics/MicroHapDB/"
inputs:
  - id: format
    type:
      - 'null'
      - string
    doc: 'Output format: table, mhpl8r or efm.'
    inputBinding:
      position: 101
      prefix: --format
  - id: marker
    type:
      - 'null'
      - type: array
        items: string
    doc: Restrict frequencies by marker (one or more identifiers).
    inputBinding:
      position: 101
      prefix: --marker
  - id: panel
    type:
      - 'null'
      - File
    doc: Restrict frequencies to markers listed in FILE, one ID per line.
    inputBinding:
      position: 101
      prefix: --panel
  - id: population
    type:
      - 'null'
      - type: array
        items: string
    doc: Restrict frequencies by population (one or more identifiers).
    inputBinding:
      position: 101
      prefix: --population
  - id: allele
    type:
      - 'null'
      - string
    doc: Restrict frequencies by allele.
    inputBinding:
      position: 101
      prefix: --allele
outputs:
  - id: result
    type: stdout
    doc: Allele frequencies (standard output).
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/microhapdb:0.12--pyhdfd78af_0
stdout: microhapdb_frequency.out
