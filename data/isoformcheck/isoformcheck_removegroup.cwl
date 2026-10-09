cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- IsoformCheck
- removegroup
label: isoformcheck_removegroup
doc: "Remove a sample from a group\n\nTool homepage: https://github.com/maickrau/IsoformCheck"
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
  doc: "Database folder (required)"
  inputBinding:
    position: 2
    prefix: -db
    valueFrom: $(self.basename)
- id: sample
  type: string
  doc: "Name of sample (required)"
  inputBinding:
    position: 3
    prefix: --sample
- id: group
  type: string
  doc: "Name of group (required)"
  inputBinding:
    position: 4
    prefix: --group
outputs:
- id: database_out
  type: Directory
  doc: The updated database folder
  outputBinding:
    glob: $(inputs.database.basename)
