cwlVersion: v1.2
class: CommandLineTool
baseCommand: zagros
label: zagros
doc: "Finds motifs in DNA sequences based on cross-linking data.\n\nTool homepage:
  https://github.com/Aryvyo/Zagros"
inputs:
  - id: target_regions_sequences
    type: string
    doc: Target regions or sequences
    inputBinding:
      position: 1
  - id: chrom_dir
    type:
      - 'null'
      - Directory
    doc: directory with chrom files (FASTA format)
    inputBinding:
      position: 102
      prefix: -chrom
  - id: delta
    type:
      - 'null'
      - int
    doc: provide a fixed value for delta, the offset of cross-linking site from 
      motif occurrences. -8 <= l <= 8; if omitted, delta is optimised using an 
      exhaustive search
    inputBinding:
      position: 102
      prefix: -delta
  - id: diagnostic_events_file
    type:
      - 'null'
      - File
    doc: diagnostic events information file
    inputBinding:
      position: 102
      prefix: -diagnostic_events
  - id: diagnostic_weight
    type:
      - 'null'
      - float
    doc: A weight to determine the diagnostic events' level of contribution
    inputBinding:
      position: 102
      prefix: -de_weight
  - id: number_of_motifs
    type:
      - 'null'
      - int
    doc: number of motifs to output
    inputBinding:
      position: 102
      prefix: -number
  - id: optimize_geo
    type:
      - 'null'
      - boolean
    doc: optimize the geometric distribution parameter for the distribution of 
      cross-link sites around motif occurrences, using the Newton-Raphson 
      algorithm. If omitted, this parameter is not optimised and is set to a 
      empirically pre-determined default value.
    inputBinding:
      position: 102
      prefix: -geo
  - id: starting_points
    type:
      - 'null'
      - int
    doc: number of starting points to try for EM search. Higher values will be 
      slower, but more likely to find the global maximum
    inputBinding:
      position: 102
      prefix: -starting-points
  - id: structure_file
    type:
      - 'null'
      - File
    doc: structure information file
    inputBinding:
      position: 102
      prefix: -structure
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print more run info
    inputBinding:
      position: 102
      prefix: -verbose
  - id: width
    type:
      - 'null'
      - int
    doc: width of motifs to find (4 <= w <= 12)
    inputBinding:
      position: 102
      prefix: -width
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file name
    outputBinding:
      glob: $(inputs.output_file)
  - id: indicator_probabilities_file
    type:
      - 'null'
      - File
    doc: output indicator probabilities for each sequence and motif to this file
    outputBinding:
      glob: $(inputs.indicator_probabilities_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/zagros:1.0.0--ha24e720_10
