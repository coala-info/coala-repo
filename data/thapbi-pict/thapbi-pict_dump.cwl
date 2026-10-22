cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - thapbi_pict
  - dump
label: thapbi-pict_dump
doc: "Export a marker database to a text file.\n\nTool homepage: https://github.com/peterjc/thapbi-pict"
inputs:
  - id: database
    type:
      - 'null'
      - File
    doc: "Marker database to use, default '-' for bundled DB."
    inputBinding:
      position: 101
      prefix: -d
  - id: output
    type:
      - 'null'
      - string
    doc: "File to write to (default '-' meaning stdout)"
    inputBinding:
      position: 101
      prefix: -o
  - id: marker
    type:
      - 'null'
      - string
    doc: "Which amplicon marker from the DB wanted? Default all. Recommend for minimal and FASTA output."
    inputBinding:
      position: 101
      prefix: -k
  - id: minimal
    type:
      - 'null'
      - boolean
    doc: "Minimal output, one record per trimmed sequence with MD5 and species list - rather than all entries with original ID, species, and taxid."
    inputBinding:
      position: 101
      prefix: -m
  - id: format
    type:
      - 'null'
      - string
    doc: "Format to write out: txt (default, for debugging) or fasta."
    inputBinding:
      position: 101
      prefix: -f
  - id: genus
    type:
      - 'null'
      - string
    doc: "Which genus (or genera) to export (comma separated list). Default is not to filter by genus."
    inputBinding:
      position: 101
      prefix: -g
  - id: species
    type:
      - 'null'
      - string
    doc: "Which species to export (comma separated list). Requires a single genus argument be given."
    inputBinding:
      position: 101
      prefix: -s
  - id: sep
    type:
      - 'null'
      - string
    doc: "FASTA description entry separator, default semi-colon."
    inputBinding:
      position: 101
      prefix: --sep
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Verbose logging."
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Exported database"
    outputBinding:
      glob: $(inputs.output)
  - id: log
    type: stdout
    doc: "Standard output when no output file is given"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/thapbi-pict:1.0.21--pyhdfd78af_0
stdout: thapbi-pict_dump.out
