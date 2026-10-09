cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- IsoformCheck
- addsample
label: isoformcheck_addsample
doc: "Add a new sample\n\nTool homepage: https://github.com/maickrau/IsoformCheck"
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
- id: input_sequence
  type: File
  doc: "Sequence file (required)"
  inputBinding:
    position: 2
    prefix: -i
- id: name
  type: string
  doc: "Sample name"
  inputBinding:
    position: 3
    prefix: --name
- id: haplotype
  type: string
  doc: "Sample haplotype (1, 2, mat or pat)"
  inputBinding:
    position: 4
    prefix: --haplotype
- id: database
  type: Directory
  doc: "Database folder"
  inputBinding:
    position: 2
    prefix: -db
    valueFrom: $(self.basename)
- id: liftoff_path
  type: ['null', string]
  doc: "Path to liftoff"
  inputBinding:
    position: 20
    prefix: --liftoff
- id: agc_path
  type: ['null', string]
  doc: "Path to agc"
  inputBinding:
    position: 21
    prefix: --agc
- id: threads
  type: ['null', int]
  doc: "Number of threads"
  inputBinding:
    position: 22
    prefix: -t
outputs:
- id: database_out
  type: Directory
  doc: The updated database folder
  outputBinding:
    glob: $(inputs.database.basename)
