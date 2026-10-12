cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pancake
  - addChrom
label: pancake_addChrom
doc: "Add chromosomes to an already existing PanCake Object\n\nTool homepage: https://bitbucket.org/CorinnaErnst/pancake"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.panfile)
        writable: true
inputs:
  - id: panfile
    type: File
    doc: Name of PanCake Data Object File (required)
    inputBinding:
      position: 1
      prefix: --panfile
  - id: sequences
    type:
      - 'null'
      - type: array
        items: File
    doc: fasta or multiple fasta file providing input chromosome sequences
    inputBinding:
      position: 1
      prefix: --sequences
  - id: ids
    type:
      - 'null'
      - type: array
        items: string
    doc: gi ids of sequences to download from NCBI
    inputBinding:
      position: 1
      prefix: --ids
  - id: email
    type:
      - 'null'
      - string
    doc: if downloading your sequences via gi ids, please specify your email address; in case of excessive usage, NCBI will attempt to contact a user at the e-mail address provided prior to blocking access to the E-utilities
    inputBinding:
      position: 1
      prefix: --email
  - id: output_path
    type:
      - 'null'
      - string
    doc: 'output file for new PanCake Object (DEFAULT=PAN_FILE); if specified, PanCake Data Object in PAN_FILE stays unchanged'
    inputBinding:
      position: 1
      prefix: --output
  - id: ali
    type:
      - 'null'
      - type: array
        items: File
    doc: pairwise alignments (BLAST or nucmer output) to include in PanCake Object
    inputBinding:
      position: 1
      prefix: --ali
  - id: min_len
    type:
      - 'null'
      - int
    doc: minimum length of pairwise alignments to include (DEFAULT=25)
    inputBinding:
      position: 1
      prefix: --min_len
  - id: no_self_alignments
    type:
      - 'null'
      - boolean
    doc: if set, skip pairwise alignments between regions on identical chromosomes as input (DEFAULT=False)
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
stdout: pancake_addChrom.out
