cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pantools
  - remove_functions
label: pantools_remove_functions
doc: "Remove functional annotations from the pangenome.\n\nTool homepage: https://git.wur.nl/bioinformatics/pantools"
inputs:
  - id: database_directory
    type: Directory
    doc: Path to the database root directory.
    inputBinding:
      position: 1
  - id: mode
    type:
      - 'null'
      - string
    doc: "Remove function nodes and strip function properties of mRNA nodes (default:
      all).\nnodes: 'GO', 'pfam', 'tigrfam' and 'interpro' nodes.\nproperties: 'COG',
      'phobius' and 'signalp' properties.\nall: combine the 'nodes' and 'properties'
      modes.\nCOG|phobius|signalp: Only remove a specific property."
    default: all
    inputBinding:
      position: 102
      prefix: --mode
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
stdout: pantools_remove_functions.out
