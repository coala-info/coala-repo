cwlVersion: v1.2
class: CommandLineTool
baseCommand: magetab_insert_array.pl
label: magetab-curation-scripts_magetab_insert_array.pl
doc: "You must specify an ADF filename.\n\nTool homepage: https://github.com/ebi-gene-expression-group/perl-curation-scripts"
inputs:
  - id: accession
    type:
      - 'null'
      - string
    doc: Desired accession for this array design. If not provided will use next 
      available accession from Submissions Tracking database.
    inputBinding:
      position: 101
      prefix: --accession
  - id: clobber
    type:
      - 'null'
      - boolean
    doc: Replace existing files without prompting.
    inputBinding:
      position: 101
      prefix: --clobber
  - id: file
    type: File
    doc: Name of array design file.
    inputBinding:
      position: 101
      prefix: --file
  - id: login
    type:
      - 'null'
      - string
    doc: Submitter user name. If not provided, will use fg_cur.
    inputBinding:
      position: 101
      prefix: --login
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/magetab-curation-scripts:1.1.0--hdfd78af_0
stdout: magetab-curation-scripts_magetab_insert_array.pl.out
