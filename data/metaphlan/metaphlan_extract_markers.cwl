cwlVersion: v1.2
class: CommandLineTool
baseCommand: extract_markers.py
label: metaphlan_extract_markers
doc: "Extract the marker sequences of the given clades from a MetaPhlAn database into FASTA files.\n\nTool homepage: https://github.com/biobakery/metaphlan"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.output_dir)
        entry: "$({class: 'Directory', basename: inputs.output_dir, listing: []})"
        writable: true
inputs:
  - id: database
    type:
      - 'null'
      - File
    doc: "The input MetaPhlAn database (path to the pkl file; the .fna.bz2 file of the same name must sit beside it)"
    secondaryFiles:
      - pattern: "^.fna.bz2"
        required: false
      - pattern: "^.1.bt2l"
        required: false
      - pattern: "^.2.bt2l"
        required: false
      - pattern: "^.3.bt2l"
        required: false
      - pattern: "^.4.bt2l"
        required: false
      - pattern: "^.rev.1.bt2l"
        required: false
      - pattern: "^.rev.2.bt2l"
        required: false
      - pattern: "^.1.bt2"
        required: false
      - pattern: "^.2.bt2"
        required: false
      - pattern: "^.3.bt2"
        required: false
      - pattern: "^.4.bt2"
        required: false
      - pattern: "^.rev.1.bt2"
        required: false
      - pattern: "^.rev.2.bt2"
        required: false
    inputBinding:
      position: 101
      prefix: "--database"
  - id: clades
    type:
      - 'null'
      - type: array
        items: string
    doc: "The clades to investigate"
    inputBinding:
      position: 101
      prefix: "--clades"
  - id: output_dir
    type: string
    doc: "The output directory (created before the run)"
    inputBinding:
      position: 101
      prefix: "--output_dir"
outputs:
  - id: markers_dir
    type: Directory
    doc: "Output folder with the marker FASTA files"
    outputBinding:
      glob: "$(inputs.output_dir)"
  - id: stdout
    type: stdout
    doc: "Standard output"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaphlan:4.2.4--pyhdfd78af_0
stdout: metaphlan_extract_markers.out
