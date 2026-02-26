cwlVersion: v1.2
class: CommandLineTool
baseCommand: suvtk_co-occurrence
label: suvtk_co-occurrence
doc: "Identify co-occurring sequences in an abundance table based on specified\n \
  \ thresholds.\n\n  This function reads an abundance table, filters contigs based
  on prevalence,\n  and calculates correlation matrices to identify co-occurring sequences.
  It\n  supports optional segment-specific analysis and contig length correction.\n\
  \nTool homepage: https://github.com/LanderDC/suvtk"
inputs:
  - id: correlation
    type:
      - 'null'
      - float
    doc: Minimum correlation to keep pairs.
    default: 0.5
    inputBinding:
      position: 101
      prefix: --correlation
  - id: input_file
    type: File
    doc: Abundance table file (tsv).
    inputBinding:
      position: 101
      prefix: --input
  - id: lengths_file
    type:
      - 'null'
      - File
    doc: File with the lengths of each contig.
    inputBinding:
      position: 101
      prefix: --lengths
  - id: output_prefix
    type: string
    doc: Prefix for the output name.
    inputBinding:
      position: 101
      prefix: --output
  - id: prevalence
    type:
      - 'null'
      - float
    doc: "Minimum percentage of samples for correlation\n                        \
      \   analysis."
    default: 0.1
    inputBinding:
      position: 101
      prefix: --prevalence
  - id: segments_file
    type:
      - 'null'
      - File
    doc: "File with a list of contigs of interest (often RdRP\n                  \
      \         segments), each on a new line."
    inputBinding:
      position: 101
      prefix: --segments
  - id: strict
    type:
      - 'null'
      - boolean
    doc: "The correlation threshold should be met for all\n                      \
      \     provided segments."
    inputBinding:
      position: 101
      prefix: --strict
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/suvtk:0.1.6--pyh64700be_0
stdout: suvtk_co-occurrence.out
