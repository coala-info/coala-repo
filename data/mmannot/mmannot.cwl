cwlVersion: v1.2
class: CommandLineTool
baseCommand: mmannot
label: mmannot
doc: "Compulsory options:\n\t-a file: annotation file in GTF format\n\t-r file1 [file2
  ...]: reads in BAM/SAM format\n\nTool homepage: https://github.com/mzytnicki/mmannot"
inputs:
  - id: annotation_file
    type: File
    doc: annotation file in GTF format
    inputBinding:
      position: 101
      prefix: -a
  - id: config_file
    type:
      - 'null'
      - File
    doc: configuration file
    inputBinding:
      position: 101
      prefix: -c
  - id: downstream_region_size
    type:
      - 'null'
      - int
    doc: downstream region size
    inputBinding:
      position: 101
      prefix: -D
  - id: mapping_statistics_intervals
    type:
      - 'null'
      - File
    doc: print mapping statistics for each interval (slow, only work with 1 
      input file)
    inputBinding:
      position: 101
      prefix: -M
  - id: mapping_statistics_reads
    type:
      - 'null'
      - File
    doc: print mapping statistics for each read (slow, only work with 1 input 
      file)
    inputBinding:
      position: 101
      prefix: -m
  - id: min_hit_percentage
    type:
      - 'null'
      - int
    doc: attribute a read to a feature if at least N% of the hits map to the 
      feature
    inputBinding:
      position: 101
      prefix: -e
  - id: overlap_type
    type:
      - 'null'
      - int
    doc: 'overlap type (<0: read is included, <1: % overlap, otherwise: # nt)'
    inputBinding:
      position: 101
      prefix: -l
  - id: print_progress
    type:
      - 'null'
      - boolean
    doc: print progress
    inputBinding:
      position: 101
      prefix: -p
  - id: quantification_strategy
    type:
      - 'null'
      - string
    doc: 'quantification strategy, valid values are: default, unique, random, ratio'
    inputBinding:
      position: 101
      prefix: -y
  - id: read_format
    type:
      - 'null'
      - string
    doc: format of the read files (SAM or BAM)
    inputBinding:
      position: 101
      prefix: -f
  - id: read_names
    type:
      - 'null'
      - type: array
        items: string
    doc: short name for each of the reads files
    inputBinding:
      position: 101
      prefix: -n
  - id: reads_files
    type:
      type: array
      items: File
    doc: reads in BAM/SAM format
    inputBinding:
      position: 101
      prefix: -r
  - id: strand
    type:
      - 'null'
      - string
    doc: 'strand (U, F, R, FR, RF, FF, defaut: F) (use several strand types if the
      library strategies differ)'
    inputBinding:
      position: 101
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: '# threads'
    inputBinding:
      position: 101
      prefix: -t
  - id: upstream_region_size
    type:
      - 'null'
      - int
    doc: upstream region size
    inputBinding:
      position: 101
      prefix: -d
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmannot:1.1--hd03093a_0
