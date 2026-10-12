cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pancake
  - addAli
label: pancake_addAli
doc: "Include information from pairwise (BLAST or nucmer) alignments into an already existing PanCake Object\n\nTool homepage: https://bitbucket.org/CorinnaErnst/pancake"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.panfile)
        writable: true
inputs:
  - id: ali_files
    type:
      type: array
      items: File
    doc: Alignment files (BLAST or nucmer output)
    inputBinding:
      position: 2
  - id: panfile
    type: File
    doc: Name of PanCake Data Object File (required)
    inputBinding:
      position: 1
      prefix: --panfile
  - id: output_path
    type:
      - 'null'
      - string
    doc: 'output pangenome file (PAN_FILE will be unchanged)'
    inputBinding:
      position: 1
      prefix: --output
  - id: min_len
    type:
      - 'null'
      - int
    doc: minimum length of pairwise alignments to get included (DEFAULT=25)
    inputBinding:
      position: 1
      prefix: --min_len
  - id: no_self_alignments
    type:
      - 'null'
      - boolean
    doc: if set, skip pairwise alignments between regions on identical chromosomes (DEFAULT=False)
    inputBinding:
      position: 1
      prefix: --no_self_alignments
outputs:
  - id: new_panfile
    type: File
    doc: The new PanCake Object (output_path if given, otherwise the PAN_FILE)
    outputBinding:
      glob: "$(inputs.output_path ? inputs.output_path : inputs.panfile.basename)"
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pancake:1.1.2--py35_0
stdout: pancake_addAli.out
