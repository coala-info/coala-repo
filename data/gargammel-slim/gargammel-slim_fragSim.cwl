cwlVersion: v1.2
class: CommandLineTool
baseCommand: fragSim
label: gargammel-slim_fragSim
doc: "This program takes a fasta file representing a chromosome and generates\naDNA
  fragments according to a certain distribution\n\nTool homepage: https://github.com/grenaud/gargammel"
inputs:
  - id: chromosome_fasta
    type:
      - 'null'
      - File
    doc: Input chromosome fasta file
    inputBinding:
      position: 1
  - id: base_composition_file
    type:
      - 'null'
      - File
    doc: Base composition for the fragments
    inputBinding:
      position: 102
      prefix: --comp
  - id: deflines_or_bam_tags
    type:
      - 'null'
      - string
    doc: Append this string to deflines or BAM tags
    inputBinding:
      position: 102
      prefix: -tag
  - id: distance_file
    type:
      - 'null'
      - File
    doc: Distance from ends to consider
    default: 1
    inputBinding:
      position: 102
      prefix: --dist
  - id: fixed_fragment_length
    type:
      - 'null'
      - int
    doc: Generate fragments of fixed length
    default: 20
    inputBinding:
      position: 102
      prefix: -l
  - id: fragment_size_distribution_file
    type:
      - 'null'
      - File
    doc: Open file with size distribution (one fragment length per line)
    inputBinding:
      position: 102
      prefix: -s
  - id: fragment_size_frequency_file
    type:
      - 'null'
      - File
    doc: 'Open file with size frequency in the following format: length[TAB]freq'
    inputBinding:
      position: 102
      prefix: -f
  - id: gc_bias_factor
    type:
      - 'null'
      - float
    doc: Use GC bias factor
    default: 0
    inputBinding:
      position: 102
      prefix: -gc
  - id: lognormal_distribution_location_file
    type:
      - 'null'
      - File
    doc: Location for lognormal distribution
    inputBinding:
      position: 102
      prefix: --loc
  - id: lognormal_distribution_scale_file
    type:
      - 'null'
      - File
    doc: Scale for lognormal distribution
    inputBinding:
      position: 102
      prefix: --scale
  - id: max_fragment_length
    type:
      - 'null'
      - int
    doc: Maximum fragments length
    default: 1000
    inputBinding:
      position: 102
      prefix: -M
  - id: min_fragment_length
    type:
      - 'null'
      - int
    doc: Minimum fragments length
    default: 0
    inputBinding:
      position: 102
      prefix: -m
  - id: no_reverse_complement
    type:
      - 'null'
      - boolean
    doc: Do not reverse complement
    inputBinding:
      position: 102
      prefix: --norev
  - id: no_uppercase
    type:
      - 'null'
      - boolean
    doc: Do not set the sequence to upper-case
    inputBinding:
      position: 102
      prefix: --case
  - id: num_fragments
    type:
      - 'null'
      - int
    doc: Generate [number] fragments
    default: 10
    inputBinding:
      position: 102
      prefix: -n
  - id: temporary_directory
    type:
      - 'null'
      - Directory
    doc: Use this directory as the temporary dir for zipped files
    default: /tmp/
    inputBinding:
      position: 102
      prefix: -tmp
  - id: uncompressed_bam
    type:
      - 'null'
      - boolean
    doc: Produce uncompressed BAM (good for unix pipe)
    inputBinding:
      position: 102
      prefix: -u
  - id: unique_fragment_names
    type:
      - 'null'
      - boolean
    doc: Make sure that the fragment names are unique by appending a suffix
    inputBinding:
      position: 102
      prefix: -uniq
outputs:
  - id: output_bam_file
    type:
      - 'null'
      - File
    doc: Write output as a BAM file
    outputBinding:
      glob: $(inputs.output_bam_file)
  - id: output_zipped_fasta_file
    type:
      - 'null'
      - File
    doc: Write output as a zipped fasta
    outputBinding:
      glob: $(inputs.output_zipped_fasta_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gargammel-slim:1.1.2--hf107e4d_6
