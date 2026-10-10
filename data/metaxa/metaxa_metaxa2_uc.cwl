cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaxa2_uc
label: metaxa_metaxa2_uc
doc: "Metaxa2 Diversity Tools uniqueness of community analyzer: tests whether samples differ from a group of samples.\n\nTool homepage: http://microbiology.se/software/metaxa2/"
inputs:
  - id: input
    type: File
    doc: "Input count table (for example from metaxa2_dc)"
    inputBinding:
      position: 101
      prefix: -i
  - id: output_base
    type: string
    doc: "Base for the names of output file(s)"
    inputBinding:
      position: 101
      prefix: -o
  - id: groups
    type: ['null', string]
    doc: "File or string describing the sample groups, or auto, none or all (default all)"
    inputBinding:
      position: 101
      prefix: -g
  - id: resampling_rounds
    type: ['null', int]
    doc: "Number of resampling rounds for each sample, default 10000"
    inputBinding:
      position: 101
      prefix: -r
  - id: sample_size
    type: ['null', string]
    doc: "Number of entries sampled per round, or min for the size of the smallest sample, default 1000"
    inputBinding:
      position: 101
      prefix: -s
  - id: compare_to
    type: ['null', string]
    doc: "Sample to compare to; blank compares to all samples, groups compares groups"
    inputBinding:
      position: 101
      prefix: -c
  - id: within_cutoff
    type: ['null', float]
    doc: "Within-sample variation cutoff to compare to, default 0.99"
    inputBinding:
      position: 101
      prefix: -w
  - id: model
    type: ['null', string]
    doc: "Resampling model (empirical, average, model), default model"
    inputBinding:
      position: 101
      prefix: -m
  - id: distance
    type: ['null', string]
    doc: "Distance measure (bray, jaccard, euclidean), default bray"
    inputBinding:
      position: 101
      prefix: -d
  - id: binary
    type: ['null', boolean]
    doc: "Use presence/absence instead of abundances (T or F), default F"
    inputBinding:
      position: 101
      prefix: --binary
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: filter
    type: ['null', float]
    doc: "Filter out abundance values below this cutoff, default 0"
    inputBinding:
      position: 101
      prefix: --filter
  - id: summary
    type: ['null', boolean]
    doc: "Readable summary file of the results (T or F), default T"
    inputBinding:
      position: 101
      prefix: --summary
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: table
    type: ['null', boolean]
    doc: "Tab-separated table of the results (T or F), default F"
    inputBinding:
      position: 101
      prefix: --table
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: matrix
    type: ['null', boolean]
    doc: "Results in matrix format (T or F), default F"
    inputBinding:
      position: 101
      prefix: --matrix
      valueFrom: "$(self === null ? null : (self ? \"T\" : \"F\"))"
  - id: resampling_table
    type: ['null', boolean]
    doc: "Output the resampling table, can be huge (T or F), default F"
    inputBinding:
      position: 101
      prefix: --resampling_table
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
stdout: metaxa_metaxa2_uc.out
