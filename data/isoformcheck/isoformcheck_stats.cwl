cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- IsoformCheck
- stats
label: isoformcheck_stats
doc: "Print basic statistics about database\n\nTool homepage: https://github.com/maickrau/IsoformCheck"
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
stdout: stats.txt
outputs:
- id: statistics
  type: stdout
  doc: Basic statistics about the database
