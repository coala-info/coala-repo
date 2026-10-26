cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - unicore
  - config
label: unicore_config
doc: |-
  Runtime environment configuration

  Tool homepage: https://github.com/steineggerlab/unicore
inputs:
  - id: check
    type: ['null', boolean]
    doc: "Check current environment configuration"
    inputBinding:
      position: 10
      prefix: --check
  - id: set_mmseqs
    type: ['null', string]
    doc: "Set mmseqs binary path"
    inputBinding:
      position: 10
      prefix: --set-mmseqs
  - id: set_foldseek
    type: ['null', string]
    doc: "Set foldseek binary path"
    inputBinding:
      position: 10
      prefix: --set-foldseek
  - id: set_foldmason
    type: ['null', string]
    doc: "Set foldmason binary path"
    inputBinding:
      position: 10
      prefix: --set-foldmason
  - id: set_mafft
    type: ['null', string]
    doc: "Set mafft binary path"
    inputBinding:
      position: 10
      prefix: --set-mafft
  - id: set_mafft_linsi
    type: ['null', string]
    doc: "Set mafft-linsi binary path"
    inputBinding:
      position: 10
      prefix: --set-mafft-linsi
  - id: set_iqtree
    type: ['null', string]
    doc: "Set iqtree binary path"
    inputBinding:
      position: 10
      prefix: --set-iqtree
  - id: set_fasttree
    type: ['null', string]
    doc: "Set fasttree binary path"
    inputBinding:
      position: 10
      prefix: --set-fasttree
  - id: set_raxml
    type: ['null', string]
    doc: "Set raxml-ng binary path"
    inputBinding:
      position: 10
      prefix: --set-raxml
  - id: verbosity
    type: ['null', int]
    doc: "Verbosity (0: quiet, 1: +errors, 2: +warnings, 3: +info, 4: +debug) (default 3)"
    inputBinding:
      position: 10
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Configuration report
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unicore:1.1.1--h7ef3eeb_0
stdout: unicore_config.out
