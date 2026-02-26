cwlVersion: v1.2
class: CommandLineTool
baseCommand: v-test.pl
label: vadr_v-test.pl
doc: "test VADR scripts\n\nTool homepage: https://github.com/ncbi/vadr"
inputs:
  - id: input_test_file
    type: File
    doc: input test file e.g. testfiles/testin.1
    inputBinding:
      position: 1
  - id: output_directory
    type: Directory
    doc: output directory to create
    inputBinding:
      position: 2
  - id: benchmark_mode
    type:
      - 'null'
      - boolean
    doc: 'benchmark mode: compare certain fields, do not diff files'
    inputBinding:
      position: 103
      prefix: -m
  - id: execname
    type:
      - 'null'
      - string
    doc: define executable name of this script
    inputBinding:
      position: 103
      prefix: --execname
  - id: force
    type:
      - 'null'
      - boolean
    doc: if dir <output directory> exists, overwrite it
    inputBinding:
      position: 103
      prefix: -f
  - id: keep
    type:
      - 'null'
      - boolean
    doc: do not remove intermediate files, keep them all on disk
    inputBinding:
      position: 103
      prefix: --keep
  - id: noteamcity
    type:
      - 'null'
      - boolean
    doc: do not output teamcity test info
    inputBinding:
      position: 103
      prefix: --noteamcity
  - id: rmout
    type:
      - 'null'
      - boolean
    doc: if output files listed in testin file already exist, remove them
    inputBinding:
      position: 103
      prefix: --rmout
  - id: skip
    type:
      - 'null'
      - boolean
    doc: skip commands, they were already run, just compare files
    inputBinding:
      position: 103
      prefix: -s
  - id: skipmsg
    type:
      - 'null'
      - boolean
    doc: do not compare errors and warning lines
    inputBinding:
      position: 103
      prefix: --skipmsg
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: be verbose; output commands to stdout as they're run
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vadr:1.6.4--pl5321h031d066_0
stdout: vadr_v-test.pl.out
