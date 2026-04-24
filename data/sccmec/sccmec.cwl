cwlVersion: v1.2
class: CommandLineTool
baseCommand: sccmec-main
label: sccmec
doc: "typing SCCmec cassettes in assemblies\n\nTool homepage: https://github.com/rpetit3/sccmec"
inputs:
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing reports
    inputBinding:
      position: 101
      prefix: --force
  - id: input
    type: File
    doc: Input file in FASTA format to classify
    inputBinding:
      position: 101
      prefix: --input
  - id: min_regions_coverage
    type:
      - 'null'
      - int
    doc: Minimum percent coverage of regions to count a hit
    inputBinding:
      position: 101
      prefix: --min-regions-coverage
  - id: min_regions_pident
    type:
      - 'null'
      - int
    doc: Minimum percent identity of regions to count a hit
    inputBinding:
      position: 101
      prefix: --min-regions-pident
  - id: min_targets_coverage
    type:
      - 'null'
      - int
    doc: Minimum percent coverage of targets to count a hit
    inputBinding:
      position: 101
      prefix: --min-targets-coverage
  - id: min_targets_pident
    type:
      - 'null'
      - int
    doc: Minimum percent identity of targets to count a hit
    inputBinding:
      position: 101
      prefix: --min-targets-pident
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Directory to write output
    inputBinding:
      position: 101
      prefix: --outdir
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix to use for output files
    inputBinding:
      position: 101
      prefix: --prefix
  - id: regions
    type: File
    doc: Query regions in FASTA format
    inputBinding:
      position: 101
      prefix: --regions
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Only critical errors will be printed
    inputBinding:
      position: 101
      prefix: --silent
  - id: targets
    type: File
    doc: Query targets in FASTA format
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
  - id: yaml_regions
    type: File
    doc: YAML file documenting the regions and types
    inputBinding:
      position: 101
      prefix: --yaml-regions
  - id: yaml_targets
    type: File
    doc: YAML file documenting the targets and types
    inputBinding:
      position: 101
      prefix: --yaml-targets
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sccmec:1.2.0--hdfd78af_0
stdout: sccmec.out
