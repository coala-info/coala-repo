cwlVersion: v1.2
class: CommandLineTool
baseCommand: newProg
label: ucsc-newprog_newProg
doc: "make a new C source skeleton.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: prog_name
    type: string
    doc: Name of the program to create
    inputBinding:
      position: 1
  - id: description_words
    type:
      type: array
      items: string
    doc: Description words for the program
    inputBinding:
      position: 2
  - id: create_cgi_script
    type:
      - 'null'
      - boolean
    doc: create shell of a CGI script for web
    inputBinding:
      position: 103
      prefix: -cgi
  - id: include_jkhgap_mysql_jkweb
    type:
      - 'null'
      - boolean
    doc: include jkhgap.a and mysql libraries as well as jkweb.a archives
    inputBinding:
      position: 103
      prefix: -jkhgap
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-newprog:482--h0b57e2e_0
stdout: ucsc-newprog_newProg.out
