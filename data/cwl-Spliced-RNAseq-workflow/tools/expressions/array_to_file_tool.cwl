cwlVersion: v1.2
class: CommandLineTool
requirements:
  - class: InlineJavascriptRequirement

label: Convert an array of 1 file to a file object
doc: |
  Converts the array and returns the first file in the array. 
  Should only be used when 1 file is in the array.

inputs:
  files: 
    type: File[]

baseCommand: [mv]

arguments:
  - valueFrom: $(inputs.files[0].path)
    position: 1
  - valueFrom: "./"
    position: 2

outputs:
  file:
    type: File
    outputBinding:
      glob: $(inputs.files[0].basename)
