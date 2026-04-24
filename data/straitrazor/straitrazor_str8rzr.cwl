cwlVersion: v1.2
class: CommandLineTool
baseCommand: str8rzr
label: straitrazor_str8rzr
doc: "Processes fastq files to identify STRs based on a configuration file.\n\nTool
  homepage: https://github.com/Ahhgust/STRaitRazor"
inputs:
  - id: input_fastq_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Uncompressed fastq files to process
    inputBinding:
      position: 1
  - id: config_file
    type: File
    doc: the locus config file used to define the STRs
    inputBinding:
      position: 102
      prefix: -c
  - id: filter_type
    type:
      - 'null'
      - string
    doc: This filters on Type, e.g. AUTOSOMES; ie, it restricts the output to 
      STRs that have the same type as specified in column 2 of the config file
    inputBinding:
      position: 102
      prefix: -t
  - id: include_anchors
    type:
      - 'null'
      - boolean
    doc: includes the Anchor sequences in the reported haplotypes
    inputBinding:
      position: 102
      prefix: -i
  - id: max_hamming_distance_anchor
    type:
      - 'null'
      - int
    doc: the maximum Hamming distance used with anchor search. can only be 0, 1 
      or 2
    inputBinding:
      position: 102
      prefix: -a
  - id: max_hamming_distance_motif
    type:
      - 'null'
      - int
    doc: the maximum Hamming distance used with motif search. can only be 0 or 1
    inputBinding:
      position: 102
      prefix: -m
  - id: min_occurrences
    type:
      - 'null'
      - int
    doc: Min match; this causes haplotypes with less than f occurences to be 
      omitted from the final output file
    inputBinding:
      position: 102
      prefix: -f
  - id: no_reverse_complement
    type:
      - 'null'
      - boolean
    doc: turns off the default behavior of reverse-complementing matches on the 
      negative strand
    inputBinding:
      position: 102
      prefix: -n
  - id: num_processors
    type:
      - 'null'
      - int
    doc: The number of processors/cpus used
    inputBinding:
      position: 102
      prefix: -p
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: prints out additional diagnostic information
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: This writes the output to filename, as opposed to standard out
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/straitrazor:3.0.1--h7d875b9_3
