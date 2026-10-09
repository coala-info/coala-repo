cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- IsoformCheck
- addsamples
label: isoformcheck_addsamples
doc: "Add multiple new samples\n\nTool homepage: https://github.com/maickrau/IsoformCheck"
requirements:
- class: InlineJavascriptRequirement
- class: InitialWorkDirRequirement
  listing:
  - entry: $(inputs.database)
    writable: true
  - entry: $(inputs.assemblies)
  - entry: $(inputs.annotations)
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
- id: input_table
  type: File
  doc: "Sample table file (required): tab separated with columns Sample, Haplotype, Assembly and optionally Annotation"
  inputBinding:
    position: 2
    prefix: -i
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
- id: force
  type: ['null', boolean]
  doc: "Force insert samples even if validation fails"
  inputBinding:
    position: 23
    prefix: --force
- id: assemblies
  type: File[]?
  doc: "Haplotype assembly files named in the Assembly column of the sample table (staged next to the table paths)"
- id: annotations
  type: File[]?
  doc: "Lifted over annotation files named in the optional Annotation column of the sample table"
outputs:
- id: database_out
  type: Directory
  doc: The updated database folder
  outputBinding:
    glob: $(inputs.database.basename)
