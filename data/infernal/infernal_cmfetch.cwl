cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cmfetch
label: infernal_cmfetch
doc: "retrieve CMs from a file\n\nTool homepage: http://eddylab.org/infernal"
inputs:
  - id: cmfile
    type: File
    doc: Covariance model file (indexed with --index first if it is large)
    inputBinding:
      position: 200
  - id: key
    type:
      - 'null'
      - string
    doc: Name (or accession) of the CM to retrieve
    inputBinding:
      position: 201
  - id: keyfile
    type:
      - 'null'
      - File
    doc: With -f, file of CM names to retrieve (one per line)
    inputBinding:
      position: 201
  - id: keys_from_file
    type:
      - 'null'
      - boolean
    doc: 'second cmdline arg is a file of names to retrieve'
    inputBinding:
      position: 101
      prefix: -f
  - id: outfile
    type:
      - 'null'
      - string
    doc: output CM to file <f> instead of stdout
    inputBinding:
      position: 101
      prefix: -o
  - id: out_named
    type:
      - 'null'
      - boolean
    doc: output CM to file named <key>
    inputBinding:
      position: 101
      prefix: -O
  - id: index
    type:
      - 'null'
      - boolean
    doc: index the <cmfile>, creating <cmfile>.ssi
    inputBinding:
      position: 101
      prefix: --index
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (the retrieved CM unless -o or -O is used)
  - id: output_outfile
    type:
      - 'null'
      - File
    doc: CM written with -o
    outputBinding:
      glob: $(inputs.outfile)
  - id: output_named
    type:
      - 'null'
      - File
    doc: CM written with -O to a file named after the key
    outputBinding:
      glob: $(inputs.key)
  - id: ssi_index
    type:
      - 'null'
      - File
    doc: SSI index written beside the CM file with --index
    outputBinding:
      glob: $(inputs.cmfile.basename).ssi
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.cmfile)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/infernal:1.1.5--pl5321h7b50bb2_4
stdout: infernal_cmfetch.out
