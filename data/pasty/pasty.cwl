cwlVersion: v1.2
class: CommandLineTool
baseCommand: pasty
label: pasty
doc: "In silico serogrouping of Pseudomonas aeruginosa isolates from assemblies,
  using BLAST against the O-antigen (OSA) gene clusters (pasty wraps camlhmp-blast-regions
  with the built-in pa-osa targets).\n\nTool homepage: https://github.com/rpetit3/pasty"
inputs:
  - id: input_fasta
    type: File
    doc: Input file in FASTA format to classify
    inputBinding:
      position: 101
      prefix: --input
  - id: yaml
    type:
      - 'null'
      - File
    doc: YAML file documenting the targets and types (default is the built-in
      pa-osa.yaml)
    inputBinding:
      position: 101
      prefix: --yaml
  - id: targets
    type:
      - 'null'
      - File
    doc: Query targets in FASTA format (default is the built-in pa-osa.fasta)
    inputBinding:
      position: 101
      prefix: --targets
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix to use for output files
    default: camlhmp
    inputBinding:
      position: 101
      prefix: --prefix
  - id: min_pident
    type:
      - 'null'
      - int
    doc: Minimum percent identity to count a hit
    inputBinding:
      position: 101
      prefix: --min-pident
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: Minimum percent coverage to count a hit
    inputBinding:
      position: 101
      prefix: --min-coverage
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing reports
    inputBinding:
      position: 101
      prefix: --force
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase the verbosity of output
    inputBinding:
      position: 101
      prefix: --verbose
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Only critical errors will be printed
    inputBinding:
      position: 101
      prefix: --silent
  - id: outdir_path
    type: string
    doc: Directory to write output
    inputBinding:
      position: 102
      prefix: --outdir
outputs:
  - id: outdir
    type: Directory
    doc: Directory with the serogroup report and the BLAST hits
    outputBinding:
      glob: $(inputs.outdir_path)
  - id: report
    type: File
    doc: Tab-delimited serogroup report
    outputBinding:
      glob: $(inputs.outdir_path + '/' + inputs.prefix + '.tsv')
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pasty:2.2.1--hdfd78af_0
