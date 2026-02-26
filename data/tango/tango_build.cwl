cwlVersion: v1.2
class: CommandLineTool
baseCommand: tango build
label: tango_build
doc: "Builds the Tango database.\n\nTool homepage: https://github.com/johnne/tango"
inputs:
  - id: fastafile
    type: File
    doc: Specify (reformatted) fasta file
    inputBinding:
      position: 1
  - id: taxonmap
    type: File
    doc: Protein accession to taxid mapfile (must be gzipped)
    inputBinding:
      position: 2
  - id: taxonnodes
    type: File
    doc: nodes.dmp file from NCBI taxonomy database
    inputBinding:
      position: 3
  - id: cpus
    type:
      - 'null'
      - int
    doc: Number of cpus to use when building (defaults to 1)
    default: 1
    inputBinding:
      position: 104
      prefix: --cpus
  - id: dbfile
    type:
      - 'null'
      - File
    doc: Name of diamond database file. Defaults to diamond.dmnd in same 
      directory as the protein fasta file
    inputBinding:
      position: 104
      prefix: --dbfile
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tango:0.5.7--py_0
stdout: tango_build.out
