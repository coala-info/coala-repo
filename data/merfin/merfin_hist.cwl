cwlVersion: v1.2
class: CommandLineTool
baseCommand: merfin
label: merfin_hist
doc: "Predict the kmer consequences of variant calls <input.vcf> given the consensus
  sequence <seq.fasta> and lookup the k-mer multiplicity in the consensus sequence
  <seq.meryl> and in the reads <read.meryl>.\n\nTool homepage: https://github.com/arangrhie/merfin"
inputs:
  - id: report_type
    type: string
    doc: Exactly one report type must be specified.
    inputBinding:
      position: 1
  - id: comb
    type:
      - 'null'
      - int
    doc: set the max N of combinations of variants to be evaluated
    inputBinding:
      position: 102
      prefix: -comb
  - id: debug
    type:
      - 'null'
      - boolean
    doc: output a debug log, into <output>.THREAD_ID.debug.gz
    inputBinding:
      position: 102
      prefix: -debug
  - id: max_kmer_value
    type:
      - 'null'
      - int
    doc: Ignore kmers with value above m
    inputBinding:
      position: 102
      prefix: -max
  - id: memory
    type:
      - 'null'
      - string
    doc: Don't use more than m GB memory for loading mers
    inputBinding:
      position: 102
      prefix: -memory
  - id: min_kmer_value
    type:
      - 'null'
      - int
    doc: Ignore kmers with value below m
    inputBinding:
      position: 102
      prefix: -min
  - id: nosplit
    type:
      - 'null'
      - boolean
    doc: without this options combinations larger than N are split
    inputBinding:
      position: 102
      prefix: -nosplit
  - id: output
    type: string
    doc: Output file prefix
    inputBinding:
      position: 102
      prefix: -output
  - id: peak
    type: File
    doc: Required input to hard set copy 1 and infer multiplicity to copy number
      (recommended).
    inputBinding:
      position: 102
      prefix: -peak
  - id: prob
    type:
      - 'null'
      - File
    doc: Optional input vector of probabilities. Adjust multiplicity to copy 
      number in case both -prob and -peak are provided, -prob takes higher 
      priority than -peak for multiplicity listed in the vector table.
    inputBinding:
      position: 102
      prefix: -prob
  - id: readmers
    type: File
    doc: Input -sequence and -vcf files can be FASTA or FASTQ; uncompressed, gz,
      bz2 or xz compressed
    inputBinding:
      position: 102
      prefix: -readmers
  - id: seqmers
    type:
      - 'null'
      - File
    doc: Optional input for pre-built sequence meryl db
    inputBinding:
      position: 102
      prefix: -seqmers
  - id: sequence
    type: File
    doc: Input -sequence and -vcf files can be FASTA or FASTQ; uncompressed, gz,
      bz2 or xz compressed
    inputBinding:
      position: 102
      prefix: -sequence
  - id: skip_missing
    type:
      - 'null'
      - boolean
    doc: skip the missing kmer sites to be printed
    inputBinding:
      position: 102
      prefix: -skipMissing
  - id: threads
    type:
      - 'null'
      - int
    doc: Multithreading for meryl lookup table construction, dump and hist.
    inputBinding:
      position: 102
      prefix: -threads
  - id: vcf
    type: File
    doc: Input -sequence and -vcf files can be FASTA or FASTQ; uncompressed, gz,
      bz2 or xz compressed
    inputBinding:
      position: 102
      prefix: -vcf
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merfin:1.0--h9948957_3
stdout: merfin_hist.out
