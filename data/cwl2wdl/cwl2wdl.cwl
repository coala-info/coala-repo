cwlVersion: v1.2
class: CommandLineTool
baseCommand: cwl2wdl
label: cwl2wdl
doc: "Convert CWL files to WDL or AST.\n\nTool homepage: https://github.com/adamstruck/cwl2wdl"
inputs:
  - id: file
    type: File
    doc: CWL file.
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: dependencies
    type:
      - 'null'
      - type: array
        items: File
    doc: CWL files the main file imports or runs (tools of a workflow), staged 
      beside it so relative references resolve.
  - id: format
    type:
      - 'null'
      - string
    doc: specify the output format
    inputBinding:
      position: 102
      prefix: --format
  - id: validate
    type:
      - 'null'
      - boolean
    doc: validate the resulting WDL code with PyWDL
    inputBinding:
      position: 102
      prefix: --validate
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |-
      ${
        var l = [inputs.file];
        if (inputs.dependencies) { l = l.concat(inputs.dependencies); }
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cwl2wdl:0.1dev44--py36_1
stdout: cwl2wdl.out
