cwlVersion: v1.2
class: CommandLineTool
baseCommand: seer
label: seer
doc: "sequence element enrichment analysis\n\nTool homepage: https://github.com/johnlees/seer"
inputs:
  - id: chisq
    type:
      - 'null'
      - float
    doc: p-value threshold for initial chi squared test. Set to 1 to show all
    default: 1e-05
    inputBinding:
      position: 101
      prefix: --chisq
  - id: covar_file
    type:
      - 'null'
      - File
    doc: file containing covariates
    inputBinding:
      position: 101
      prefix: --covar_file
  - id: covar_list
    type:
      - 'null'
      - string
    doc: list of columns covariates to use. Format is 1,2q,3 (use q for 
      quantitative)
    inputBinding:
      position: 101
      prefix: --covar_list
  - id: kmers_file
    type: File
    doc: dsm kmer output file
    inputBinding:
      position: 101
      prefix: --kmers
  - id: maf
    type:
      - 'null'
      - float
    doc: minimum kmer frequency
    default: 0.01
    inputBinding:
      position: 101
      prefix: --maf
  - id: max_length
    type:
      - 'null'
      - int
    doc: maximum kmer length
    default: 100
    inputBinding:
      position: 101
      prefix: --max_length
  - id: min_words
    type:
      - 'null'
      - int
    doc: minimum kmer occurences. Overrides --maf
    inputBinding:
      position: 101
      prefix: --min_words
  - id: no_filtering
    type:
      - 'null'
      - boolean
    doc: turn off all filtering and perform tests on all kmers input
    inputBinding:
      position: 101
      prefix: --no_filtering
  - id: pheno_file
    type: File
    doc: .pheno metadata
    inputBinding:
      position: 101
      prefix: --pheno
  - id: print_samples
    type:
      - 'null'
      - boolean
    doc: print lists of samples significant kmers were found in
    inputBinding:
      position: 101
      prefix: --print_samples
  - id: pval
    type:
      - 'null'
      - float
    doc: p-value threshold for final logistic test. Set to 1 to show all
    default: 1e-08
    inputBinding:
      position: 101
      prefix: --pval
  - id: struct_file
    type:
      - 'null'
      - File
    doc: mds values from kmds
    inputBinding:
      position: 101
      prefix: --struct
  - id: threads
    type:
      - 'null'
      - int
    doc: 'number of threads. Suggested: 20'
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/seer:v1.1.4-2b2-deb_cv1
stdout: seer.out
