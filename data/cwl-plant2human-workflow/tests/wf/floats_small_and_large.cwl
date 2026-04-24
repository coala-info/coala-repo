#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
baseCommand: echo
requirements:
  InlineJavascriptRequirement: {}

inputs:
 annotation_prokka_evalue:
   type: float
   inputBinding: {}

 annotation_prokka_evalue2:
   type: float
   inputBinding: {}

 annotation_prokka_evalue3:
   type: float
   inputBinding: {}

 annotation_prokka_evalue4:
   type: float
   inputBinding: {}


arguments: [ -n ]

stdout: dump

outputs:
  result:
    type: string
    outputBinding:
      glob: dump
      loadContents: true
      outputEval: $(self[0].contents)
