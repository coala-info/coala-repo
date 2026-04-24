cwlVersion: v1.2
class: CommandLineTool
baseCommand: tracs_distance
label: tracs_distance
doc: "Estimates pairwise SNP and transmission distances between each pair of samples
  aligned to the same reference genome.\n\nTool homepage: https://github.com/gtonkinhill/tracs"
inputs:
  - id: msa_files
    type:
      type: array
      items: File
    doc: Input fasta files formatted by the align and merge functions
    inputBinding:
      position: 1
  - id: clock_rate
    type:
      - 'null'
      - float
    doc: clock rate as defined in the transcluster paper (SNPs/genome/year)
    inputBinding:
      position: 102
      prefix: --clock_rate
  - id: filter
    type:
      - 'null'
      - boolean
    doc: Filter out regions with unusually high SNP distances often caused by 
      HGT
    inputBinding:
      position: 102
      prefix: --filter
  - id: loglevel
    type:
      - 'null'
      - string
    doc: Set the logging threshold.
    inputBinding:
      position: 102
      prefix: --loglevel
  - id: metadata
    type:
      - 'null'
      - File
    doc: Location of metadata in csv format. The first column must include the 
      sequence names and the second column must include sampling dates.
    inputBinding:
      position: 102
      prefix: --meta
  - id: msa_db
    type:
      - 'null'
      - File
    doc: A database MSA used to compare each sequence to. By default this is not
      uses and all pairwise comparisons within each MSA are considered.
    inputBinding:
      position: 102
      prefix: --msa-db
  - id: precision
    type:
      - 'null'
      - float
    doc: The precision used to calculate E(K)
    inputBinding:
      position: 102
      prefix: --precision
  - id: snp_threshold
    type:
      - 'null'
      - float
    doc: Only output those transmission pairs with a SNP distance <= D
    inputBinding:
      position: 102
      prefix: --snp_threshold
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    inputBinding:
      position: 102
      prefix: --threads
  - id: trans_rate
    type:
      - 'null'
      - int
    doc: transmission rate as defined in the transcluster paper 
      (transmissions/year)
    inputBinding:
      position: 102
      prefix: --trans_rate
  - id: trans_threshold
    type:
      - 'null'
      - int
    doc: Only outputs those pairs where the most likely number of intermediate 
      hosts <= K
    inputBinding:
      position: 102
      prefix: --trans_threshold
outputs:
  - id: output_file
    type: File
    doc: name of the output file to store the pairwise distance estimates.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tracs:1.0.1--py312h43eeafb_1
