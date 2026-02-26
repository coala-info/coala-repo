cwlVersion: v1.2
class: CommandLineTool
baseCommand: odgi_chop
label: odgi_chop
doc: "Divide nodes into smaller pieces preserving node topology and order.\n\nTool
  homepage: https://github.com/vgteam/odgi"
inputs:
  - id: chop_to
    type: int
    doc: Divide nodes that are longer than *N* base pairs into nodes no longer 
      than *N* while maintaining graph topology.
    inputBinding:
      position: 101
      prefix: --chop-to
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print information about the process to stderr.
    inputBinding:
      position: 101
      prefix: --debug
  - id: idx
    type: File
    doc: Load the succinct variation graph in ODGI format from this *FILE*. The 
      file name usually ends with *.og*. It also accepts GFAv1, but the 
      on-the-fly conversion to the ODGI format requires additional time!
    inputBinding:
      position: 101
      prefix: --idx
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Write the current progress to stderr.
    inputBinding:
      position: 101
      prefix: --progress
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
    doc: Write the chopped succinct variation graph in ODGI format to *FILE*. A 
      file ending of *.og* is recommended.
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
