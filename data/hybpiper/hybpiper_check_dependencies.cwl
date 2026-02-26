cwlVersion: v1.2
class: CommandLineTool
baseCommand: hybpiper_check_dependencies
label: hybpiper_check_dependencies
doc: "Checks for external dependencies required by HybPiper.\n\nTool homepage: https://github.com/mossmatters/HybPiper"
inputs:
  - id: bbmap_sh
    type:
      - 'null'
      - boolean
    doc: Check for bbmap.sh dependency
    inputBinding:
      position: 101
  - id: bbmerge_sh
    type:
      - 'null'
      - boolean
    doc: Check for bbmerge.sh dependency
    inputBinding:
      position: 101
  - id: blastx
    type:
      - 'null'
      - boolean
    doc: Check for blastx dependency
    inputBinding:
      position: 101
  - id: bwa
    type:
      - 'null'
      - boolean
    doc: Check for bwa dependency
    inputBinding:
      position: 101
  - id: diamond
    type:
      - 'null'
      - boolean
    doc: Check for diamond dependency
    inputBinding:
      position: 101
  - id: exonerate
    type:
      - 'null'
      - boolean
    doc: Check for exonerate dependency
    inputBinding:
      position: 101
  - id: mafft
    type:
      - 'null'
      - boolean
    doc: Check for mafft dependency
    inputBinding:
      position: 101
  - id: makeblastdb
    type:
      - 'null'
      - boolean
    doc: Check for makeblastdb dependency
    inputBinding:
      position: 101
  - id: parallel
    type:
      - 'null'
      - boolean
    doc: Check for parallel dependency
    inputBinding:
      position: 101
  - id: samtools
    type:
      - 'null'
      - boolean
    doc: Check for samtools dependency
    inputBinding:
      position: 101
  - id: spades_py
    type:
      - 'null'
      - boolean
    doc: Check for spades.py dependency
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hybpiper:2.3.4--pyhdfd78af_0
stdout: hybpiper_check_dependencies.out
