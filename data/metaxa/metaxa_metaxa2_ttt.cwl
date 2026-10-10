cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaxa2_ttt
label: metaxa_metaxa2_ttt
doc: "Metaxa Taxonomic Traversal Tool processes the taxonomic output of Metaxa2 into count lists per taxonomic level.\n\nTool homepage: http://microbiology.se/software/metaxa2/"
inputs:
  - id: input
    type: File
    doc: "Metaxa taxonomy output file to process (*.taxonomy.txt)"
    inputBinding:
      position: 101
      prefix: -i
  - id: output_base
    type: string
    doc: "Base for the name of output file(s)"
    inputBinding:
      position: 101
      prefix: -o
  - id: profile_set
    type: ['null', string]
    doc: "Include only classifications of this type(s), comma-separated (b, bacteria, a, archaea, e, eukaryota, m, mitochondrial, c, chloroplast, A, all, o, other), default all"
    inputBinding:
      position: 101
      prefix: -t
  - id: reliability_cutoff
    type: ['null', float]
    doc: "Reliability cutoff, entries below are classified as unknown, default 0"
    inputBinding:
      position: 101
      prefix: -r
  - id: length_cutoff
    type: ['null', float]
    doc: "Length cutoff (bp) of the best hit, entries below are classified as unknown, default 50"
    inputBinding:
      position: 101
      prefix: -l
  - id: identity_cutoff
    type: ['null', float]
    doc: "Identity cutoff of the best hit (percent), entries below are classified as unknown, default 0"
    inputBinding:
      position: 101
      prefix: -d
  - id: max_level
    type: ['null', int]
    doc: "Maximum resolution level for taxonomic traversal, zero is unlimited, default 0"
    inputBinding:
      position: 101
      prefix: -m
  - id: min_level
    type: ['null', int]
    doc: "Minimum resolution level for taxonomic traversal, starting at level 1, default 1"
    inputBinding:
      position: 101
      prefix: -n
  - id: last_level_only
    type: ['null', boolean]
    doc: "Investigate only the last taxonomic level (T or F), default F"
    inputBinding:
      position: 101
      prefix: -s
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: remove_na
    type: ['null', boolean]
    doc: "Set sequence entries with no blast hits to Unknown (T or F), default T"
    inputBinding:
      position: 101
      prefix: --remove_na
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: summary
    type: ['null', boolean]
    doc: "Summary of results output (T or F), default T"
    inputBinding:
      position: 101
      prefix: --summary
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: lists
    type: ['null', boolean]
    doc: "Output lists of counts for different taxa, one per traversal level (T or F), default T"
    inputBinding:
      position: 101
      prefix: --lists
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: separate
    type: ['null', boolean]
    doc: "Output the taxonomy file separated by origin (T or F), default F"
    inputBinding:
      position: 101
      prefix: --separate
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: unknown
    type: ['null', boolean]
    doc: "Output a list of entries designated as unknowns, with their statistics (T or F), default F"
    inputBinding:
      position: 101
      prefix: --unknown
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: "Files written with the output base name"
    outputBinding:
      glob: "$(inputs.output_base)*"
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaxa:2.2.3--pl5321hdfd78af_2
stdout: metaxa_metaxa2_ttt.out
