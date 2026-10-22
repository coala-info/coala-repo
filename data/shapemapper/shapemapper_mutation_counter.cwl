cwlVersion: v1.2
class: CommandLineTool
baseCommand: [shapemapper_mutation_counter]
label: shapemapper_mutation_counter
doc: "Count mutations from parsed mutation files (ShapeMapper mutation counter).\n\nTool homepage: https://github.com/Weeks-UNC/shapemapper2"
inputs:
  - id: in_parsed
    type: File[]
    doc: "Input file path(s) (parsed mutations), comma-separated"
    inputBinding:
      position: 101
      prefix: --in
      itemSeparator: ","
  - id: length
    type: ['null', int]
    doc: "Length of reference sequence. If provided, output files are guaranteed to have this many lines even if there are regions of no read coverage"
    inputBinding:
      position: 101
      prefix: --length
  - id: n_primer_pairs
    type: ['null', int]
    doc: "Number of primer pairs previously used for read mapping location filtering"
    inputBinding:
      position: 101
      prefix: --n_primer_pairs
  - id: hist
    type: ['null', boolean]
    doc: "Output read length and mutation frequency histogram tables"
    inputBinding:
      position: 101
      prefix: --hist
  - id: input_is_sorted
    type: ['null', boolean]
    doc: "Use less memory if scanning along mutations from a BAM file sorted by leftmost alignment position"
    inputBinding:
      position: 101
      prefix: --input_is_sorted
  - id: separate_ambig_counts
    type: ['null', boolean]
    doc: "Output ambiguously aligned derived mutation counts in separate columns"
    inputBinding:
      position: 101
      prefix: --separate_ambig_counts
  - id: debug
    type: ['null', boolean]
    doc: "Debug info"
    inputBinding:
      position: 101
      prefix: --debug
  - id: warn_on_no_mapped
    type: ['null', boolean]
    doc: "Exit with warning instead of error if no mapped reads present in input"
    inputBinding:
      position: 101
      prefix: --warn_on_no_mapped
  - id: variant_out_path
    type: ['null', string]
    doc: "Sequence variant counts output file path"
    inputBinding:
      position: 101
      prefix: --variant_out
  - id: count_out_path
    type: ['null', string]
    doc: "Mutation counts output file path"
    inputBinding:
      position: 101
      prefix: --count_out
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (histogram tables when --hist is used)
  - id: variant_counts
    type: ['null', File]
    doc: Sequence variant counts output file
    outputBinding:
      glob: $(inputs.variant_out_path)
  - id: mutation_counts
    type: ['null', File]
    doc: Mutation counts output file
    outputBinding:
      glob: $(inputs.count_out_path)
stdout: shapemapper_mutation_counter.out
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shapemapper:2.3.2--h5814d7d_0
