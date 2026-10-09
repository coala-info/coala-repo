cwlVersion: v1.2
class: CommandLineTool
baseCommand: lighter
label: lighter
doc: "Lighter: fast and memory-efficient sequencing error correction without counting.
  Use kmer_length, genome_size and alpha for -k, or kmer_length and genome_size
  with use_exact_genome_size for -K.\n\nTool homepage: https://github.com/mourisl/Lighter"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        if (inputs.output_directory) {
          return [{class: 'Directory', basename: inputs.output_directory, listing: []}];
        }
        return [];
      }
arguments:
  - position: 2
    valueFrom: |
      ${
        if (inputs.use_exact_genome_size) {
          return ['-K', String(inputs.kmer_length), String(inputs.genome_size)];
        }
        return ['-k', String(inputs.kmer_length), String(inputs.genome_size), String(inputs.alpha)];
      }
inputs:
  - id: seq_files
    type:
      type: array
      items: File
      inputBinding:
        prefix: -r
    doc: "Sequence files (fasta or fastq, optionally gzip'ed with extension .gz). Each
      file gets its own -r. The corrected file is written as <name>.cor.<ext>."
    inputBinding:
      position: 1
  - id: kmer_length
    type: int
    doc: k-mer length (-k or -K).
  - id: genome_size
    type: long
    doc: Genome size. With -K it should be relatively accurate.
  - id: alpha
    type:
      - 'null'
      - float
    doc: Sampling rate alpha for -k (see the README; about 7 divided by the coverage).
      Required unless use_exact_genome_size is set.
  - id: use_exact_genome_size
    type:
      - 'null'
      - boolean
    doc: Use -K kmer_length genome_size instead of -k kmer_length genome_size alpha.
  - id: output_directory
    type:
      - 'null'
      - string
    doc: Output file directory (default is the current directory).
    inputBinding:
      position: 101
      prefix: -od
  - id: num_of_threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    inputBinding:
      position: 101
      prefix: -t
  - id: max_corrections_window
    type:
      - 'null'
      - int
    doc: the maximum number of corrections within a 20bp window
    inputBinding:
      position: 101
      prefix: -maxcor
  - id: allow_trimming
    type:
      - 'null'
      - boolean
    doc: allow trimming
    inputBinding:
      position: 101
      prefix: -trim
  - id: discard_unfixable
    type:
      - 'null'
      - boolean
    doc: discard unfixable reads. Will LOSE paired-end matching when discarding
    inputBinding:
      position: 101
      prefix: -discard
  - id: ignore_quality_score
    type:
      - 'null'
      - boolean
    doc: ignore the quality score
    inputBinding:
      position: 101
      prefix: -noQual
  - id: new_quality_score
    type:
      - 'null'
      - string
    doc: set the quality for the bases corrected to the specified ascii score
    inputBinding:
      position: 101
      prefix: -newQual
  - id: save_trusted_kmers_file
    type:
      - 'null'
      - string
    doc: save the trusted kmers to the specified file then stop
    inputBinding:
      position: 101
      prefix: -saveTrustedKmers
  - id: load_trusted_kmers_file
    type:
      - 'null'
      - File
    doc: directly get solid kmers from the specified file
    inputBinding:
      position: 101
      prefix: -loadTrustedKmers
  - id: zlib_compress_level
    type:
      - 'null'
      - int
    doc: set the compression level (0-9) of gzip
    inputBinding:
      position: 101
      prefix: -zlib
outputs:
  - id: corrected_reads
    type:
      type: array
      items: File
    doc: Corrected reads (<name>.cor.<ext>).
    outputBinding:
      glob: "$((inputs.output_directory ? inputs.output_directory + '/' : '') + '*.cor.*')"
  - id: trusted_kmers
    type:
      - 'null'
      - File
    doc: Trusted k-mers file, written with save_trusted_kmers_file.
    outputBinding:
      glob: $(inputs.save_trusted_kmers_file)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lighter:1.1.3--h077b44d_2
stdout: lighter.out
