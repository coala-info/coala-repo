cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - smudgeplot
  - hetmers
label: smudgeplot_hetmers
doc: "Calculate unique kmer pairs from FastK k-mer database.\n\nTool homepage: https://github.com/KamilSJaron/smudgeplot"
inputs:
  - id: infile
    type: File
    doc: Input FastK database (.ktab) file.
    inputBinding:
      position: 1
  - id: count_threshold
    type:
      - 'null'
      - int
    doc: Count threshold below which k-mers are considered erroneous.
    inputBinding:
      position: 102
      prefix: -L
  - id: output_pattern
    type:
      - 'null'
      - string
    doc: The pattern used to name the output (kmerpairs).
    inputBinding:
      position: 102
      prefix: -o
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 102
      prefix: -t
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: Directory where all temporary files will be stored
    inputBinding:
      position: 102
      prefix: -tmp
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode.
    inputBinding:
      position: 102
      prefix: --verbose
  - id: ktab_parts
    type:
      type: array
      items: File
    doc: Hidden part files of the FastK table (.<name>.ktab.1, .<name>.ktab.2, ...) that
      FastK writes next to the .ktab file. They are staged beside the table.
outputs:
  - id: kmer_pairs
    type: File
    doc: Table of k-mer pair coverages (<output pattern>.smu).
    outputBinding:
      glob: $((inputs.output_pattern || 'kmerpairs') + '.smu')
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
stdout: smudgeplot_hetmers.out
stderr: smudgeplot_hetmers.err
