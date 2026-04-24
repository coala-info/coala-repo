cwlVersion: v1.2
class: CommandLineTool
baseCommand: eskrim
label: eskrim
doc: "ESKRIM: EStimate with K-mers the RIchness in a Microbiome\n\nTool homepage:
  https://forgemia.inra.fr/metagenopolis/eskrim"
inputs:
  - id: input_fastq_files
    type:
      type: array
      items: File
    doc: INPUT_FASTQ_FILES with reads from a single metagenomic sample (gzip and
      bzip2 compression accepted)
    inputBinding:
      position: 1
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: length of kmers to count
    inputBinding:
      position: 102
      prefix: -k
  - id: num_threads
    type:
      - 'null'
      - int
    doc: NUM_THREADS to launch for kmers counting
    inputBinding:
      position: 102
      prefix: -t
  - id: read_length
    type:
      - 'null'
      - int
    doc: discard reads shorter than READ_LENGTH bases and trim those exceeding 
      this length
    inputBinding:
      position: 102
      prefix: -l
  - id: rng_seed
    type:
      - 'null'
      - int
    doc: Seed for random number generator
    inputBinding:
      position: 102
      prefix: --seed
  - id: sample_name
    type:
      - 'null'
      - string
    doc: name of the metagenomic sample
    inputBinding:
      position: 102
      prefix: -n
  - id: target_num_reads
    type:
      - 'null'
      - int
    doc: TARGET_NUM_READS to draw randomly from INPUT_FASTQ_FILES
    inputBinding:
      position: 102
      prefix: -r
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Temporary directory to store the jellyfish database
    inputBinding:
      position: 102
      prefix: --tmp-dir
outputs:
  - id: output_fastq_file
    type:
      - 'null'
      - File
    doc: OUTPUT_FASTQ_FILE with the randomly selected reads
    outputBinding:
      glob: $(inputs.output_fastq_file)
  - id: output_stats_file
    type: File
    doc: OUTPUT_STATS_FILE with kmer richness estimates
    outputBinding:
      glob: $(inputs.output_stats_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eskrim:1.0.9--pyhdfd78af_1
