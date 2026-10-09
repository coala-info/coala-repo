cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- IsoformCheck
- comparesamples
label: isoformcheck_comparesamples
doc: "Compare samples to database\n\nTool homepage: https://github.com/maickrau/IsoformCheck"
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
- id: database
  type: Directory
  doc: "Database folder (required)"
  inputBinding:
    position: 2
    prefix: -db
    valueFrom: $(self.basename)
- id: table
  type: File
  doc: "Table with novel samples to include (tab separated, columns Sample, Haplotype, Assembly and optionally Annotation)"
  inputBinding:
    position: 3
    prefix: --table
- id: output_prefix
  type: ['null', string]
  doc: "Output prefix (default \"result\")"
  default: result
  inputBinding:
    position: 4
    prefix: -o
- id: threads
  type: ['null', int]
  doc: "Number of threads"
  inputBinding:
    position: 22
    prefix: -t
- id: liftoff_path
  type: ['null', string]
  doc: "Path to liftoff"
  inputBinding:
    position: 20
    prefix: --liftoff
- id: force
  type: ['null', boolean]
  doc: "Force compare samples even if validation fails"
  inputBinding:
    position: 23
    prefix: --force
- id: assemblies
  type: File[]?
  doc: "Haplotype assembly files named in the Assembly column of the sample table"
- id: annotations
  type: File[]?
  doc: "Lifted over annotation files named in the optional Annotation column of the sample table"
outputs:
- id: allelesets
  type: File
  doc: All allele sets of the given novel samples
  outputBinding:
    glob: $(inputs.output_prefix)_allelesets.tsv
- id: novel_isoforms
  type: File
  doc: Isoforms which are novel to the samples and not previously present in the database
  outputBinding:
    glob: $(inputs.output_prefix)_novel_isoforms.tsv
- id: novel_allelesets
  type: File
  doc: Allele sets which are novel to the samples and not previously present in the database
  outputBinding:
    glob: $(inputs.output_prefix)_novel_allelesets.tsv
