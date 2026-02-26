cwlVersion: v1.2
class: CommandLineTool
baseCommand: bgreat
label: bgreat
doc: "BGreat is a tool for de novo assembly of DNA sequencing reads.\n\nTool homepage:
  https://github.com/Malfoy/BGREAT2"
inputs:
  - id: anchor_fraction_to_index
    type:
      - 'null'
      - string
    doc: anchor fraction to be indexed
    default: 1=all, 5 for one out of 5
    inputBinding:
      position: 101
      prefix: -i
  - id: anchors_length
    type:
      - 'null'
      - int
    doc: anchors length
    default: 31
    inputBinding:
      position: 101
      prefix: -a
  - id: compress_output
    type:
      - 'null'
      - boolean
    doc: to compress output file
    inputBinding:
      position: 101
      prefix: -z
  - id: fastq_input
    type:
      - 'null'
      - boolean
    doc: if read file are FASTQ
    inputBinding:
      position: 101
      prefix: -q
  - id: k_value
    type: int
    doc: k value used for graph
    inputBinding:
      position: 101
      prefix: -k
  - id: keep_order
    type:
      - 'null'
      - boolean
    doc: to keep order of the reads
    inputBinding:
      position: 101
      prefix: -O
  - id: mapping_effort
    type:
      - 'null'
      - int
    doc: effort put in mapping
    default: 1000
    inputBinding:
      position: 101
      prefix: -e
  - id: maximal_anchor_occurrence
    type:
      - 'null'
      - int
    doc: maximal occurence of an anchor
    default: 1
    inputBinding:
      position: 101
      prefix: -o
  - id: mismatches_allowed
    type:
      - 'null'
      - int
    doc: number of missmatch allowed
    default: 5
    inputBinding:
      position: 101
      prefix: -m
  - id: output_all_mappings
    type:
      - 'null'
      - boolean
    doc: to output all possible mapping
    inputBinding:
      position: 101
      prefix: -A
  - id: output_all_optimal_mappings
    type:
      - 'null'
      - boolean
    doc: to output all possible optimal mapping
    inputBinding:
      position: 101
      prefix: -B
  - id: output_any_optimal_mapping
    type:
      - 'null'
      - boolean
    doc: to output any optimal mapping
    inputBinding:
      position: 101
      prefix: -F
  - id: output_compressed_reads
    type:
      - 'null'
      - boolean
    doc: to output compressed reads
    inputBinding:
      position: 101
      prefix: -C
  - id: output_corrected_reads
    type:
      - 'null'
      - boolean
    doc: to output corrected reads
    inputBinding:
      position: 101
      prefix: -c
  - id: paired_read_file
    type: File
    doc: read file (paired)
    inputBinding:
      position: 101
      prefix: -x
  - id: precise_output
    type:
      - 'null'
      - boolean
    doc: to more precise output
    inputBinding:
      position: 101
      prefix: -p
  - id: print_alignments
    type:
      - 'null'
      - boolean
    doc: to print the alignments
    inputBinding:
      position: 101
      prefix: -P
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads used
    default: 1
    inputBinding:
      position: 101
      prefix: -t
  - id: unitig_file
    type: File
    doc: unitig file (unitig.fa)
    inputBinding:
      position: 101
      prefix: -g
  - id: unpaired_read_file
    type: File
    doc: read file (unpaired)
    inputBinding:
      position: 101
      prefix: -u
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file (paths)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bgreat:2.0.0--hdb21b49_8
