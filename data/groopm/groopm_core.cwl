cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - groopm
  - core
label: groopm_core
doc: "Load saved data and make bin cores\n\nTool homepage: https://ecogenomics.github.io/GroopM/"
inputs:
  - id: database
    type: File
    doc: GroopM database file to open (created by groopm parse) and modified in place
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
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
      - string
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
  - id: graph_out
    type:
      - 'null'
      - File
    doc: Graph of micro bin mergers
    outputBinding:
      glob: $(inputs.graphfile)
  - id: database_out
    type: File
    doc: The GroopM database after the command ran (updated in place)
    outputBinding:
      glob: $(inputs.database.basename)
  - id: stdout
    type: stdout
    doc: Standard output
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
stdout: groopm_core.out
