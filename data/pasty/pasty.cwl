cwlVersion: v1.2
class: CommandLineTool
baseCommand: camlhmp-blast-regions
label: pasty
doc: "Classify assemblies using BLAST against larger genomic regions\n\nTool homepage:
  https://github.com/rpetit3/pasty"
inputs:
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing reports
    inputBinding:
      position: 101
      prefix: --force
  - id: input_file
    type: File
    doc: Input file in FASTA format to classify
    inputBinding:
      position: 101
      prefix: --input
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: Minimum percent coverage to count a hit
    default: 95
    inputBinding:
      position: 101
      prefix: --min-coverage
  - id: min_pident
    type:
      - 'null'
      - int
    doc: Minimum percent identity to count a hit
    default: 95
    inputBinding:
      position: 101
      prefix: --min-pident
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Directory to write output
    default: ./
    inputBinding:
      position: 101
      prefix: --outdir
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Prefix to use for output files
    default: camlhmp
    inputBinding:
      position: 101
      prefix: --prefix
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Only critical errors will be printed
    inputBinding:
      position: 101
      prefix: --silent
  - id: targets_file
    type: File
    doc: Query targets in FASTA format
    default: /usr/local/bin/../share/pasty/pa-osa.fasta
    inputBinding:
      position: 101
      prefix: --targets
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase the verbosity of output
    inputBinding:
      position: 101
      prefix: --verbose
  - id: yaml_file
    type: File
    doc: YAML file documenting the targets and types
    default: /usr/local/bin/../share/pasty/pa-osa.yaml
    inputBinding:
      position: 101
      prefix: --yaml
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pasty:2.2.1--hdfd78af_0
stdout: pasty.out
