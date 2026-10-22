cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - thapbi_pict
  - fasta-nr
label: thapbi-pict_fasta-nr
doc: "Prepare non-redundant FASTA file using MD5 naming.\n\nTool homepage: https://github.com/peterjc/thapbi-pict"
inputs:
  - id: input
    type:
      - 'null'
      - type: array
        items: File
    doc: "One or more FASTA files."
    inputBinding:
      position: 101
      prefix: -i
  - id: ignore_prefixes
    type:
      - 'null'
      - type: array
        items: string
    doc: "One or more filename prefixes to ignore, default Undetermined_ unknown_"
    inputBinding:
      position: 101
      prefix: --ignore-prefixes
  - id: revcomp
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: -r
    doc: "One or more FASTA files as input to be reverse-complemented on loading."
    inputBinding:
      position: 101
  - id: output
    type:
      - 'null'
      - string
    doc: "Single output filename, '-' for stdout (default)."
    inputBinding:
      position: 101
      prefix: -o
  - id: abundance
    type:
      - 'null'
      - int
    doc: "Minimum abundance to require before outputting a sequence. Default no minimum."
    inputBinding:
      position: 101
      prefix: -a
  - id: minlen
    type:
      - 'null'
      - int
    doc: "Minimum length sequence to accept (default 100)."
    inputBinding:
      position: 101
      prefix: --minlen
  - id: maxlen
    type:
      - 'null'
      - int
    doc: "Maximum length sequence to accept (default 1000)."
    inputBinding:
      position: 101
      prefix: --maxlen
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
    doc: "Non-redundant FASTA file"
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
stdout: thapbi-pict_fasta-nr.out
