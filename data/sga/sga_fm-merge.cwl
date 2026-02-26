cwlVersion: v1.2
class: CommandLineTool
baseCommand: sga fm-merge
label: sga_fm-merge
doc: "Merge unambiguously sequences from the READSFILE using the FM-index. This program
  requires filter to be run before it and rmdup to be run after.\n\nTool homepage:
  https://github.com/jts/sga"
inputs:
  - id: readsfile
    type: File
    doc: File containing reads to merge
    inputBinding:
      position: 1
  - id: min_overlap
    type:
      - 'null'
      - int
    doc: minimum overlap required between two reads to merge
    default: 45
    inputBinding:
      position: 102
      prefix: --min-overlap
  - id: prefix
    type:
      - 'null'
      - string
    doc: use PREFIX for the names of the index files
    default: prefix of the input file
    inputBinding:
      position: 102
      prefix: --prefix
  - id: threads
    type:
      - 'null'
      - int
    doc: use NUM worker threads
    default: no threading
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: display verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: write the merged sequences to FILE
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sga:v0.10.15-4-deb_cv1
