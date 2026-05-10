cwlVersion: v1.2
class: CommandLineTool
baseCommand: odgi_crush
label: odgi_crush
doc: "Replaces runs of Ns with single Ns (for example, ANNNT becomes ANT).\n\nTool
  homepage: https://github.com/vgteam/odgi"
inputs:
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
  - id: out_path
    type: string
    doc: Output or path parameter `out_path`
    inputBinding:
      position: 102
      prefix: --out
outputs:
  - id: out
    type: File
    doc: Write the N-crushed succinct variation graph in ODGI format to *FILE*. 
      A file ending of *.og* is recommended.
    outputBinding:
      glob: $(inputs.out_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
