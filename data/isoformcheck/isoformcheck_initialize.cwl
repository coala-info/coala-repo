cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- IsoformCheck
- initialize
label: isoformcheck_initialize
doc: "Create new database\n\nTool homepage: https://github.com/maickrau/IsoformCheck"
requirements:
- class: InlineJavascriptRequirement
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
- id: reference_genome
  type: File
  doc: "Reference genome file (required)"
  inputBinding:
    position: 2
    prefix: -r
- id: annotation
  type: File
  doc: "Reference annotation gff3 (required)"
  inputBinding:
    position: 3
    prefix: -a
- id: database
  type: string
  doc: "Output database folder"
  inputBinding:
    position: 4
    prefix: -db
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
  doc: The new database folder
  outputBinding:
    glob: $(inputs.database)
