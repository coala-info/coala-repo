cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sav
  - import
label: savvy_sav import
doc: "Import data into SAV format\n\nTool homepage: https://github.com/statgen/savvy"
inputs:
  - id: input_sav
    type:
      - 'null'
      - File
    doc: Input SAV file
    inputBinding:
      position: 1
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file (vcf, vcf.gz, or sav)
    inputBinding:
      position: 2
  - id: block_size
    type:
      - 'null'
      - int
    doc: Number of markers in SAV compression block (0-65535)
    inputBinding:
      position: 103
      prefix: --block-size
  - id: bounding_point
    type:
      - 'null'
      - string
    doc: Determines the inclusion policy of indels during region queries (any, 
      all, beg or end)
    inputBinding:
      position: 103
      prefix: --bounding-point
  - id: compression_level
    type:
      - 'null'
      - int
    doc: Number (#) of compression level (1-19)
    inputBinding:
      position: 103
      prefix: -#
  - id: filter
    type:
      - 'null'
      - string
    doc: Filter expression for including variants based on FILTER, QUAL, and 
      INFO fields (eg, -f 'AC>=10;AF>0.01')
    inputBinding:
      position: 103
      prefix: --filter
  - id: generate_info
    type:
      - 'null'
      - string
    doc: Generate info fields specified as a comma separated list 
      (AC,MAC,AN,AF,MAF)
    inputBinding:
      position: 103
      prefix: --generate-info
  - id: pbwt_fields
    type:
      - 'null'
      - string
    doc: Comma separated list of FORMAT fields for which to enable PBWT sorting
    inputBinding:
      position: 103
      prefix: --pbwt-fields
  - id: phasing
    type:
      - 'null'
      - string
    doc: Sets file phasing status if phasing header is not present (none, full, 
      or partial)
    inputBinding:
      position: 103
      prefix: --phasing
  - id: regions
    type:
      - 'null'
      - string
    doc: Comma separated list of genomic regions formatted as chr[:start-end]
    inputBinding:
      position: 103
      prefix: --regions
  - id: regions_file
    type:
      - 'null'
      - File
    doc: Path to file containing list of regions formatted as 
      chr<tab>start<tab>end
    inputBinding:
      position: 103
      prefix: --regions-file
  - id: sample_ids
    type:
      - 'null'
      - string
    doc: Comma separated list of sample IDs to subset
    inputBinding:
      position: 103
      prefix: --sample-ids
  - id: sample_ids_file
    type:
      - 'null'
      - File
    doc: Path to file containing list of sample IDs to subset
    inputBinding:
      position: 103
      prefix: --sample-ids-file
  - id: slice
    type:
      - 'null'
      - string
    doc: Range formatted as begin:end (non-inclusive end) that specifies a 
      subset of record offsets within file
    inputBinding:
      position: 103
      prefix: --slice
  - id: sparse_fields
    type:
      - 'null'
      - string
    doc: Comma separated list of FORMAT fields to make sparse
    inputBinding:
      position: 103
      prefix: --sparse-fields
  - id: sparse_threshold
    type:
      - 'null'
      - float
    doc: Non-zero frequency threshold for which sparse fields are encoded as 
      sparse vectors
    inputBinding:
      position: 103
      prefix: --sparse-threshold
  - id: update_info
    type:
      - 'null'
      - string
    doc: Specifies whether AC, MAC, AN, AF and MAF info fields should be updated
      (always, never or auto)
    inputBinding:
      position: 103
      prefix: --update-info
outputs:
  - id: index_file
    type:
      - 'null'
      - File
    doc: Specifies index output file (SAV output only)
    outputBinding:
      glob: $(inputs.index_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/savvy:2.1.0--h5b0a936_4
