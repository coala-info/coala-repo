cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/pfp++
label: pfp_pfp++
doc: "PFP++: A tool for parsing and processing genomic data using Prefix-Free Parsing.\n
  \nTool homepage: https://github.com/marco-oliva/pfp"
inputs:
  - id: acgt_only
    type:
      - 'null'
      - boolean
    doc: Convert all non ACGT characters from a VCF or FASTA file to N.
    inputBinding:
      position: 101
      prefix: --acgt-only
  - id: compress_dictionary
    type:
      - 'null'
      - boolean
    doc: Also output compressed the dictionary.
    inputBinding:
      position: 101
      prefix: --compress-dictionary
  - id: configure
    type:
      - 'null'
      - File
    doc: Read an ini file
    inputBinding:
      position: 101
      prefix: --configure
  - id: fasta
    type:
      - 'null'
      - File
    doc: Fasta file to parse.
    inputBinding:
      position: 101
      prefix: --fasta
  - id: haplotype
    type:
      - 'null'
      - string
    doc: 'Haplotype: [1,2,12].'
    inputBinding:
      position: 101
      prefix: --haplotype
  - id: int32t
    type:
      - 'null'
      - File
    doc: Integers file to parse.
    inputBinding:
      position: 101
      prefix: --int32t
  - id: int_shift
    type:
      - 'null'
      - int
    doc: Each integer i in int32t input is interpreted as (i + int-shift). Range [0
      - 200].
    inputBinding:
      position: 101
      prefix: --int-shift
  - id: max
    type:
      - 'null'
      - int
    doc: Max number of samples to analyze.
    inputBinding:
      position: 101
      prefix: --max
  - id: modulo
    type:
      - 'null'
      - int
    doc: Modulo used during parsing. Range [5 - 20000].
    inputBinding:
      position: 101
      prefix: --modulo
  - id: output_last
    type:
      - 'null'
      - boolean
    doc: Output last array.
    inputBinding:
      position: 101
      prefix: --output-last
  - id: output_occurrences
    type:
      - 'null'
      - boolean
    doc: Output count for each dictionary phrase.
    inputBinding:
      position: 101
      prefix: --output-occurrences
  - id: output_sai
    type:
      - 'null'
      - boolean
    doc: Output sai array.
    inputBinding:
      position: 101
      prefix: --output-sai
  - id: print_statistics
    type:
      - 'null'
      - boolean
    doc: Print out csv containing stats.
    inputBinding:
      position: 101
      prefix: --print-statistics
  - id: ref
    type:
      - 'null'
      - type: array
        items: string
    doc: List of comma ',' separated reference files. Assuming in genome order!
    inputBinding:
      position: 101
      prefix: --ref
  - id: samples
    type:
      - 'null'
      - File
    doc: File containing the list of samples to parse.
    inputBinding:
      position: 101
      prefix: --samples
  - id: text
    type:
      - 'null'
      - File
    doc: Text file to parse.
    inputBinding:
      position: 101
      prefix: --text
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads.
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Temporary files directory.
    inputBinding:
      position: 101
      prefix: --tmp-dir
  - id: use_vcf_acceleration
    type:
      - 'null'
      - boolean
    doc: Use reference parse to avoid re-parsing.
    inputBinding:
      position: 101
      prefix: --use-vcf-acceleration
  - id: vcf
    type:
      - 'null'
      - type: array
        items: string
    doc: List of comma ',' separated vcf files. Assuming in genome order!
    inputBinding:
      position: 101
      prefix: --vcf
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output.
    inputBinding:
      position: 101
      prefix: --verbose
  - id: window_size
    type:
      - 'null'
      - int
    doc: Sliding window size. Range [3 - 200].
    inputBinding:
      position: 101
      prefix: --window-size
outputs:
  - id: out_prefix
    type:
      - 'null'
      - File
    doc: Output prefix.
    outputBinding:
      glob: $(inputs.out_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pfp:0.3.9--h20648a7_3
