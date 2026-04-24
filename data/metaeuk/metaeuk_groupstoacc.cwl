cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaeuk groupstoacc
label: metaeuk_groupstoacc
doc: "Replace the internal contig, target and strand identifiers with accessions from
  the headers\n\nTool homepage: https://github.com/soedinglab/metaeuk"
inputs:
  - id: contigsDB
    type: File
    doc: Input contigs database
    inputBinding:
      position: 1
  - id: targetsDB
    type: File
    doc: Input targets database
    inputBinding:
      position: 2
  - id: predToCall
    type: File
    doc: Input prediction to call file
    inputBinding:
      position: 3
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU-cores used (all by default)
    inputBinding:
      position: 104
      prefix: --threads
  - id: verbosity_level
    type:
      - 'null'
      - int
    doc: 'Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info'
    inputBinding:
      position: 104
      prefix: -v
outputs:
  - id: predToCallInfoTSV
    type: File
    doc: Output prediction to call info TSV file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaeuk:7.bba0d80--pl5321hd6d6fdc_2
