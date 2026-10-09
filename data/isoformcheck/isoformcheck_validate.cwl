cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- IsoformCheck
- validate
label: isoformcheck_validate
doc: "Check sample haplotype validity\n\nTool homepage: https://github.com/maickrau/IsoformCheck"
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
stderr: validation_report.txt
outputs:
- id: validation_report
  type: stderr
  doc: Validation messages (the tool prints them to standard error)
