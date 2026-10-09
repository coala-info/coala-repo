cwlVersion: v1.2
class: CommandLineTool
baseCommand: hmmpress
label: hmmer_hmmpress
doc: "prepare an HMM database for faster hmmscan searches\n\nTool homepage: http://hmmer.org/"
inputs:
  - id: hmmfile
    type: File
    doc: HMM database file to be pressed
    inputBinding:
      position: 201
  - id: force
    type:
      - 'null'
      - boolean
    doc: 'force: overwrite any previous pressed files'
    inputBinding:
      position: 102
      prefix: -f
outputs:
  - id: pressed_hmmfile
    type: File
    doc: HMM database with the pressed binary files (.h3f, .h3i, .h3m, .h3p)
    outputBinding:
      glob: $(inputs.hmmfile.basename)
    secondaryFiles:
      - .h3f
      - .h3i
      - .h3m
      - .h3p
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.hmmfile)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmmer:3.4--hb6cb901_4
stdout: hmmer_hmmpress.out
