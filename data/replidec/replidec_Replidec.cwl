cwlVersion: v1.2
class: CommandLineTool
baseCommand: Replidec
label: replidec_Replidec
doc: "Replidec, Replication cycle prediction tool for prokaryotic viruses\n\nTool
  homepage: https://github.com/deng-lab/Replidec"
inputs:
  - id: blastp_eval
    type:
      - 'null'
      - float
    doc: E-value threshold to filter blast result
    inputBinding:
      position: 101
      prefix: --blastp_Eval
  - id: blastp_parameter
    type:
      - 'null'
      - string
    doc: Parameters used for blastp
    inputBinding:
      position: 101
      prefix: --blastp_parameter
  - id: db_redownload
    type:
      - 'null'
      - boolean
    doc: Remove and re-download database
    inputBinding:
      position: 101
      prefix: --db_redownload
  - id: file_name
    type:
      - 'null'
      - string
    doc: Name of final summary file
    inputBinding:
      position: 101
      prefix: --file_name
  - id: hmmer_eval
    type:
      - 'null'
      - float
    doc: E-value threshold to filter hmmer result
    inputBinding:
      position: 101
      prefix: --hmmer_Eval
  - id: hmmer_parameters
    type:
      - 'null'
      - string
    doc: Parameters used for hmmer
    inputBinding:
      position: 101
      prefix: --hmmer_parameters
  - id: input_file
    type:
      - 'null'
      - File
    doc: The input file, which can be a sequence file or an index table
    inputBinding:
      position: 101
      prefix: --input_file
  - id: mmseq_eval
    type:
      - 'null'
      - float
    doc: E-value threshold to filter mmseqs2 result
    inputBinding:
      position: 101
      prefix: --mmseq_Eval
  - id: mmseq_parameters
    type:
      - 'null'
      - string
    doc: Parameter used for mmseqs
      --min-aln-len 40 --cov-mode 0 --greedy-best-hits 1 --threads 3
    inputBinding:
      position: 101
      prefix: --mmseq_parameters
  - id: program
    type: string
    doc: 'mode selection: multi_fasta, genome_table, or protein_table'
    inputBinding:
      position: 101
      prefix: --program
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of parallel threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: work_dir
    type:
      - 'null'
      - Directory
    doc: Directory to store intermediate and final results
    inputBinding:
      position: 101
      prefix: --work_dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/replidec:0.3.5--pyhdfd78af_0
stdout: replidec_Replidec.out
