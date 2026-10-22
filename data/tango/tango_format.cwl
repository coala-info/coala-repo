cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tango
  - format
label: tango_format
doc: "Reformat protein fasta files.\n\nTool homepage: https://github.com/johnne/tango"
inputs:
  - id: fastafile
    type: File
    doc: Specify protein fasta to reformat
    inputBinding:
      position: 1
  - id: reformatted
    type: string
    doc: Path to reformatted fastafile (must include a directory, e.g. db/reformatted.fasta.gz; the fasta is read as gzip)
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
  - id: force_idmap
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
    doc: Reformatted protein fasta
    outputBinding:
      glob: $(inputs.reformatted)
  - id: taxid_map_file
    type:
      - 'null'
      - File
    doc: Protein accession to taxid map (prot.accession2taxid.gz in the output directory unless --taxidmap is given)
    outputBinding:
      glob: |
        ${ if (inputs.taxidmap) { return inputs.taxidmap; }
           var i = inputs.reformatted.lastIndexOf('/');
           return (i >= 0 ? inputs.reformatted.substring(0, i) : '.') + '/prot.accession2taxid.gz'; }
  - id: long_id_map
    type:
      - 'null'
      - File
    doc: Original ids and new ids of sequences with ids longer than --maxidlen
    outputBinding:
      glob: |
        ${ var i = inputs.reformatted.lastIndexOf('/');
           return (i >= 0 ? inputs.reformatted.substring(0, i) : '.') + '/idmap.tsv.gz'; }
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tango:0.5.7--py_0
stdout: tango_format.out
