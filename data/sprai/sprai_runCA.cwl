cwlVersion: v1.2
class: CommandLineTool
baseCommand: runCA
label: sprai_runCA
doc: "CA formatted fragment file\n\nTool homepage: http://zombie.cb.k.u-tokyo.ac.jp/sprai/"
inputs:
  - id: fragment_files
    type:
      - 'null'
      - type: array
        items: File
    doc: CA formatted fragment file
    inputBinding:
      position: 1
  - id: output_prefix
    type: string
    doc: Use <prefix> as the output prefix.
    inputBinding:
      position: 102
      prefix: -p
  - id: spec_file
    type:
      - 'null'
      - string
    doc: "Read options from the specifications file <specfile>.\n                \
      \      <specfile> can also be one of the following key words:\n            \
      \          [no]OBT - run with[out] OBT\n                      noVec   - run
      with OBT but without Vector"
    inputBinding:
      position: 102
      prefix: -s
  - id: working_directory
    type: Directory
    doc: Use <dir> as the working directory.
    inputBinding:
      position: 102
      prefix: -d
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sprai:0.9.9.23--py27pl5.22.0_0
stdout: sprai_runCA.out
