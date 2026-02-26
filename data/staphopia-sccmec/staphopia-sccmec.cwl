cwlVersion: v1.2
class: CommandLineTool
baseCommand: staphopia-sccmec
label: staphopia-sccmec
doc: "Determine SCCmec Type/SubType\n\nTool homepage: https://github.com/staphopia/staphopia-sccmec"
inputs:
  - id: assembly
    type:
      - 'null'
      - string
    doc: Input assembly (FASTA format), directory of assemblies to predict 
      SCCmec. (Cannot be used with --staphopia)
    inputBinding:
      position: 101
      prefix: --assembly
  - id: citation
    type:
      - 'null'
      - boolean
    doc: Print citation information for using Staphopia SCCmec
    inputBinding:
      position: 101
      prefix: --citation
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print debug related text.
    inputBinding:
      position: 101
      prefix: --debug
  - id: depends
    type:
      - 'null'
      - boolean
    doc: Verify dependencies are installed/found.
    inputBinding:
      position: 101
      prefix: --depends
  - id: ext
    type:
      - 'null'
      - string
    doc: Extension used by assemblies.
    default: fna
    inputBinding:
      position: 101
      prefix: --ext
  - id: hamming
    type:
      - 'null'
      - boolean
    doc: Report the hamming distance of each type.
    inputBinding:
      position: 101
      prefix: --hamming
  - id: json
    type:
      - 'null'
      - boolean
    doc: 'Report the output as JSON (Default: tab-delimited)'
    default: tab-delimited
    inputBinding:
      position: 101
      prefix: --json
  - id: sccmec_data
    type:
      - 'null'
      - Directory
    doc: Directory where SCCmec reference data is stored
    default: /usr/local/share/staphopia-sccmec/data
    inputBinding:
      position: 101
      prefix: --sccmec
  - id: staphopia_dir
    type:
      - 'null'
      - Directory
    doc: Input directory of samples processed by Staphopia. (Cannot be used with
      --assembly)
    inputBinding:
      position: 101
      prefix: --staphopia
  - id: test
    type:
      - 'null'
      - boolean
    doc: Run with example test data.
    inputBinding:
      position: 101
      prefix: --test
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/staphopia-sccmec:1.0.0--hdfd78af_0
stdout: staphopia-sccmec.out
