cwlVersion: v1.2
class: CommandLineTool
baseCommand: VcfFilter
label: ngs-bits_VcfFilter
doc: "Filters a VCF based on the given criteria. Missing annotation in the SAMPLE filter are treated as passing the filter. INFO flags (i.e. entries without value) are ignored, i.e. they cannot be filtered.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: filter
    type:
      - 'null'
      - string
    doc: "Filter by FILTER column - keep matches (regular expression)."
    inputBinding:
      position: 1
      prefix: -filter
  - id: filter_clear
    type:
      - 'null'
      - boolean
    doc: "Remove filter entries of all variants, i.e. sets filter to PASS."
    inputBinding:
      position: 2
      prefix: -filter_clear
  - id: filter_empty
    type:
      - 'null'
      - boolean
    doc: "Removes entries with non-empty FILTER column."
    inputBinding:
      position: 3
      prefix: -filter_empty
  - id: filter_exclude
    type:
      - 'null'
      - string
    doc: "Filter by FILTER column - exclude matches (regular expression)."
    inputBinding:
      position: 4
      prefix: -filter_exclude
  - id: id
    type:
      - 'null'
      - string
    doc: "Filter by ID column (regular expression)."
    inputBinding:
      position: 5
      prefix: -id
  - id: info
    type:
      - 'null'
      - string
    doc: "Filter by INFO column entries - use ';' as separator for several filters, e.g. 'DP > 5;AO > 2' (spaces are important). Valid operations are '>','>=','=','!=','<=','<','is','not','contains'."
    inputBinding:
      position: 6
      prefix: -info
  - id: input_file
    type:
      - 'null'
      - File
    doc: "Input VCF file. If unset, reads from STDIN."
    inputBinding:
      position: 7
      prefix: -in
  - id: no_special_chr
    type:
      - 'null'
      - boolean
    doc: "Removes variants that are on special chromosomes, i.e. not on autosomes, not on gonosomes and not on chrMT."
    inputBinding:
      position: 8
      prefix: -no_special_chr
  - id: output_path
    type:
      - 'null'
      - string
    doc: "Output VCF list. If unset, writes to STDOUT."
    inputBinding:
      position: 9
      prefix: -out
  - id: qual
    type:
      - 'null'
      - float
    doc: "Filter by QUAL column (minimum)."
    inputBinding:
      position: 10
      prefix: -qual
  - id: ref
    type:
      - 'null'
      - File
    doc: "Reference genome FASTA file. If unset 'reference_genome' from the 'settings.ini' file is used."
    secondaryFiles:
      - pattern: .fai
        required: false
    inputBinding:
      position: 11
      prefix: -ref
  - id: reg
    type:
      - 'null'
      - File
      - string
    doc: "Region of interest in BED format, or comma-separated list of region, e.g. 'chr1:454540-454678,chr2:473457-4734990'."
    inputBinding:
      position: 12
      prefix: -reg
  - id: remove_invalid
    type:
      - 'null'
      - boolean
    doc: "Removes invalid variants, i.e. invalid position of ref/alt."
    inputBinding:
      position: 13
      prefix: -remove_invalid
  - id: remove_non_ref
    type:
      - 'null'
      - boolean
    doc: "Remove '<NON_REF>' entries (used in gVCF files)."
    inputBinding:
      position: 14
      prefix: -remove_non_ref
  - id: sample
    type:
      - 'null'
      - string
    doc: "Filter by sample-specific entries - use ';' as separator for several filters, e.g. 'GT is 1/1' (spaces are important). Valid operations are '>','>=','=','!=','<=','<','is','not','contains'."
    inputBinding:
      position: 15
      prefix: -sample
  - id: sample_one_match
    type:
      - 'null'
      - boolean
    doc: "If set, a line will pass if one sample passes all filters (default behaviour is that all samples have to pass all filters)."
    inputBinding:
      position: 16
      prefix: -sample_one_match
  - id: settings_file
    type:
      - 'null'
      - File
    doc: "Settings override file (no other settings files are used)."
    inputBinding:
      position: 17
      prefix: --settings
  - id: variant_type
    type:
      - 'null'
      - string
    doc: "Filters by variant type. Possible types are: 'snp','indel','multi-allelic','other'."
    inputBinding:
      position: 18
      prefix: -variant_type
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Output VCF list. If unset, writes to STDOUT."
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
