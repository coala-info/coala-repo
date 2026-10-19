cwlVersion: v1.2
class: CommandLineTool
baseCommand: remock
label: recentrifuge_remock
doc: "Generate mock samples for Recentrifuge\n\nThe mock layout files (.mck) are
  staged in the working directory, so the generated .out files are written there.
  An Excel layout file is staged in the folder mock_xcel and its samples are written
  to that folder.\n\nTool homepage: https://github.com/khyox/recentrifuge"
inputs:
  - id: file
    type:
      - 'null'
      - File
    doc: 'Explicit source: Centrifuge output file as source'
    inputBinding:
      position: 101
      prefix: --file
  - id: random
    type:
      - 'null'
      - int
    doc: Random score generated. Please provide the minimum hit length (mhl) of
      the classification; 15 by default
    inputBinding:
      position: 102
      prefix: --random
  - id: debug
    type:
      - 'null'
      - boolean
    doc: increase output verbosity and perform additional checks
    inputBinding:
      position: 103
      prefix: --debug
  - id: mock
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --mock
          valueFrom: $(self.basename)
    doc: Mock files (.mck) to be read for the mock Centrifuge sequences layout.
      Multiple files include several samples.
    inputBinding:
      position: 104
  - id: xcel
    type:
      - 'null'
      - File
    doc: Excel file with the mock layout.
    inputBinding:
      position: 105
      prefix: --xcel
      valueFrom: mock_xcel/$(self.basename)
  - id: test
    type:
      - 'null'
      - boolean
    doc: generate mock data ready for testing Recentrifuge
    inputBinding:
      position: 106
      prefix: --test
  - id: nodespath
    type:
      - 'null'
      - Directory
    doc: path for the nodes information files (nodes.dmp and names.dmp from NCBI)
    inputBinding:
      position: 107
      prefix: --nodespath
  - id: compress
    type:
      - 'null'
      - boolean
    doc: Any generated FASTQ file will be gzipped
    inputBinding:
      position: 108
      prefix: --compress
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: mock_outputs
    type:
      type: array
      items: File
    doc: Generated mock Centrifuge output files and test FASTQ files
    outputBinding:
      glob:
        - '*.out'
        - mock_xcel/*.out
        - rcf_test/*
        - '*.fastq*'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.mock)
      - entryname: '$(inputs.xcel === null ? "__no_xcel__" : "mock_xcel/" + inputs.xcel.basename)'
        entry: '$(inputs.xcel === null ? "" : inputs.xcel)'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/recentrifuge:2.1.1--pyhdfd78af_0
stdout: recentrifuge_remock.log
