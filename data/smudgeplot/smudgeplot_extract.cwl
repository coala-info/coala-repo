cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - smudgeplot
  - extract
label: smudgeplot_extract
doc: "Extract kmer pair sequences from a FastK k-mer database.\n\nTool homepage: https://github.com/KamilSJaron/smudgeplot"
inputs:
  - id: infile
    type: File
    doc: Input FastK database (.ktab) file.
    inputBinding:
      position: 1
  - id: sma
    type: File
    doc: Input annotated k-mer pair file (.sma).
    inputBinding:
      position: 2
  - id: output_pattern
    type:
      - 'null'
      - string
    doc: The pattern used to name the output (kmerpairs).
    inputBinding:
      position: 103
      prefix: -o
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 103
      prefix: -t
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: Directory where all temporary files will be stored
    inputBinding:
      position: 103
      prefix: -tmp
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose mode
    inputBinding:
      position: 103
      prefix: --verbose
  - id: ktab_parts
    type:
      type: array
      items: File
    doc: Hidden part files of the FastK table (.<name>.ktab.1, .<name>.ktab.2, ...) that
      FastK writes next to the .ktab file. They are staged beside the table.
outputs:
  - id: kmer_pair_sequences
    type:
      type: array
      items: File
    doc: Extracted k-mer pair sequences, one text file per smudge (<output pattern>.<smudge>.txt).
    outputBinding:
      glob: $((inputs.output_pattern || 'kmerpairs') + '.*.txt')
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Standard error (progress messages)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.infile)
      - $(inputs.ktab_parts)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smudgeplot:0.5.3--py314h577a1d6_0
stdout: smudgeplot_extract.out
stderr: smudgeplot_extract.err
