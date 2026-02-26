cwlVersion: v1.2
class: CommandLineTool
baseCommand: contigtax build
label: contigtax_build
doc: "Builds a Diamond database and taxon mapping for contigs.\n\nTool homepage: https://github.com/NBISweden/contigtax"
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
    dockerPull: quay.io/biocontainers/contigtax:0.5.10--pyhdfd78af_0
stdout: contigtax_build.out
