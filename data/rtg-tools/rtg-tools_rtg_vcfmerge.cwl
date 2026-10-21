cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rtg
  - vcfmerge
label: rtg-tools_rtg_vcfmerge
doc: 'Merge a one or more input VCF files to a single output VCF. Use cases include combining single sample calls into a multi-sample VCF, or to combine calls on separate chromosomes into a single VCF. Tool homepage: https://github.com/RealTimeGenomics/rtg-tools'
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: bed_regions
    type:
      - 'null'
      - File
    doc: 'if set, only read VCF records that overlap the ranges contained in the specified BED file'
    inputBinding:
      position: 101
      prefix: --bed-regions
  - id: input_list_file
    type:
      - 'null'
      - File
    doc: 'file containing a list of VCF format files (1 per line) to be merged'
    inputBinding:
      position: 101
      prefix: --input-list-file
  - id: output
    type: string
    doc: 'output VCF file'
    inputBinding:
      position: 101
      prefix: --output
  - id: region
    type:
      - 'null'
      - string
    doc: 'if set, only read VCF records within the specified range. The format is one of <sequence_name>, <sequence_name>:<start>-<end>, <sequence_name>:<pos>+<length> or <sequence_name>:<pos>~<padding>'
    inputBinding:
      position: 101
      prefix: --region
  - id: add_header
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --add-header
    doc: 'file containing VCF header lines to add, or a literal header line. May be specified 0 or more times'
    inputBinding:
      position: 101
  - id: force_merge
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --force-merge
    doc: 'allow merging of specified header ID even when descriptions do not match. May be specified 0 or more times, or as a comma separated list'
    inputBinding:
      position: 101
  - id: force_merge_all
    type:
      - 'null'
      - boolean
    doc: 'attempt merging of all non-matching header declarations'
    inputBinding:
      position: 101
      prefix: --force-merge-all
  - id: no_gzip
    type:
      - 'null'
      - boolean
    doc: 'do not gzip the output'
    inputBinding:
      position: 101
      prefix: --no-gzip
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: 'prevent VCF header from being written'
    inputBinding:
      position: 101
      prefix: --no-header
  - id: no_merge_alts
    type:
      - 'null'
      - boolean
    doc: 'do not merge multiple records if the ALTs are different'
    inputBinding:
      position: 101
      prefix: --no-merge-alts
  - id: no_merge_records
    type:
      - 'null'
      - boolean
    doc: 'do not merge multiple records at the same position into one'
    inputBinding:
      position: 101
      prefix: --no-merge-records
  - id: preserve_formats
    type:
      - 'null'
      - boolean
    doc: 'do not merge multiple records containing unmergeable FORMAT fields (Default is to remove those FORMAT fields so the variants can be combined)'
    inputBinding:
      position: 101
      prefix: --preserve-formats
  - id: stats
    type:
      - 'null'
      - boolean
    doc: 'output statistics for the merged VCF file'
    inputBinding:
      position: 101
      prefix: --stats
  - id: vcf_files
    type:
      - 'null'
      - type: array
        items: File
    secondaryFiles:
      - pattern: .tbi
        required: false
    doc: 'input VCF files to merge. May be specified 0 or more times'
    inputBinding:
      position: 200
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_files
    type:
      type: array
      items: File
    doc: 'Merged VCF and its index'
    outputBinding:
      glob: $(inputs.output)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
stdout: rtg-tools_rtg_vcfmerge.out
