cwlVersion: v1.2
class: CommandLineTool
baseCommand: rtax
label: rtax
doc: "Rapid and accurate taxonomic classification of short paired-end sequence reads
  from the 16S ribosomal RNA gene.\n\nTool homepage: https://github.com/SWRT-dev/rtax89x"
inputs:
  - id: fallback_single_ended
    type:
      - 'null'
      - boolean
    doc: for sequences where only one read is available, fall back to 
      single-ended classification.
    default: drop these sequences.
    inputBinding:
      position: 101
      prefix: -f
  - id: header_regex
    type:
      - 'null'
      - string
    doc: regular expression used to select part of the fasta header to use as 
      the sequence id.
    default: (\S+)
    inputBinding:
      position: 101
      prefix: -i
  - id: id_list_file
    type:
      - 'null'
      - File
    doc: text file containing sequence IDs to process, one per line
    inputBinding:
      position: 101
      prefix: -l
  - id: no_fallback_overly_generic
    type:
      - 'null'
      - boolean
    doc: for sequences where one read is overly generic, do not fall back to 
      single-ended classification.
    default: classify these sequences based on only the more specific read.
    inputBinding:
      position: 101
      prefix: -g
  - id: queryA
    type: File
    doc: FASTA file containing query sequences (single-ended or read 1)
    inputBinding:
      position: 101
      prefix: -a
  - id: queryB
    type: File
    doc: FASTA file containing query sequences (read b, with matching IDs)
    inputBinding:
      position: 101
      prefix: -b
  - id: read_delimiter
    type:
      - 'null'
      - string
    doc: delimiter separating the two reads when provided in a single file
    inputBinding:
      position: 101
      prefix: -d
  - id: refdb
    type: File
    doc: reference database in FASTA format
    inputBinding:
      position: 101
      prefix: -r
  - id: reverse_complement_queryA
    type:
      - 'null'
      - boolean
    doc: Reverse-complement query A sequences (required if they are provided in 
      the reverse sense)
    inputBinding:
      position: 101
      prefix: -x
  - id: reverse_complement_queryB
    type:
      - 'null'
      - boolean
    doc: Reverse-complement query B sequences (required if they are provided in 
      the reverse sense)
    inputBinding:
      position: 101
      prefix: -y
  - id: taxonomy
    type: File
    doc: taxonomy file with sequence IDs matching the reference database
    inputBinding:
      position: 101
      prefix: -t
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: temporary directory. Will be removed on successful completion, but 
      likely not if there is an error.
    inputBinding:
      position: 101
      prefix: -m
outputs:
  - id: classifications_out
    type: File
    doc: output path
    outputBinding:
      glob: $(inputs.classifications_out)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rtax:v0.984-6-deb_cv1
