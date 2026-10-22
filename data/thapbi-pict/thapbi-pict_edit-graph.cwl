cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - thapbi_pict
  - edit-graph
label: thapbi-pict_edit-graph
doc: "Draw network graph of marker sequences using edit distance.\n\nTool homepage: https://github.com/peterjc/thapbi-pict"
inputs:
  - id: database
    type:
      - 'null'
      - File
      - string
    doc: "Marker database to use, default '-' for bundled DB. Used for labels and colors. Give an empty string to mean no DB."
    inputBinding:
      position: 101
      prefix: -d
  - id: input
    type:
      - 'null'
      - File
    doc: "Sample-tally TSV file `*.tally.tsv` or classifier output `*.<method>.tsv`"
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
  - id: abundance
    type:
      - 'null'
      - int
    doc: "Minimum sample level abundance for FASTA sequences. Default 100."
    inputBinding:
      position: 101
      prefix: -a
  - id: total
    type:
      - 'null'
      - int
    doc: "Minimum total abundance for FASTA sequences. Applied after per-sample level minimum."
    inputBinding:
      position: 101
      prefix: -t
  - id: min_samples
    type:
      - 'null'
      - int
    doc: "Minimum number of samples a unique sequence must appear in. Default 0."
    inputBinding:
      position: 101
      prefix: --min-samples
  - id: marker
    type:
      - 'null'
      - string
    doc: "Show only entries from this marker. Required if only drawing DB entries."
    inputBinding:
      position: 101
      prefix: -k
  - id: editdist
    type:
      - 'null'
      - int
    doc: "Maximum edit distance to draw (1, 2 or 3). Default and maximum 3."
    inputBinding:
      position: 101
      prefix: -e
  - id: output
    type:
      - 'null'
      - string
    doc: "Write graph here. Default is '-' meaning stdout."
    inputBinding:
      position: 101
      prefix: -o
  - id: format
    type:
      - 'null'
      - string
    doc: "Format to write out: graphml, gexf, gml, xgmml (default, for Cytoscape), pdf or matrix."
    inputBinding:
      position: 101
      prefix: -f
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
    doc: "Network graph"
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
stdout: thapbi-pict_edit-graph.out
