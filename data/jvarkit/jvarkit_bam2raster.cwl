cwlVersion: v1.2
class: CommandLineTool
baseCommand: bam2raster
label: jvarkit_bam2raster
doc: "Create raster images from BAM files.\n\nTool homepage: https://github.com/lindenb/jvarkit"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: Input BAM files
    inputBinding:
      position: 1
  - id: clip
    type:
      - 'null'
      - boolean
    doc: Show clipping
    default: false
    inputBinding:
      position: 102
      prefix: --clip
  - id: depth
    type:
      - 'null'
      - int
    doc: Depth track height.
    default: 100
    inputBinding:
      position: 102
      prefix: --depth
  - id: groupby
    type:
      - 'null'
      - string
    doc: Group Reads by. Data partitioning using the SAM Read Group (see 
      https://gatkforums.broadinstitute.org/gatk/discussion/6472/ ) . It can be 
      any combination of sample, library....
    default: sample
    inputBinding:
      position: 102
      prefix: --groupby
  - id: help_format
    type:
      - 'null'
      - string
    doc: What kind of help. One of [usage,markdown,xml]
    inputBinding:
      position: 102
      prefix: --helpFormat
  - id: hide_bases
    type:
      - 'null'
      - boolean
    doc: hide bases
    default: false
    inputBinding:
      position: 102
      prefix: --nobase
  - id: highlight
    type:
      - 'null'
      - string
    doc: hightligth those positions.
    default: '[]'
    inputBinding:
      position: 102
      prefix: --highlight
  - id: limit
    type:
      - 'null'
      - int
    doc: "Limit number of rows to 'N' lines. negative: no limit."
    default: -1
    inputBinding:
      position: 102
      prefix: --maxrows
  - id: mapqopacity
    type:
      - 'null'
      - string
    doc: 'How to handle the MAPQ/ opacity of the reads. all_opaque: no opacity, handler
      1: transparency under MAPQ=60'
    default: handler1
    inputBinding:
      position: 102
      prefix: --mapqopacity
  - id: min_distance_between_reads
    type:
      - 'null'
      - int
    doc: Min. distance between two reads.
    default: 2
    inputBinding:
      position: 102
      prefix: --minh
  - id: no_read_gradient
    type:
      - 'null'
      - boolean
    doc: Do not use gradient for reads
    default: false
    inputBinding:
      position: 102
      prefix: --noReadGradient
  - id: print_read_name
    type:
      - 'null'
      - boolean
    doc: print read name instead of base
    default: false
    inputBinding:
      position: 102
      prefix: --name
  - id: reference
    type:
      - 'null'
      - File
    doc: Indexed fasta Reference file. This file must be indexed with samtools 
      faidx and with picard/gatk CreateSequenceDictionary or samtools dict
    inputBinding:
      position: 102
      prefix: --reference
  - id: region
    type:
      - 'null'
      - string
    doc: 'Restrict to that region. An interval as the following syntax : "chrom:start-end"
      or "chrom:middle+extend" or "chrom:start-end+extend" or "chrom:start-end+extend-percent%".A
      program might use a Reference sequence to fix the chromosome name (e.g: 1->chr1)'
    inputBinding:
      position: 102
      prefix: --region
  - id: sam_record_filter
    type:
      - 'null'
      - string
    doc: A filter expression. Reads matching the expression will be 
      filtered-out. Empty String means 'filter out nothing/Accept all'. See 
      https://github.com/lindenb/jvarkit/blob/master/src/main/resources/javacc/com/github/lindenb/jvarkit/util/bio/samfilter/SamFilterParser.jj
      for a complete syntax. 'default' is 'mapqlt(1) || Duplicate() || 
      FailsVendorQuality() || NotPrimaryAlignment() || SupplementaryAlignment()'
    default: mapqlt(1) || Duplicate() || FailsVendorQuality() || 
      NotPrimaryAlignment() || SupplementaryAlignment()
    inputBinding:
      position: 102
      prefix: --samRecordFilter
  - id: spacey_feature
    type:
      - 'null'
      - int
    doc: number of pixels between features
    default: 4
    inputBinding:
      position: 102
      prefix: --spaceyfeature
  - id: variants
    type:
      - 'null'
      - type: array
        items: File
    doc: VCF files used to fill the position to hightlight with POS
    default: '[]'
    inputBinding:
      position: 102
      prefix: --variants
  - id: width
    type:
      - 'null'
      - int
    doc: Image width
    default: 1000
    inputBinding:
      position: 102
      prefix: --width
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: 'Output file. Optional . Default: stdout [20180829] filename can be also
      an existing directory or a zip file, in witch case, each individual will be
      saved in the zip/dir.'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jvarkit:2024.08.25--hdfd78af_2
