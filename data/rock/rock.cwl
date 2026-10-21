cwlVersion: v1.2
class: CommandLineTool
baseCommand: rock
label: rock
doc: "Reducing Over-Covering K-mers within FASTQ file(s)\n\nTool homepage: https://gitlab.pasteur.fr/vlegrand/ROCK"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input FASTQ file(s) to process
    inputBinding:
      position: 1
  - id: expected_distinct_kmers
    type:
      - 'null'
      - int
    doc: expected total number of distinct k-mers within the input read 
      sequences; not compatible with option -l.
    inputBinding:
      position: 102
      prefix: -n
  - id: input_files_list
    type:
      - 'null'
      - File
    doc: 'file containing the name(s) of the input FASTQ file(s) to process; single-end:
      one file name per line; paired-end: two file names per line separated by a comma;
      up to 15 FASTQ file names can be specified; of note, input file name(s) can
      also be specified as program argument(s)'
    inputBinding:
      position: 102
      prefix: -i
  - id: output_files_list
    type:
      - 'null'
      - File
    doc: file containing the name(s) of the output FASTQ file(s); FASTQ file 
      name(s) should be structured in the same way as the file specified in 
      option -i.
    inputBinding:
      position: 102
      prefix: -o
  - id: output_fastq_names
    type:
      - 'null'
      - type: array
        items: string
    doc: Names of the output FASTQ files listed in the file given with -o (used to
      collect them)
  - id: input_list_members
    type:
      - 'null'
      - type: array
        items: File
    doc: FASTQ files named in the list given with -i (staged next to the working directory
      so that the names resolve)
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: k-mer length
    inputBinding:
      position: 102
      prefix: -k
  - id: lower_bound_coverage
    type:
      - 'null'
      - int
    doc: lower-bound k-mer coverage depth threshold
    inputBinding:
      position: 102
      prefix: -c
  - id: max_false_positive_prob
    type:
      - 'null'
      - float
    doc: maximum expected false positive probability when computing the optimal 
      number of hashing functions from the number of distinct k-mers specified 
      with option -n
    inputBinding:
      position: 102
      prefix: -f
  - id: min_phred_score_cutoff
    type:
      - 'null'
      - int
    doc: sets as valid only k-mers made up of nucleotides with Phred score (+33 
      offset) above this cutoff
    inputBinding:
      position: 102
      prefix: -q
  - id: min_valid_kmers_per_read
    type:
      - 'null'
      - int
    doc: minimum number of valid k-mer(s) to consider a read
    inputBinding:
      position: 102
      prefix: -m
  - id: num_hashing_functions
    type:
      - 'null'
      - int
    doc: number of hashing function(s)
    inputBinding:
      position: 102
      prefix: -l
  - id: process_pe_separately
    type:
      - 'null'
      - boolean
    doc: process PE reads separately. This allows the selection of more reads 
      which in some cases gives better assembly results.
    inputBinding:
      position: 102
      prefix: -p
  - id: upper_bound_coverage
    type:
      - 'null'
      - int
    doc: upper-bound k-mer coverage depth threshold
    inputBinding:
      position: 102
      prefix: -C
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose mode
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: output_fastq
    type:
      type: array
      items: File
    doc: Filtered FASTQ files (default names are <input>.rock.fastq; with -o, the names
      given in the output list file)
    outputBinding:
      glob:
        - '*.rock.fastq*'
        - $(inputs.output_fastq_names)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$(inputs.input_list_members ? inputs.input_list_members : [])"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rock:2.0--h4ac6f70_2
