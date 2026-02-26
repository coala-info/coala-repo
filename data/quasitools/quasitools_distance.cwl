cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - quasitools
  - distance
label: quasitools_distance
doc: "Quasitools distance produces a measure of evolutionary distance [0 - 1] between
  quasispecies, computed using the angular cosine distance function defined below.\n\
  \nTool homepage: https://github.com/phac-nml/quasitools/"
inputs:
  - id: reference
    type: string
    doc: Reference sequence(s)
    inputBinding:
      position: 1
  - id: bam_files
    type:
      - 'null'
      - type: array
        items: File
    doc: BAM files
    inputBinding:
      position: 2
  - id: dont_normalize
    type:
      - 'null'
      - boolean
    doc: Do not normalize read count data.
    inputBinding:
      position: 103
      prefix: --dont_normalize
  - id: endpos
    type:
      - 'null'
      - int
    doc: Set the end base position of the reference to use in the distance or 
      similarity calculation. End position is one-indexed. I.e. it must be 
      between one and the total length of the reference sequence(s), inclusive.
    inputBinding:
      position: 103
      prefix: --endpos
  - id: keep_no_coverage
    type:
      - 'null'
      - boolean
    doc: Do not ignore pileup regions with no coverage.
    inputBinding:
      position: 103
      prefix: --keep_no_coverage
  - id: normalize
    type:
      - 'null'
      - boolean
    doc: Normalize read count data so that the read counts per 4-tuple (A, C, T,
      G) sum to one.
    inputBinding:
      position: 103
      prefix: --normalize
  - id: output_distance
    type:
      - 'null'
      - boolean
    doc: Output an angular distance matrix (by default).
    inputBinding:
      position: 103
      prefix: --output_distance
  - id: output_similarity
    type:
      - 'null'
      - boolean
    doc: Output a cosine similarity matrix (cosine similarity is not a metric).
    inputBinding:
      position: 103
      prefix: --output_similarity
  - id: remove_no_coverage
    type:
      - 'null'
      - boolean
    doc: Ignore all pileup regions with no coverage.
    inputBinding:
      position: 103
      prefix: --remove_no_coverage
  - id: startpos
    type:
      - 'null'
      - int
    doc: Set the start base position of the reference to use in the distance or 
      similarity calculation. Start position is one-indexed. I.e. it must be 
      between one and the total length of the reference sequence(s), inclusive.
    inputBinding:
      position: 103
      prefix: --startpos
  - id: truncate
    type:
      - 'null'
      - boolean
    doc: Ignore contiguous start and end pileup regions with no coverage.
    inputBinding:
      position: 103
      prefix: --truncate
outputs:
  - id: output_filename
    type:
      - 'null'
      - File
    doc: Output the quasispecies distance or similarity matrix in CSV format in 
      a file.
    outputBinding:
      glob: $(inputs.output_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quasitools:0.7.0--py_0
