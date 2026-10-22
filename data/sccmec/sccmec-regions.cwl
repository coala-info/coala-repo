cwlVersion: v1.2
class: CommandLineTool
baseCommand: sccmec-regions
label: sccmec-regions
doc: "Classify SCCmec cassettes in assemblies using BLAST against larger genomic regions\n\nTool homepage: https://github.com/rpetit3/sccmec"
inputs:
  - id: input
    type: File
    doc: Input file in FASTA format to classify
    inputBinding:
      position: 101
      prefix: --input
  - id: yaml
    type:
      - 'null'
      - File
    doc: YAML file documenting the regions and types
    inputBinding:
      position: 101
      prefix: --yaml
  - id: targets
    type:
      - 'null'
      - File
    doc: Query targets (regions) in FASTA format
    inputBinding:
      position: 101
      prefix: --targets
  - id: outdir
    type:
      - 'null'
      - string
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
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: prefix_files
    type:
      type: array
      items: File
    doc: Files written with the prefix given in prefix
    outputBinding:
      glob: "$((inputs.prefix ? inputs.prefix : 'camlhmp') + '*')"
  - id: outdir_dir
    type:
      - 'null'
      - Directory
    doc: Directory to write output
    outputBinding:
      glob: $(inputs.outdir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sccmec:1.2.0--hdfd78af_0
stdout: sccmec-regions.out
