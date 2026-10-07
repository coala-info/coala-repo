cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - contigtax
  - format
label: contigtax_format
doc: "Reformat a protein fasta file for contigtax.\n\nTool homepage: https://github.com/NBISweden/contigtax"
inputs:
  - id: fastafile
    type: File
    doc: Specify protein fasta to reformat
    inputBinding:
      position: 1
  - id: reformatted
    type: string
    doc: Path to reformatted fastafile
    inputBinding:
      position: 2
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite of existing reformatted fastafile
    inputBinding:
      position: 103
      prefix: --force
  - id: forceidmap
    type:
      - 'null'
      - boolean
    doc: Force overwrite of existing accession2taxid mapfile
    inputBinding:
      position: 103
      prefix: --forceidmap
  - id: maxidlen
    type:
      - 'null'
      - int
    doc: Maximum allowed length of sequence ids. Defaults to 14 (required by 
      diamond for adding taxonomy info to database). Ids longer than this are 
      written to a file with the original id
    inputBinding:
      position: 103
      prefix: --maxidlen
  - id: taxidmap
    type:
      - 'null'
      - string
    doc: Protein accession to taxid mapfile. For UniRef this file is created 
      from information in the fasta headers and stored in a file named 
      prot.accession2taxid.gz in the same directory as the reformatted fasta 
      file. Specify another path here.
    inputBinding:
      position: 103
      prefix: --taxidmap
  - id: tmpdir
    type:
      - 'null'
      - string
    doc: Temporary directory for writing fasta files
    inputBinding:
      position: 103
      prefix: --tmpdir
outputs:
  - id: reformatted_fasta
    type: File
    doc: Reformatted protein fasta file
    outputBinding:
      glob: $(inputs.reformatted)
  - id: taxidmap_file
    type:
      - 'null'
      - File
    doc: Protein accession to taxid mapfile (prot.accession2taxid.gz by 
      default)
    outputBinding:
      glob: "$(inputs.taxidmap ? inputs.taxidmap : 'prot.accession2taxid.gz')"
  - id: idmap
    type:
      - 'null'
      - File
    doc: File mapping sequence ids longer than --maxidlen to new ids
    outputBinding:
      glob: idmap.tsv.gz
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/contigtax:0.5.10--pyhdfd78af_0
stdout: contigtax_format.out
