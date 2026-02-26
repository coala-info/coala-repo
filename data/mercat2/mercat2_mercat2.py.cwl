cwlVersion: v1.2
class: CommandLineTool
baseCommand: mercat2.py
label: mercat2_mercat2.py
doc: "mercat2.py is a tool for kmer analysis of metagenomic data.\n\nTool homepage:
  https://github.com/raw-lab/mercat2"
inputs:
  - id: convert_to_uppercase
    type:
      - 'null'
      - boolean
    doc: convert all input sequences to uppercase
    inputBinding:
      position: 101
      prefix: -toupper
  - id: create_pca_plot
    type:
      - 'null'
      - boolean
    doc: create interactive PCA plot of the samples (minimum of 4 fasta files 
      required)
    inputBinding:
      position: 101
      prefix: -pca
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: path to input file
    inputBinding:
      position: 101
      prefix: -i
  - id: input_folder
    type:
      - 'null'
      - Directory
    doc: path to folder containing input files
    inputBinding:
      position: 101
      prefix: -f
  - id: kmer_length
    type: int
    doc: kmer length
    inputBinding:
      position: 101
      prefix: -k
  - id: low_memory_pca
    type:
      - 'null'
      - string
    doc: Flag to use incremental PCA when low memory is available.
    default: auto
    inputBinding:
      position: 101
      prefix: -lowmem
  - id: min_kmer_count
    type:
      - 'null'
      - int
    doc: minimum kmer count
    default: 10
    inputBinding:
      position: 101
      prefix: -c
  - id: num_cores
    type:
      - 'null'
      - string
    doc: no of cores
    default: auto detect
    inputBinding:
      position: 101
      prefix: -n
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: Output folder
    default: "'mercat_results' in current directory"
    inputBinding:
      position: 101
      prefix: -o
  - id: replace_output
    type:
      - 'null'
      - boolean
    doc: Replace existing output directory
    default: false
    inputBinding:
      position: 101
      prefix: -replace
  - id: run_fraggenescanrs
    type:
      - 'null'
      - boolean
    doc: run FragGeneScanRS on fasta files
    inputBinding:
      position: 101
      prefix: -fgs
  - id: run_prodigal
    type:
      - 'null'
      - boolean
    doc: run Prodigal on fasta files
    inputBinding:
      position: 101
      prefix: --prod
  - id: skip_clean
    type:
      - 'null'
      - boolean
    doc: skip trimming of fastq files
    inputBinding:
      position: 101
      prefix: -skipclean
  - id: split_mb_files
    type:
      - 'null'
      - int
    doc: Split into x MB files.
    default: 100
    inputBinding:
      position: 101
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mercat2:1.4.1--pyhdfd78af_0
stdout: mercat2_mercat2.py.out
