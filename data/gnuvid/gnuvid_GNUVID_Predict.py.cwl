cwlVersion: v1.2
class: CommandLineTool
baseCommand: GNUVID_Predict.py
label: gnuvid_GNUVID_Predict.py
doc: "GNUVID v2.4 uses the natural variation in public genomes of SARS-CoV-2 to rank
  gene sequences based on the number of observed exact matches (the GNU score) in
  all known genomes of SARS-CoV-2. It assigns a sequence type to each genome based
  on its profile of unique gene allele sequences. It can type (using whole genome
  multilocus sequence typing; wgMLST) your query genome in seconds. GNUVID_Predict
  is a speedy algorithm for assigning Clonal Complexes to new genomes, which uses
  machine learning Random Forest Classifier, implemented as of GNUVID v2.0.\n\nTool
  homepage: https://github.com/ahmedmagds/GNUVID"
inputs:
  - id: query_fna
    type: File
    doc: Query Whole Genome Nucleotide FASTA file to analyze (.fna)
    inputBinding:
      position: 1
  - id: block_pred
    type:
      - 'null'
      - int
    doc: prediction block size, good for limited memory
    inputBinding:
      position: 102
      prefix: --block_pred
  - id: exact_matching
    type:
      - 'null'
      - boolean
    doc: turn off exact matching (no allele will be identified for each ORF) and
      only use machine learning prediction
    inputBinding:
      position: 102
      prefix: --exact_matching
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwriting existing results folder assigned with -o
    inputBinding:
      position: 102
      prefix: --force
  - id: individual
    type:
      - 'null'
      - boolean
    doc: Individual Output file for each genome showing the allele sequence and 
      GNU score for each gene allele
    inputBinding:
      position: 102
      prefix: --individual
  - id: min_len
    type:
      - 'null'
      - int
    doc: minimum sequence length
    inputBinding:
      position: 102
      prefix: --min_len
  - id: n_max
    type:
      - 'null'
      - float
    doc: maximum proportion of ambiguity (Ns) allowed
    inputBinding:
      position: 102
      prefix: --n_max
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: Output folder and prefix to be created for results
    inputBinding:
      position: 102
      prefix: --output_folder
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: No screen output
    inputBinding:
      position: 102
      prefix: --quiet
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gnuvid:2.4--hdfd78af_0
stdout: gnuvid_GNUVID_Predict.py.out
