cwlVersion: v1.2
class: CommandLineTool
baseCommand: xmlstarlet
label: xmlstarlet
doc: "XMLStarlet Command Line XML Toolkit is a set of command line utilities which
  can be used to transform, query, validate, and edit XML documents and files.\n\n
  Tool homepage: https://github.com/alexdobin/STAR"
inputs:
  - id: subcommand
    type: string
    doc: The subcommand to execute (ed, sel, tr, val, fo, el, can, ls, py, dep)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xmlstarlet:1.6.1
stdout: xmlstarlet.out
