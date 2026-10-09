cwlVersion: v1.2
class: CommandLineTool
baseCommand: hmmfetch
label: hmmer_hmmfetch
doc: "retrieve profile HMM(s) from a file\n\nTool homepage: http://hmmer.org/"
inputs:
  - id: hmmfile
    type: File
    doc: Input profile HMM file
    inputBinding:
      position: 201
  - id: key
    type:
      - 'null'
      - string
      - File
    doc: Name of the HMM to retrieve, or with keyfile mode (-f) a file of names to retrieve; not used with --index
    inputBinding:
      position: 202
  - id: keyfile_mode
    type:
      - 'null'
      - boolean
    doc: 'second cmdline arg is a file of names to retrieve'
    inputBinding:
      position: 103
      prefix: '-f'
  - id: output_file
    type:
      - 'null'
      - string
    doc: 'output HMM to file <f> instead of stdout'
    inputBinding:
      position: 103
      prefix: '-o'
  - id: output_key_name
    type:
      - 'null'
      - boolean
    doc: 'output HMM to file named <key>'
    inputBinding:
      position: 103
      prefix: '-O'
  - id: index
    type:
      - 'null'
      - boolean
    doc: 'index the <hmmfile>, creating <hmmfile>.ssi'
    inputBinding:
      position: 103
      prefix: '--index'
outputs:
  - id: fetched
    type: stdout
    doc: Retrieved HMM(s) written to standard output (empty when -o or -O is used)
  - id: out_output_file
    type:
      - 'null'
      - File
    doc: output HMM to file <f> instead of stdout
    outputBinding:
      glob: $(inputs.output_file)
  - id: ssi_index
    type:
      - 'null'
      - File
    doc: SSI index created by --index
    outputBinding:
      glob: $(inputs.hmmfile.basename).ssi
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.hmmfile)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmmer:3.4--hb6cb901_4
stdout: hmmer_hmmfetch.out
