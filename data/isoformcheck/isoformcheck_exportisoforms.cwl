cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- IsoformCheck
- exportisoforms
label: isoformcheck_exportisoforms
doc: "Export isoform table\n\nTool homepage: https://github.com/maickrau/IsoformCheck"
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
- id: transcript
  type: ['null', string]
  doc: "Name of transcript. If no transcript is given, all transcripts will be used."
  inputBinding:
    position: 3
    prefix: --transcript
- id: output
  type: ['null', string]
  doc: "Output file name (use - to write to standard output)"
  default: isoforms.tsv
  inputBinding:
    position: 8
    prefix: -o
- id: include_gene_info
  type: ['null', boolean]
  doc: "Include information about gene in the output table."
  inputBinding:
    position: 9
    prefix: --include-gene-info
outputs:
- id: table
  type: ['null', File]
  doc: The output table (absent when the output is written to standard output)
  outputBinding:
    glob: $(inputs.output)
