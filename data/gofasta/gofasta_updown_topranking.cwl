cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gofasta
  - updown
  - topranking
label: gofasta_updown_topranking
doc: "Get pseudo-tree-aware catchments for query sequences from alignments

Tool homepage: https://github.com/virus-evolution/gofasta"
inputs:
  - id: query
    type: File
    doc: "File with sequences to find neighbours for. Either the CSV output of gofasta updown list, or an alignment in fasta format"
    inputBinding:
      position: 101
      prefix: --query
  - id: target
    type: File
    doc: "File of sequences to look for neighbours in. Either the CSV output of gofasta updown list, or an alignment in fasta format"
    inputBinding:
      position: 101
      prefix: --target
  - id: reference
    type:
      - 'null'
      - File
    doc: "Reference sequence, in fasta format - only required if --query and --target are fasta files"
    inputBinding:
      position: 101
      prefix: --reference
  - id: ignore
    type:
      - 'null'
      - File
    doc: "Optional plain text file of IDs to ignore in the target file when searching for neighbours"
    inputBinding:
      position: 101
      prefix: --ignore
  - id: table
    type:
      - 'null'
      - boolean
    doc: "Write a long-form table of the output"
    inputBinding:
      position: 101
      prefix: --table
  - id: dist_all
    type:
      - 'null'
      - int
    doc: "Maximum allowed SNP-distance between target and query sequence in any direction. Overrides the settings below"
    inputBinding:
      position: 101
      prefix: --dist-all
  - id: dist_up
    type:
      - 'null'
      - int
    doc: "Maximum allowed SNP-distance from query for sequences in the parent bin"
    inputBinding:
      position: 101
      prefix: --dist-up
  - id: dist_down
    type:
      - 'null'
      - int
    doc: "Maximum allowed SNP-distance from query for sequences in the child bin"
    inputBinding:
      position: 101
      prefix: --dist-down
  - id: dist_side
    type:
      - 'null'
      - int
    doc: "Maximum allowed SNP-distance from query for sequences in the sibling bin"
    inputBinding:
      position: 101
      prefix: --dist-side
  - id: size_total
    type:
      - 'null'
      - int
    doc: "Max number of neighbours to find (attempts to split equally between same/up/down/side). A hard limit"
    inputBinding:
      position: 101
      prefix: --size-total
  - id: size_up
    type:
      - 'null'
      - int
    doc: "Max number of closest parent sequences to find, if size-total not specified. A soft limit unless --no-fill"
    inputBinding:
      position: 101
      prefix: --size-up
  - id: size_down
    type:
      - 'null'
      - int
    doc: "Max number of closest child sequences to find, if size-total not specified. A soft limit unless --no-fill"
    inputBinding:
      position: 101
      prefix: --size-down
  - id: size_side
    type:
      - 'null'
      - int
    doc: "Max number of closest sibling sequences to find, if size-total not specified. A soft limit unless --no-fill"
    inputBinding:
      position: 101
      prefix: --size-side
  - id: size_same
    type:
      - 'null'
      - int
    doc: "Max number of identical sequences to find, if size-total not specified. A soft limit unless --no-fill"
    inputBinding:
      position: 101
      prefix: --size-same
  - id: threshold_pair
    type:
      - 'null'
      - float
    doc: "Up to this proportion of consequential sites is allowed to be ambiguous in either sequence for each pairwise comparison (default 0.1)"
    inputBinding:
      position: 101
      prefix: --threshold-pair
  - id: threshold_target
    type:
      - 'null'
      - int
    doc: "Target can have at most this number of ambiguities to be considered (default 10000)"
    inputBinding:
      position: 101
      prefix: --threshold-target
  - id: dist_push
    type:
      - 'null'
      - int
    doc: "Push the --dist boundaries outwards so that bins have at least these many closest SNP-distances for which there are neighbours, where possible"
    inputBinding:
      position: 101
      prefix: --dist-push
  - id: no_fill
    type:
      - 'null'
      - boolean
    doc: "Don't make up for a shortfall in any of --size-up, -down, -side or -same by increasing the count for other bins"
    inputBinding:
      position: 101
      prefix: --no-fill
  - id: outfile_path
    type:
      - 'null'
      - string
    doc: "CSV-format file of closest neighbours to write (default stdout)"
    inputBinding:
      position: 102
      prefix: --outfile
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: outfile
    type:
      - 'null'
      - File
    doc: "CSV file of closest neighbours"
    outputBinding:
      glob: "$(inputs.outfile_path ? inputs.outfile_path : 'no_outfile')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gofasta:1.2.3--h9ee0642_0
stdout: gofasta_updown_topranking.out
