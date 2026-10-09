cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- IsoformCheck
- listgroups
label: isoformcheck_listgroups
doc: "List all groups per samples\n\nTool homepage: https://github.com/maickrau/IsoformCheck"
requirements:
- class: InlineJavascriptRequirement
- class: InitialWorkDirRequirement
  listing:
  - entry: $(inputs.database)
    writable: true
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/isoformcheck:1.0.0--hdfd78af_0
inputs:
- id: verbose
  type: string[]?
  doc: "Print debug information (the option takes zero or more values)"
  inputBinding:
    position: 1
    prefix: --verbose
- id: database
  type: Directory
  doc: "Database folder"
  inputBinding:
    position: 2
    prefix: -db
    valueFrom: $(self.basename)
- id: output
  type: ['null', string]
  doc: "Output file name (use - to write to standard output)"
  default: groups.tsv
  inputBinding:
    position: 8
    prefix: -o
outputs:
- id: table
  type: ['null', File]
  doc: The output table (absent when the output is written to standard output)
  outputBinding:
    glob: $(inputs.output)
