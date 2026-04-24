cwlVersion: v1.2
class: CommandLineTool
baseCommand: favites_lite.py
label: favites_lite_favites_lite.py
doc: "FAVITES-Lite Niema Moshiri 2022\n\nTool homepage: https://github.com/niemasd/FAVITES-Lite"
inputs:
  - id: config
    type: File
    doc: FAVITES-Lite Config File
    inputBinding:
      position: 101
      prefix: --config
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite output directory if it exists
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress Log Messages
    inputBinding:
      position: 101
      prefix: --quiet
  - id: rng_seed
    type:
      - 'null'
      - int
    doc: Random Number Generator Seed
    inputBinding:
      position: 101
      prefix: --rng_seed
outputs:
  - id: output
    type: Directory
    doc: Output Directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/favites_lite:1.0.3--hdfd78af_0
