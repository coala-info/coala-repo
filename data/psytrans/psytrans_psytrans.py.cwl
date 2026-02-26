cwlVersion: v1.2
class: CommandLineTool
baseCommand: psytrans.py
label: psytrans_psytrans.py
doc: "Perform SVM Classification of Host and Symbiont (or Parasite) Sequences\n\n\
  Tool homepage: https://github.com/rivera10/psytrans"
inputs:
  - id: queries
    type: File
    doc: The input queries sequences
    inputBinding:
      position: 1
  - id: blast_results
    type:
      - 'null'
      - File
    doc: Blast results obtained
    inputBinding:
      position: 102
      prefix: --blastResults
  - id: blast_type
    type:
      - 'null'
      - string
    doc: Type of blast search to be performed (blastx, blastn, tblastx)
    inputBinding:
      position: 102
      prefix: --blastType
  - id: both_strands
    type:
      - 'null'
      - boolean
    doc: Compute kmers for the forward and reverse strands
    inputBinding:
      position: 102
      prefix: --bothStrands
  - id: clear_temp
    type:
      - 'null'
      - boolean
    doc: Clear all temporary data upon completion
    inputBinding:
      position: 102
      prefix: --clearTemp
  - id: max_best_evalue
    type:
      - 'null'
      - float
    doc: Maximum e-value
    inputBinding:
      position: 102
      prefix: --maxBestEvalue
  - id: max_word_size
    type:
      - 'null'
      - int
    doc: Maxmimum value of DNA word length
    inputBinding:
      position: 102
      prefix: --maxWordSize
  - id: min_seq_size
    type:
      - 'null'
      - int
    doc: Minimum sequence size for training and testing
    inputBinding:
      position: 102
      prefix: --minSeqSize
  - id: min_word_size
    type:
      - 'null'
      - int
    doc: Minimum value of DNA word length
    inputBinding:
      position: 102
      prefix: --minWordSize
  - id: nb_threads
    type:
      - 'null'
      - int
    doc: Number of threads to run the BLAST search and SVM
    inputBinding:
      position: 102
      prefix: --nbThreads
  - id: number_of_seq
    type:
      - 'null'
      - int
    doc: Maximum number of sequences for training and testing
    inputBinding:
      position: 102
      prefix: --numberOfSeq
  - id: restart
    type:
      - 'null'
      - boolean
    doc: Continue process from last exit stage
    inputBinding:
      position: 102
      prefix: --restart
  - id: species1
    type:
      - 'null'
      - File
    doc: Reference sequences for the first species
    inputBinding:
      position: 102
      prefix: --species1
  - id: species2
    type:
      - 'null'
      - File
    doc: Reference sequences for the second species
    inputBinding:
      position: 102
      prefix: --species2
  - id: stop_after
    type:
      - 'null'
      - string
    doc: Optional exit upon completion of stage (db, runBlast, parseBlast, 
      kmers, SVM)
    inputBinding:
      position: 102
      prefix: --stopAfter
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: Location (prefix) of the temporary directory
    inputBinding:
      position: 102
      prefix: --tempDir
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Turn Verbose mode on?
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Name of optional output directory
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psytrans:2.0.0--hdfd78af_1
