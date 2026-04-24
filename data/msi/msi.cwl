cwlVersion: v1.2
class: CommandLineTool
baseCommand: msi.sh
label: msi
doc: "MSI_DIR variable not set. Setting it to /usr/local\nonly -i or -c are mandatory.\n\
  \nTool homepage: http://github.com/nunofonseca/msi/"
inputs:
  - id: blast_database
    type:
      - 'null'
      - File
    doc: path to the blast database
    inputBinding:
      position: 101
      prefix: -b
  - id: blast_evalue
    type:
      - 'null'
      - float
    doc: value passed to blast (minimum e-value - value < 1)
    inputBinding:
      position: 101
      prefix: -E
  - id: blast_min_id
    type:
      - 'null'
      - float
    doc: value passed to blast (minimum % id - value between 0 and 100)
    inputBinding:
      position: 101
      prefix: -B
  - id: max_len
    type:
      - 'null'
      - int
    doc: maximum length of the reads
    inputBinding:
      position: 101
      prefix: -M
  - id: metadata
    type:
      - 'null'
      - File
    doc: metadata file* tsv file were the file name should be found in one 
      column and the column names (first line of the file) X, Y, Z should exist.
    inputBinding:
      position: 101
      prefix: -I
  - id: min_cluster_id2
    type:
      - 'null'
      - float
    doc: minimum cluster identity (sequences with a value greater or equal are 
      clustered together - value between 0 and 1)
    inputBinding:
      position: 101
      prefix: -T
  - id: min_len
    type:
      - 'null'
      - int
    doc: minimum length of the reads
    inputBinding:
      position: 101
      prefix: -m
  - id: min_qual
    type:
      - 'null'
      - int
    doc: minimum quality
    inputBinding:
      position: 101
      prefix: -q
  - id: min_reads
    type:
      - 'null'
      - int
    doc: minimum number of reads that a cluster should have
    inputBinding:
      position: 101
      prefix: -C
  - id: params_file
    type: File
    doc: file with default parameters values (overrides values passed in the 
      command line)
    inputBinding:
      position: 101
      prefix: -c
  - id: raw_data_toplevel_folder
    type: Directory
    doc: toplevel directory with the nanopore data. fastq files will be searched
      in $tl_dir/*.fastq.gz. It is expected one file per library/barcode.
    inputBinding:
      position: 101
      prefix: -i
  - id: run_fastqc
    type:
      - 'null'
      - boolean
    doc: run fastqc to generate qc reports for the fastq files
    inputBinding:
      position: 101
      prefix: -r
  - id: stop_before_blast
    type:
      - 'null'
      - boolean
    doc: stop execution before running blast
    inputBinding:
      position: 101
      prefix: -S
  - id: threads
    type:
      - 'null'
      - int
    doc: maximum number of threads
    inputBinding:
      position: 101
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: increase verbosity
    inputBinding:
      position: 101
      prefix: -V
outputs:
  - id: out_folder
    type:
      - 'null'
      - Directory
    doc: output folder
    outputBinding:
      glob: $(inputs.out_folder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msi:0.3.8--hdfd78af_0
