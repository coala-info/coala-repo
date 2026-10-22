cwlVersion: v1.2
class: CommandLineTool
baseCommand: genRandomReads
label: subread_genRandomReads
doc: "Generate random reads (or read pairs) from a transcript FASTA file, or summarize the transcript FASTA.\n\nTool homepage: http://subread.sourceforge.net/"
inputs:
  - id: transcript_fasta
    type: File
    doc: The transcript database in FASTA/gz format.
    inputBinding:
      position: 1
      prefix: --transcriptFasta
  - id: output_prefix
    type: string
    doc: The prefix of the output files.
    inputBinding:
      position: 1
      prefix: --outputPrefix
  - id: summarize_fasta
    type:
      - 'null'
      - boolean
    doc: Only output the transcript names and lengths.
    inputBinding:
      position: 1
      prefix: --summarizeFasta
  - id: total_reads
    type:
      - 'null'
      - int
    doc: Total read/pairs in output.
    inputBinding:
      position: 1
      prefix: --totalReads
  - id: expression_levels
    type:
      - 'null'
      - File
    doc: "Two column table delimited by TAB, giving the wanted TPM values (TranscriptID and TPM)."
    inputBinding:
      position: 1
      prefix: --expressionLevels
  - id: read_length
    type:
      - 'null'
      - int
    doc: The length of the output reads. 100 by default.
    inputBinding:
      position: 1
      prefix: --readLen
  - id: rand_seed
    type:
      - 'null'
      - long
    doc: Seed to generate random numbers. UNIXTIME is used by default.
    inputBinding:
      position: 1
      prefix: --randSeed
  - id: quality_ref_file
    type:
      - 'null'
      - File
    doc: A textual file containing Phred+33 quality strings for simulating sequencing errors.
    inputBinding:
      position: 1
      prefix: --qualityRefFile
  - id: floor_strategy
    type:
      - 'null'
      - string
    doc: "How to deal with round-up errors: FLOOR, RANDOM or ITERATIVE."
    inputBinding:
      position: 1
      prefix: --floorStrategy
  - id: paired_end
    type:
      - 'null'
      - boolean
    doc: Generate paired-end reads.
    inputBinding:
      position: 1
      prefix: --pairedEnd
  - id: insertion_len_mean
    type:
      - 'null'
      - float
    doc: Mean of the truncated normal distribution of insertion lengths of paired-end reads. 160 by default.
    inputBinding:
      position: 1
      prefix: --insertionLenMean
  - id: insertion_len_sigma
    type:
      - 'null'
      - float
    doc: Sigma of the truncated normal distribution of insertion lengths. 30 by default.
    inputBinding:
      position: 1
      prefix: --insertionLenSigma
  - id: insertion_len_min
    type:
      - 'null'
      - int
    doc: Minimum insertion length. 110 by default.
    inputBinding:
      position: 1
      prefix: --insertionLenMin
  - id: insertion_len_max
    type:
      - 'null'
      - int
    doc: Maximum insertion length. 400 by default.
    inputBinding:
      position: 1
      prefix: --insertionLenMax
  - id: simple_transcript_id
    type:
      - 'null'
      - boolean
    doc: "Truncate transcript names to the first '|' or space."
    inputBinding:
      position: 1
      prefix: --simpleTranscriptId
  - id: truth_in_read_names
    type:
      - 'null'
      - boolean
    doc: Encode the true locations of reads in read names.
    inputBinding:
      position: 1
      prefix: --truthInReadNames
  - id: no_actual_reads
    type:
      - 'null'
      - boolean
    doc: Do not actually generate reads in fastq.gz files.
    inputBinding:
      position: 1
      prefix: --noActualReads
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Generated reads and summary files
    outputBinding:
      glob: "$(inputs.output_prefix)*"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/subread:2.1.1--h577a1d6_0
