cwlVersion: v1.2
class: CommandLineTool
baseCommand: mercat
label: mercat
doc: "MerCat: a k-mer based tool for microbial community analysis\n\nTool homepage:
  https://www.gnu.org/software/coreutils/"
inputs:
  - id: cores
    type:
      - 'null'
      - int
    doc: no of cores
    inputBinding:
      position: 101
      prefix: -n
  - id: fastq_input
    type:
      - 'null'
      - boolean
    doc: fastQ input file
    inputBinding:
      position: 101
      prefix: -q
  - id: input_file
    type:
      - 'null'
      - File
    doc: path-to-input-file
    inputBinding:
      position: 101
      prefix: -i
  - id: input_folder
    type:
      - 'null'
      - Directory
    doc: path-to-folder-containing-input-files
    inputBinding:
      position: 101
      prefix: -f
  - id: kmer_length
    type: int
    doc: kmer length
    inputBinding:
      position: 101
      prefix: -k
  - id: min_kmer_count
    type:
      - 'null'
      - int
    doc: minimum kmer count
    inputBinding:
      position: 101
      prefix: -c
  - id: protein_input
    type:
      - 'null'
      - boolean
    doc: protein input file
    inputBinding:
      position: 101
      prefix: -pro
  - id: run_prodigal
    type:
      - 'null'
      - boolean
    doc: run prodigal on fasta file
    inputBinding:
      position: 101
      prefix: -p
  - id: split_files_mb
    type:
      - 'null'
      - string
    doc: Split into x MB files. Default = 100MB
    inputBinding:
      position: 101
      prefix: -s
  - id: trimmomatic_options
    type:
      - 'null'
      - string
    doc: Trimmomatic options
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mercat:0.2--py_1
stdout: mercat.out
