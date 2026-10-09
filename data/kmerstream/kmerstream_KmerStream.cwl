cwlVersion: v1.2
class: CommandLineTool
baseCommand: KmerStream
label: kmerstream_KmerStream
doc: "Estimates occurrences of k-mers in fastq or fasta files and saves results\n\nTool homepage: https://github.com/pmelsted/KmerStream"
inputs:
  - id: kmer_size
    type: ['null', string]
    doc: "Size of k-mers, either a single value or comma separated list"
    inputBinding:
      position: 1
      prefix: "--kmer-size"
  - id: quality_cutoff
    type: ['null', string]
    doc: "Comma separated list, keep k-mers with bases above quality threshold in PHRED (default 0)"
    inputBinding:
      position: 1
      prefix: "--quality-cutoff"
  - id: output_file_path
    type: ['null', string]
    default: "out.txt"
    doc: "Filename for output (with --binary the sketches are written to _Q_<q>_k_<k> files in the working directory instead)"
    inputBinding:
      position: 1
      prefix: "--output"
  - id: error_rate
    type: ['null', float]
    doc: "Error rate guaranteed (default value 0.01)"
    inputBinding:
      position: 1
      prefix: "--error-rate"
  - id: threads
    type: ['null', int]
    doc: "Number of threads to use (default value 1)"
    inputBinding:
      position: 1
      prefix: "--threads"
  - id: seed
    type: ['null', int]
    doc: "Seed value for the randomness (default value 0, use time based randomness)"
    inputBinding:
      position: 1
      prefix: "--seed"
  - id: input_bam
    type: ['null', boolean]
    doc: "Input is in BAM format (default false)"
    inputBinding:
      position: 1
      prefix: "--bam"
  - id: output_binary
    type: ['null', boolean]
    doc: "Output is written in binary format (default false)"
    inputBinding:
      position: 1
      prefix: "--binary"
  - id: output_tsv
    type: ['null', boolean]
    doc: "Output is written in TSV format (default false)"
    inputBinding:
      position: 1
      prefix: "--tsv"
  - id: verbose
    type: ['null', boolean]
    doc: "Print lots of messages during run"
    inputBinding:
      position: 1
      prefix: "--verbose"
  - id: online
    type: ['null', boolean]
    doc: "Prints out estimates every 100K reads"
    inputBinding:
      position: 1
      prefix: "--online"
  - id: phred64
    type: ['null', boolean]
    doc: "Set if PHRED+64 scores are used (@...h), default used PHRED+33"
    inputBinding:
      position: 1
      prefix: "--q64"
  - id: fastq_files
    type:
      type: array
      items: File
    doc: "FASTQ (or FASTA, or BAM with --bam) input files"
    inputBinding:
      position: 50
outputs:
  - id: output_file
    type: ['null', File]
    doc: "Estimates written with --output"
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: binary_sketches
    type:
      type: array
      items: File
    doc: "Binary sketches written with --binary"
    outputBinding:
      glob: "_Q_*_k_*"
  - id: stdout
    type: stdout
    doc: "Standard output"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmerstream:1.1--h077b44d_6
stdout: kmerstream.out
