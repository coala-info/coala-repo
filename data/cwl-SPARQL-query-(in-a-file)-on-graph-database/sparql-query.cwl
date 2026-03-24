#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: [curl, -d]
inputs:
  query_file:
    type: File
    inputBinding:
      position: 1
      prefix: '@'
      separate: false

  endpoint:
    type: string
    inputBinding:
      position: 2
outputs: []
