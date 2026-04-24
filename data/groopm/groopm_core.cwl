cwlVersion: v1.2
class: CommandLineTool
baseCommand: groopm core
label: groopm_core
doc: "Load saved data and make bin cores\n\nTool homepage: https://ecogenomics.github.io/GroopM/"
inputs:
  - id: dbname
    type: string
    doc: name of the database to open
    inputBinding:
      position: 1
  - id: bp
    type:
      - 'null'
      - int
    doc: cumulative size of contigs which define a core regardless of number of 
      contigs
    inputBinding:
      position: 102
      prefix: --bp
  - id: cutoff
    type:
      - 'null'
      - int
    doc: cutoff contig size for core creation
    inputBinding:
      position: 102
      prefix: --cutoff
  - id: force
    type:
      - 'null'
      - boolean
    doc: overwrite existing DB file without prompting
    inputBinding:
      position: 102
      prefix: --force
  - id: graphfile
    type:
      - 'null'
      - File
    doc: output graph of micro bin mergers
    inputBinding:
      position: 102
      prefix: --graphfile
  - id: multiplot
    type:
      - 'null'
      - int
    doc: create plots during core creation - (0-3) MAKES MANY IMAGES!
    inputBinding:
      position: 102
      prefix: --multiplot
  - id: plot
    type:
      - 'null'
      - boolean
    doc: create plots of bins after basic refinement
    inputBinding:
      position: 102
      prefix: --plot
  - id: size
    type:
      - 'null'
      - int
    doc: minimum number of contigs which define a core
    inputBinding:
      position: 102
      prefix: --size
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/groopm:0.3.4--pyhdfd78af_2
stdout: groopm_core.out
