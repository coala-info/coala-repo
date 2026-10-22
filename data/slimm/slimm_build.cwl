cwlVersion: v1.2
class: CommandLineTool
baseCommand: slimm_build
label: slimm_build
doc: "Build a reduced taxonomic database (.sldb) from a multi-fasta reference file,
  using accession to taxonomy id mapping files and the NCBI taxonomy dump, for SLIMM.\n\nTool
  homepage: https://github.com/seqan/slimm/blob/master/README.md"
inputs:
  - id: fasta_file
    type: File
    doc: A multi-fasta file used as a reference for mapping
    inputBinding:
      position: 100
  - id: accession2taxid_files
    type:
      type: array
      items: File
    doc: One or more accession to taxa id mapping files downloaded from NCBI
    inputBinding:
      position: 101
  - id: names
    type: File
    doc: NCBI's names.dmp file which contains the mapping of taxid to name
    inputBinding:
      position: 1
      prefix: --names
  - id: nodes
    type: File
    doc: NCBI's nodes.dmp file which contains the taxonomic tree
    inputBinding:
      position: 1
      prefix: --nodes
  - id: output_file
    type: string
    default: slimm_db.sldb
    doc: The path to the output file (.sldb)
    inputBinding:
      position: 1
      prefix: --output-file
  - id: batch
    type: ['null', int]
    doc: Maximum number of mapping to load to memory (default 1000000)
    inputBinding:
      position: 1
      prefix: --batch
  - id: verbose
    type: ['null', boolean]
    doc: Enable verbose output
    inputBinding:
      position: 1
      prefix: --verbose
  - id: version_check
    type: ['null', string]
    doc: Turn this option off to disable version update notifications. One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO
    inputBinding:
      position: 1
      prefix: --version-check
outputs:
  - id: database
    type: File
    doc: SLIMM database
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slimm:0.3.4--hd6d6fdc_6
