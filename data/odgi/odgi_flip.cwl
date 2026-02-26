cwlVersion: v1.2
class: CommandLineTool
baseCommand: odgi_flip
label: odgi_flip
doc: "Flip (reverse complement) paths to match the graph.\n\nTool homepage: https://github.com/vgteam/odgi"
inputs:
  - id: idx
    type: File
    doc: Load the succinct variation graph in ODGI format from this *FILE*. The 
      file name usually ends with *.og*. GFA is also supported.
    inputBinding:
      position: 101
      prefix: --idx
  - id: no_flips
    type:
      - 'null'
      - File
    doc: Don't flip paths listed one per line in FILE.
    inputBinding:
      position: 101
      prefix: --no-flips
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Write the current progress to stderr.
    inputBinding:
      position: 101
      prefix: --progress
  - id: ref_flips
    type:
      - 'null'
      - File
    doc: Flip paths to match the orientation of the paths listed one per line in
      FILE.
    inputBinding:
      position: 101
      prefix: --ref-flips
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallel operations.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: out
    type: File
    doc: Write the sorted dynamic succinct variation graph to this file (e.g. 
      *.og*).
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
