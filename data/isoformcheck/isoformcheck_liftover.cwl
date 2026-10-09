cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- IsoformCheck
- liftover
label: isoformcheck_liftover
doc: "Lift over annotations to one haplotype\n\nTool homepage: https://github.com/maickrau/IsoformCheck"
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
  doc: "Haplotype sequence file (required)"
  inputBinding:
    position: 2
    prefix: -i
- id: output
  type: string
  doc: "Output annotation file (the name must end with .gff3.gz)"
  inputBinding:
    position: 3
    prefix: -o
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
- id: threads
  type: ['null', int]
  doc: "Number of threads"
  inputBinding:
    position: 22
    prefix: -t
outputs:
- id: annotation_out
  type: File
  doc: The lifted over annotation of the haplotype
  outputBinding:
    glob: $(inputs.output)
