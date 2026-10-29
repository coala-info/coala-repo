cwlVersion: v1.2
class: CommandLineTool
baseCommand: make_batch_for_iteratively_mapping_assembling.py
label: getorganelle_make_batch_for_iteratively_mapping_assembling.py
doc: "Make a batch file for iteratively mapping with bowtie2 and assembling with SPAdes.\n\nTool homepage: http://github.com/Kinggerm/GetOrganelle"
inputs:
  - id: fastq_file_1
    type:
      - File
    doc: "Input 1st fastq format file as pool."
    inputBinding:
      position: 101
      prefix: "-1"
  - id: fastq_file_2
    type:
      - File
    doc: "Input 2nd fastq format file as pool."
    inputBinding:
      position: 101
      prefix: "-2"
  - id: seed_fasta
    type:
      - File
    doc: "Input fasta format file as initial seed."
    inputBinding:
      position: 101
      prefix: "-s"
  - id: rounds
    type:
      - 'null'
      - int
    doc: "How many iterations would you like to have? Default=3"
    inputBinding:
      position: 101
      prefix: "-R"
  - id: threads
    type:
      - 'null'
      - int
    doc: "Threads used for bowtie2 and SPAdes. Default=1"
    inputBinding:
      position: 101
      prefix: "-t"
  - id: spades_kmer
    type:
      - 'null'
      - string
    doc: "SPAdes k-mer settings. Use the same format as in SPAdes. Default=21,45,65,85,105"
    inputBinding:
      position: 101
      prefix: "-k"
  - id: output_sh_file
    type:
      - string
    doc: "Executable output batch file (the script writes <name>.sh and one <name>.mapped.RUN<N> folder per round)."
    inputBinding:
      position: 101
      prefix: "-o"
  - id: unpaired
    type:
      - 'null'
      - boolean
    doc: "Try to map and assembly without paired information."
    inputBinding:
      position: 101
      prefix: "--un"
  - id: random_seed
    type:
      - 'null'
      - int
    doc: "Seed for random generator for bowtie2. Default: 12345"
    inputBinding:
      position: 101
      prefix: "--random-seed"
  - id: which_bowtie2
    type:
      - 'null'
      - string
    doc: "Assign the path to Bowtie2 binary files if not added to the path. Default: try GetOrganelleDep/linux/bowtie2 first, then $PATH"
    inputBinding:
      position: 101
      prefix: "--which-bowtie2"
  - id: which_spades
    type:
      - 'null'
      - string
    doc: "Assign the path to SPAdes binary files if not added to the path. Default: try GetOrganelleDep/linux/SPAdes first, then $PATH"
    inputBinding:
      position: 101
      prefix: "--which-spades"
outputs:
  - id: batch_script
    type:
      - File
    doc: "Executable output batch file (<name>.sh)."
    outputBinding:
      glob: "$(inputs.output_sh_file).sh"
  - id: round_dirs
    type:
      type: array
      items: Directory
    doc: "Empty per-round folders created for the batch commands."
    outputBinding:
      glob: "$(inputs.output_sh_file).mapped.RUN*"
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/getorganelle:1.7.7.1--pyhdfd78af_0
stdout: getorganelle_make_batch_for_iteratively_mapping_assembling.py.out
