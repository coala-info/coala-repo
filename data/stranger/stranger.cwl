cwlVersion: v1.2
class: CommandLineTool
baseCommand: stranger
label: stranger
doc: "Stranger is a tool for annotating STR (Short Tandem Repeat) variants in VCF
  files with information about repeat expansions and their clinical significance.\n\
  \ \nTool homepage: https://github.com/moonso/stranger"
inputs:
  - id: vcf
    type: File
    doc: VCF with STR variants (ExpansionHunter or TRGT)
    inputBinding:
      position: 1
  - id: repeats_file
    type:
      - 'null'
      - File
    doc: Path to a file with repeat definitions (default is the GRCh37 variant catalog packaged with stranger)
    inputBinding:
      position: 101
      prefix: --repeats-file
  - id: family_id
    type:
      - 'null'
      - string
    doc: Family id to add to the output
    inputBinding:
      position: 101
      prefix: --family_id
  - id: trgt
    type:
      - 'null'
      - boolean
    doc: File was produced with TRGT
    inputBinding:
      position: 101
      prefix: --trgt
  - id: loglevel
    type:
      - 'null'
      - string
    doc: Set the level of log output (DEBUG, INFO, WARNING, ERROR, CRITICAL).
    inputBinding:
      position: 101
      prefix: --loglevel
outputs:
  - id: annotated_vcf
    type: stdout
    doc: Annotated VCF written to standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stranger:0.10.0--pyhdfd78af_0
stdout: stranger.annotated.vcf
