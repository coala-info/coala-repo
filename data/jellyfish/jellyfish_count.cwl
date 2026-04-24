cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jellyfish
  - count
label: jellyfish_count
doc: "Count k-mers in fasta or fastq files\n\nTool homepage: http://www.genome.umd.edu/jellyfish.html"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input fasta or fastq files
    inputBinding:
      position: 1
  - id: bloom_counter_path
    type:
      - 'null'
      - File
    doc: Bloom counter to filter out singleton mers
    inputBinding:
      position: 102
      prefix: --bc
  - id: bloom_filter_false_positive_rate
    type:
      - 'null'
      - float
    doc: False positive rate of bloom filter
    inputBinding:
      position: 102
      prefix: --bf-fp
  - id: bloom_filter_size
    type:
      - 'null'
      - int
    doc: Use bloom filter to count high-frequency mers
    inputBinding:
      position: 102
      prefix: --bf-size
  - id: canonical
    type:
      - 'null'
      - boolean
    doc: Count both strand, canonical representation
    inputBinding:
      position: 102
      prefix: --canonical
  - id: counter_len_bits
    type:
      - 'null'
      - int
    doc: Length bits of counting field
    inputBinding:
      position: 102
      prefix: --counter-len
  - id: disk_operation
    type:
      - 'null'
      - boolean
    doc: Disk operation. Do not do size doubling
    inputBinding:
      position: 102
      prefix: --disk
  - id: generator_file
    type:
      - 'null'
      - File
    doc: File of commands generating fast[aq]
    inputBinding:
      position: 102
      prefix: --generator
  - id: generator_shell
    type:
      - 'null'
      - string
    doc: Shell used to run generator commands
    inputBinding:
      position: 102
      prefix: --shell
  - id: include_files
    type:
      - 'null'
      - File
    doc: Count only k-mers in this files
    inputBinding:
      position: 102
      prefix: --if
  - id: initial_hash_size
    type: int
    doc: Initial hash size
    inputBinding:
      position: 102
      prefix: --size
  - id: lower_count
    type:
      - 'null'
      - int
    doc: Don't output k-mer with count < lower-count
    inputBinding:
      position: 102
      prefix: --lower-count
  - id: max_reprobes
    type:
      - 'null'
      - int
    doc: Maximum number of reprobes
    inputBinding:
      position: 102
      prefix: --reprobes
  - id: mer_len
    type: int
    doc: Length of mer
    inputBinding:
      position: 102
      prefix: --mer-len
  - id: min_qual_char
    type:
      - 'null'
      - string
    doc: Any base with quality below this character is changed to N
    inputBinding:
      position: 102
      prefix: --min-qual-char
  - id: min_quality
    type:
      - 'null'
      - int
    doc: Minimum quality. A base with lesser quality becomes an N
    inputBinding:
      position: 102
      prefix: --min-quality
  - id: num_files_open_simultaneously
    type:
      - 'null'
      - int
    doc: Number files open simultaneously
    inputBinding:
      position: 102
      prefix: --Files
  - id: num_generators_simultaneously
    type:
      - 'null'
      - int
    doc: Number of generators run simultaneously
    inputBinding:
      position: 102
      prefix: --Generators
  - id: out_counter_len_bytes
    type:
      - 'null'
      - int
    doc: Length in bytes of counter field in output
    inputBinding:
      position: 102
      prefix: --out-counter-len
  - id: output_file
    type:
      - 'null'
      - string
    doc: Output file
    inputBinding:
      position: 102
      prefix: --output
  - id: quality_start_ascii
    type:
      - 'null'
      - int
    doc: ASCII for quality values
    inputBinding:
      position: 102
      prefix: --quality-start
  - id: sam_input_file
    type:
      - 'null'
      - File
    doc: SAM/BAM/CRAM formatted input file
    inputBinding:
      position: 102
      prefix: --sam
  - id: text_format
    type:
      - 'null'
      - boolean
    doc: Dump in text format
    inputBinding:
      position: 102
      prefix: --text
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 102
      prefix: --threads
  - id: timing_file
    type:
      - 'null'
      - File
    doc: Print timing information
    inputBinding:
      position: 102
      prefix: --timing
  - id: upper_count
    type:
      - 'null'
      - int
    doc: Don't output k-mer with count > upper-count
    inputBinding:
      position: 102
      prefix: --upper-count
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/jellyfish:v2.2.10-2-deb_cv1
stdout: jellyfish_count.out
