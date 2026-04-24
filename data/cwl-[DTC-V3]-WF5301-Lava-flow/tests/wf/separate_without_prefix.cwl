#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
baseCommand: echo

inputs:
  src:
    type: string
      string
    inputBinding:
      position: 1
      separate: false

stdout: output.txt

outputs:
  output:
    type: string
    outputBinding:
      glob: output.txt
      loadContents: true
      outputEval: $(self[0].contents)
