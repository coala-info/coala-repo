cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rgfa-split
label: cactus-gfa-tools_rgfa-split
doc: "Partition rGFA nodes into reference contigs. Input must be uncompressed GFA
  (not stdin)\n\nTool homepage: https://github.com/ComparativeGenomicsToolkit/cactus-gfa-tools"
inputs:
  - id: allow_softclip
    type:
      - 'null'
      - boolean
    doc: Allow softclipping with -u
    inputBinding:
      position: 101
      prefix: --allow-softclip
  - id: ambiguous_name
    type:
      - 'null'
      - string
    doc: All query contigs that do not meet min coverage (-n) assigned to single reference
      with name NAME
    inputBinding:
      position: 101
      prefix: --ambiguous-name
  - id: bed
    type:
      - 'null'
      - type: array
        items: File
    doc: BED file. Used to subtract out softmasked regions when computing coverage
      (multiple allowed)
    inputBinding:
      position: 101
      prefix: --bed
  - id: contig_file
    type:
      - 'null'
      - File
    doc: Path to list of contigs to process
    inputBinding:
      position: 101
      prefix: --contig-file
  - id: contig_name
    type:
      - 'null'
      - type: array
        items: string
    doc: Only process NAME (multiple allowed)
    inputBinding:
      position: 101
      prefix: --contig-name
  - id: contig_prefix
    type:
      - 'null'
      - string
    doc: Only process contigs beginning with PREFIX
    inputBinding:
      position: 101
      prefix: --contig-prefix
  - id: input_contig_map
    type:
      - 'null'
      - File
    doc: Use tsv map (computed with -M) instead of rGFA
    inputBinding:
      position: 101
      prefix: --input-contig-map
  - id: max_gap
    type:
      - 'null'
      - int
    doc: Count cigar gaps of length <= N towards coverage
    inputBinding:
      position: 101
      prefix: --max-gap
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Don't count PAF lines with MAPQ<N towards coverage
    inputBinding:
      position: 101
      prefix: --min-mapq
  - id: min_query_chunk
    type:
      - 'null'
      - int
    doc: I a query interval of >= N bp aligns to a reference with sufficient coverage,
      cut it out. Disabled when 0.
    default: 0
    inputBinding:
      position: 101
      prefix: --min-query-chunk
  - id: min_query_coverage
    type:
      - 'null'
      - type: array
        items: float
    doc: At least this fraction of input contig must align to reference contig for
      it to be assigned (can repeat)
    inputBinding:
      position: 101
      prefix: --min-query-coverage
  - id: min_query_uniqueness
    type:
      - 'null'
      - float
    doc: The ratio of the number of query bases aligned to the chosen ref contig vs
      the next best ref contig must exceed this threshold to not be considered ambigious
    inputBinding:
      position: 101
      prefix: --min-query-uniqueness
  - id: other_name
    type:
      - 'null'
      - string
    doc: Lump all contigs not selected by above options into single reference with
      name NAME
    inputBinding:
      position: 101
      prefix: --other-name
  - id: paf
    type:
      - 'null'
      - File
    doc: PAF file to split
    inputBinding:
      position: 101
      prefix: --paf
  - id: reference_prefix
    type:
      - 'null'
      - string
    doc: Don't apply ambiguity filters to query contigs with this prefix
    inputBinding:
      position: 101
      prefix: --reference-prefix
  - id: rgfa
    type:
      - 'null'
      - File
    doc: rGFA to use as baseline for contig splitting (if not defined, minmap2 output
      assumed)
    inputBinding:
      position: 101
      prefix: --rgfa
  - id: small_coverage_threshold
    type:
      - 'null'
      - type: array
        items: int
    doc: Used to toggle between the coverage thresholds (-n). Should have one-fewer
      value than -n
    inputBinding:
      position: 101
      prefix: --small-coverage-threshold
  - id: split_gfa
    type:
      - 'null'
      - boolean
    doc: Split the input GFA too and output <PREFIX><config>.gfa files
    inputBinding:
      position: 101
      prefix: --split-gfa
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: All output files will be of the form <PREFIX><contig>.paf/.fa_contigs
    outputBinding:
      glob: $(inputs.output_prefix)
  - id: output_contig_map
    type:
      - 'null'
      - File
    doc: Output rgfa node -> contig map to this file
    outputBinding:
      glob: $(inputs.output_contig_map)
  - id: log
    type:
      - 'null'
      - File
    doc: Keep track of filtered and assigned contigs in given file [stderr]
    outputBinding:
      glob: $(inputs.log)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cactus-gfa-tools:0.1--h9948957_0
