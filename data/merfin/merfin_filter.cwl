cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - merfin
  - -filter
label: merfin_filter
doc: "Filter variants within distance k and their combinations by missing k-mers. Assumes the reference (-sequence) is from a different individual.\n\nTool homepage: https://github.com/arangrhie/merfin"
inputs:
  - id: sequence
    type: File
    doc: "Consensus sequence FASTA or FASTQ file (uncompressed, gz, bz2 or xz compressed)"
    inputBinding:
      position: 102
      prefix: -sequence
  - id: readmers
    type: Directory
    doc: "Read k-mer database (meryl database directory built from the reads)"
    inputBinding:
      position: 102
      prefix: -readmers
  - id: vcf
    type: File
    doc: "Input VCF file (FASTA or FASTQ style compressed inputs allowed)"
    inputBinding:
      position: 102
      prefix: -vcf
  - id: output
    type: string
    doc: "Output file prefix"
    inputBinding:
      position: 102
      prefix: -output
  - id: seqmers
    type:
      - 'null'
      - Directory
    doc: "Optional input for a pre-built sequence meryl database (by default <seq.fasta>.meryl is generated)"
    inputBinding:
      position: 102
      prefix: -seqmers
  - id: comb
    type:
      - 'null'
      - int
    doc: "Set the max N of combinations of variants to be evaluated (default: 15)"
    inputBinding:
      position: 102
      prefix: -comb
  - id: nosplit
    type:
      - 'null'
      - boolean
    doc: "Without this option combinations larger than N are split"
    inputBinding:
      position: 102
      prefix: -nosplit
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "Output a debug log, into <output>.THREAD_ID.debug.gz"
    inputBinding:
      position: 102
      prefix: -debug
  - id: peak
    type:
      - 'null'
      - float
    doc: "Haploid peak: hard sets copy 1 and infers multiplicity to copy number (recommended)"
    inputBinding:
      position: 102
      prefix: -peak
  - id: prob
    type:
      - 'null'
      - File
    doc: "Optional input vector of probabilities; adjusts multiplicity to copy number (takes priority over -peak for the multiplicities listed)"
    inputBinding:
      position: 102
      prefix: -prob
  - id: min_kmer_value
    type:
      - 'null'
      - int
    doc: "Ignore kmers with value below m"
    inputBinding:
      position: 102
      prefix: -min
  - id: max_kmer_value
    type:
      - 'null'
      - int
    doc: "Ignore kmers with value above m"
    inputBinding:
      position: 102
      prefix: -max
  - id: threads
    type:
      - 'null'
      - int
    doc: "Multithreading for meryl lookup table construction, dump and hist"
    inputBinding:
      position: 102
      prefix: -threads
  - id: memory
    type:
      - 'null'
      - float
    doc: "Do not use more than m GB memory for loading mers"
    inputBinding:
      position: 102
      prefix: -memory
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr_log
    type: stderr
    doc: Standard error (progress, QV or completeness report)
  - id: result
    type:
      - 'null'
      - File
    doc: "Variants chosen (VCF)"
    outputBinding:
      glob: $(inputs.output).filter.vcf
  - id: debug_logs
    type:
      - 'null'
      - type: array
        items: File
    doc: Debug logs written with -debug
    outputBinding:
      glob: $(inputs.output).*.debug.gz
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.sequence)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merfin:1.0--h9948957_3
stdout: merfin_filter.out
stderr: merfin_filter.err
