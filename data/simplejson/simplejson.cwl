cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - python
  - -m
  - simplejson.tool
label: simplejson
doc: "Validate and pretty-print JSON with simplejson (python -m simplejson.tool). Reads
  the input file, or standard input when no file is given, and writes the indented
  JSON to the output file or standard output.\n\nTool homepage: https://github.com/simplejson/simplejson"
inputs:
  - id: infile
    type: File
    doc: The JSON file to be read.
    inputBinding:
      position: 1
  - id: outfile_name
    type: string
    doc: The file to write the pretty-printed JSON to.
    inputBinding:
      position: 2
outputs:
  - id: outfile
    type: File
    doc: The pretty-printed JSON file.
    outputBinding:
      glob: $(inputs.outfile_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/simplejson:3.8.1--py35_0
