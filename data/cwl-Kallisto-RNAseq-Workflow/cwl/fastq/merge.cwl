#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

label: "FASTQ merge tool"

doc: |
    Performs a cat on multiple sets of files

requirements:
 - class: InlineJavascriptRequirement

baseCommand: "cat"

stdout: $(inputs.identifier)

inputs:
  identifier:
    type: string
    doc: Name of the output file
    label: output file name
  files:
      type: File[]
      doc: file list to be concatenated
      label: file list
      inputBinding:
        position: 100

outputs:
  output_file:
    type: stdout


s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-8172-8981
    s:email: mailto:jasper.koehorst@wur.nl
    s:name: Jasper Koehorst
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9524-5964
    s:email: mailto:bart.nijsse@wur.nl
    s:name: Bart Nijsse

s:citation: https://m-unlock.nl
s:codeRepository: https://gitlab.com/m-unlock/cwl
s:dateCreated: "2020-00-00"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/