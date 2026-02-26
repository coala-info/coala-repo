cwlVersion: v1.2
class: CommandLineTool
baseCommand: assess_assembly
label: pomoxis_assess_assembly
doc: "Calculate accuracy statistics for an assembly.\n\nTool homepage: https://github.com/nanoporetech/pomoxis"
inputs:
  - id: accumulate_stats_chunks
    type:
      - 'null'
      - type: array
        items: string
    doc: accumulate the stats over a number of chunks, can include multiple 
      values separated by comma, one summary file will be generated for each 
      value
    default: 10,100
    inputBinding:
      position: 101
      prefix: -a
  - id: catalogue_errors
    type:
      - 'null'
      - boolean
    doc: catalogue errors.
    inputBinding:
      position: 101
      prefix: -C
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: "chunk size. Input reads/contigs will be broken into chunks\nprior to alignment,
      0 will not chunk"
    default: 100000
    inputBinding:
      position: 101
      prefix: -c
  - id: count_homopolymers
    type:
      - 'null'
      - boolean
    doc: count homopolymers.
    inputBinding:
      position: 101
      prefix: -H
  - id: exclude_indels_bed
    type:
      - 'null'
      - File
    doc: use with -l option to create a .bed file to exclude indels. If the -b 
      option is used, the two bed files will be combined.
    inputBinding:
      position: 101
      prefix: -e
  - id: include_supplementary_alignments
    type:
      - 'null'
      - boolean
    doc: include supplementary alignments.
    inputBinding:
      position: 101
      prefix: -y
  - id: input_assembly
    type: File
    doc: fastq/a input assembly
    inputBinding:
      position: 101
      prefix: -i
  - id: min_indel_length
    type:
      - 'null'
      - int
    doc: 'list all indels at least this long (default: 0, set to 0 to skip searching
      for indels).'
    default: 0
    inputBinding:
      position: 101
      prefix: -l
  - id: minimap2_preset
    type:
      - 'null'
      - string
    doc: set the minimap2 preset, e.g. map-ont, asm5, asm10, asm20
    default: map-ont
    inputBinding:
      position: 101
      prefix: -d
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: output file prefix
    default: assm
    inputBinding:
      position: 101
      prefix: -p
  - id: reference
    type: File
    doc: "reference, should be a fasta file. If correspondng minimap2 indices\ndo
      not exist they will be created."
    inputBinding:
      position: 101
      prefix: -r
  - id: reference_regions_bed
    type:
      - 'null'
      - File
    doc: .bed file of reference regions to assess.
    inputBinding:
      position: 101
      prefix: -b
  - id: threads
    type:
      - 'null'
      - int
    doc: alignment threads
    default: 1
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
stdout: pomoxis_assess_assembly.out
