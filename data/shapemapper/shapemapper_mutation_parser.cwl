cwlVersion: v1.2
class: CommandLineTool
baseCommand: [shapemapper_mutation_parser]
label: shapemapper_mutation_parser
doc: "Parse mutations from a SAM alignment file (ShapeMapper mutation parser).\n\nTool homepage: https://github.com/Weeks-UNC/shapemapper2"
inputs:
  - id: in_sam
    type: File
    doc: "SAM input file path"
    inputBinding:
      position: 101
      prefix: --in
  - id: max_paired_fragment_length
    type: ['null', int]
    doc: "Paired reads mapping to a fragment size above this threshold will be treated as separate reads"
    inputBinding:
      position: 101
      prefix: --max_paired_fragment_length
  - id: min_mapq
    type: ['null', int]
    doc: "Minimum reported mapping quality to allow"
    inputBinding:
      position: 101
      prefix: --min_mapq
  - id: exclude_3prime
    type: ['null', int]
    doc: "Exclude mutations occurring within this many nucleotides of 3-prime end of read"
    inputBinding:
      position: 101
      prefix: --exclude_3prime
  - id: input_is_unpaired
    type: ['null', boolean]
    doc: "Specify that reads are unpaired (as opposed to paired and/or unmerged paired reads)"
    inputBinding:
      position: 101
      prefix: --input_is_unpaired
  - id: n7
    type: ['null', boolean]
    doc: "Specify that reads are unpaired (as opposed to paired and/or unmerged paired reads)"
    inputBinding:
      position: 101
      prefix: --N7
  - id: primers
    type: ['null', File]
    doc: "Primer file"
    inputBinding:
      position: 101
      prefix: --primers
  - id: trim_primers
    type: ['null', boolean]
    doc: "Trim primers"
    inputBinding:
      position: 101
      prefix: --trim_primers
  - id: require_forward_primer_mapped
    type: ['null', boolean]
    doc: "Require the forward primer to be mapped"
    inputBinding:
      position: 101
      prefix: --require_forward_primer_mapped
  - id: require_reverse_primer_mapped
    type: ['null', boolean]
    doc: "Require the reverse primer to be mapped"
    inputBinding:
      position: 101
      prefix: --require_reverse_primer_mapped
  - id: max_primer_offset
    type: ['null', int]
    doc: "Maximum primer offset"
    inputBinding:
      position: 101
      prefix: --max_primer_offset
  - id: right_align_ambig_dels
    type: ['null', boolean]
    doc: "Realign ambiguously aligned deletions to right end (not recommended), otherwise realign left"
    inputBinding:
      position: 101
      prefix: --right_align_ambig_dels
  - id: right_align_ambig_ins
    type: ['null', boolean]
    doc: "Realign ambiguously aligned insertions to right end (not recommended), otherwise realign left"
    inputBinding:
      position: 101
      prefix: --right_align_ambig_ins
  - id: max_internal_match
    type: ['null', int]
    doc: "Allow up to N unchanged reference sequence nucs between merged mutations"
    inputBinding:
      position: 101
      prefix: --max_internal_match
  - id: min_qual
    type: ['null', int]
    doc: "Exclude mutations that contain or are adjacent to any basecalls with Phred quality scores below this value"
    inputBinding:
      position: 101
      prefix: --min_qual
  - id: use_only_mutation_type
    type: ['null', string]
    doc: "Default is to include all mutation types. Passing dms will process data using DMS mutation signatures. Other values: mismatch gap insert gap_multi insert_multi complex"
    inputBinding:
      position: 101
      prefix: --use_only_mutation_type
  - id: variant_mode
    type: ['null', boolean]
    doc: "Do not merge nearby mutations or realign ambiguous mutations (used for sequence variant detection)"
    inputBinding:
      position: 101
      prefix: --variant_mode
  - id: debug
    type: ['null', boolean]
    doc: "Print debugging information"
    inputBinding:
      position: 101
      prefix: --debug
  - id: warn_on_no_mapped
    type: ['null', boolean]
    doc: "Exit with warning instead of error if no mapped reads present in input"
    inputBinding:
      position: 101
      prefix: --warn_on_no_mapped
  - id: debug_out_path
    type: ['null', string]
    doc: "Intermediate debug info file path"
    inputBinding:
      position: 101
      prefix: --debug_out
  - id: out_path
    type: string
    doc: "Parsed mutations output file path"
    inputBinding:
      position: 102
      prefix: --out
outputs:
  - id: parsed_mutations
    type: File
    doc: Parsed mutations output file
    outputBinding:
      glob: $(inputs.out_path)
  - id: debug_out
    type: ['null', File]
    doc: Intermediate debug info file
    outputBinding:
      glob: $(inputs.debug_out_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shapemapper:2.3.2--h5814d7d_0
