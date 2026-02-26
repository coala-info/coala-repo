cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedparse
label: bedparse_3putr
doc: "A tool for parsing and manipulating BED files, with various sub-commands for
  specific operations.\n\nTool homepage: https://github.com/tleonardi/bedparse"
inputs:
  - id: sub_command
    type: string
    doc: 'The sub-command to execute. Available options: 3pUTR, 5pUTR, cds, promoter,
      introns, filter, join, gtf2bed, bed12tobed6, convertChr, validateFormat'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedparse:0.2.3--py_0
stdout: bedparse_3putr.out
