cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jvarkit
  - bam2raster
label: jvarkit_bam2raster
doc: "Draw the reads of a BAM region as a raster image (PNG).\n\nTool homepage: https://github.com/lindenb/jvarkit"
inputs:
  - id: bam_files
    type:
      type: array
      items: File
    doc: Input BAM/CRAM files
    secondaryFiles:
      - .bai
    inputBinding:
      position: 100
  - id: clip
    type:
      - 'null'
      - boolean
    doc: Show clipping
    inputBinding:
      position: 1
      prefix: --clip
  - id: depth
    type:
      - 'null'
      - int
    doc: "Depth track height (default: 100)"
    inputBinding:
      position: 2
      prefix: --depth
  - id: groupby
    type:
      - 'null'
      - string
    doc: "Group Reads by. Data partitioning using the SAM Read Group. It can be any combination of sample, library.... One of readgroup, sample, library, platform, center, sample_by_platform, sample_by_center, sample_by_platform_by_center, any (default: sample)"
    inputBinding:
      position: 3
      prefix: --groupby
  - id: highlight
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --highlight
    doc: hightligth those positions.
    inputBinding:
      position: 4
  - id: mapqopacity
    type:
      - 'null'
      - string
    doc: "How to handle the MAPQ/ opacity of the reads. all_opaque: no opacity, handler 1: transparency under MAPQ=60 (default: handler1)"
    inputBinding:
      position: 5
      prefix: --mapqopacity
  - id: limit
    type:
      - 'null'
      - int
    doc: "Limit number of rows to 'N' lines. negative: no limit (default: -1)"
    inputBinding:
      position: 6
      prefix: --limit
  - id: minh
    type:
      - 'null'
      - int
    doc: "Min. distance between two reads (default: 2)"
    inputBinding:
      position: 7
      prefix: --minh
  - id: name
    type:
      - 'null'
      - boolean
    doc: print read name instead of base
    inputBinding:
      position: 8
      prefix: --name
  - id: no_read_gradient
    type:
      - 'null'
      - boolean
    doc: Do not use gradient for reads
    inputBinding:
      position: 9
      prefix: --noReadGradient
  - id: nobase
    type:
      - 'null'
      - boolean
    doc: hide bases
    inputBinding:
      position: 10
      prefix: --nobase
  - id: output
    type:
      - 'null'
      - string
    doc: "Output file. Optional . Default: stdout [20180829] filename can be also an existing directory or a zip file, in witch case, each individual will be saved in the zip/dir."
    inputBinding:
      position: 11
      prefix: --output
  - id: reference
    type:
      - 'null'
      - File
    doc: Indexed fasta Reference file. This file must be indexed with samtools faidx and with picard/gatk CreateSequenceDictionary or samtools dict
    secondaryFiles:
      - .fai
      - "^.dict"
    inputBinding:
      position: 12
      prefix: --reference
  - id: region
    type: string
    doc: "Restrict to that region. An interval as the following syntax : \"chrom:start-end\" or \"chrom:middle+extend\" or \"chrom:start-end+extend\" or \"chrom:start-end+extend-percent%\". A program might use a Reference sequence to fix the chromosome name (e.g: 1->chr1)"
    inputBinding:
      position: 13
      prefix: --region
  - id: sam_record_filter
    type:
      - 'null'
      - string
    doc: "A filter expression. Reads matching the expression will be filtered-out. Empty String means 'filter out nothing/Accept all'. 'default' is 'mapqlt(1) || Duplicate() || FailsVendorQuality() || NotPrimaryAlignment() || SupplementaryAlignment()'"
    inputBinding:
      position: 14
      prefix: --samRecordFilter
  - id: spaceyfeature
    type:
      - 'null'
      - int
    doc: "number of pixels between features (default: 4)"
    inputBinding:
      position: 15
      prefix: --spaceyfeature
  - id: variants
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --variants
    doc: VCF files used to fill the position to hightlight with POS
    inputBinding:
      position: 16
  - id: width
    type:
      - 'null'
      - int
    doc: "Image width (default: 1000)"
    inputBinding:
      position: 17
      prefix: --width
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file, when the output option is given
    outputBinding:
      glob: $(inputs.output)
  - id: stdout
    type: stdout
    doc: Standard output (the result, when no output file is given)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jvarkit:2024.08.25--hdfd78af_2
stdout: jvarkit_bam2raster.out
