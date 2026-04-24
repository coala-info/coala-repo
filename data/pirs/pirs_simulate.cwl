cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pirs
  - simulate
label: pirs_simulate
doc: "pIRS is a program for simulating paired-end reads from a genome. It is optimized
  for simulating reads from the Illumina platform. The input to pIRS is any number
  of reference sequences. Typically you would just provide one FASTA file containing
  your reference sequence, but you may provide two if you have generated a diploid
  sequence with `pirs diploid', or if you have chromosomes split up into multiple
  FASTA files. The output of pIRS is two FASTQ files containing the simulated paired-end
  reads, as well as several log files.\n\nTool homepage: https://github.com/galaxy001/pirs"
inputs:
  - id: reference_fasta
    type:
      type: array
      items: File
    doc: Reference FASTA file(s)
    inputBinding:
      position: 1
  - id: base_calling_profile
    type:
      - 'null'
      - File
    doc: Use FILE as the base-calling profile. This profile will be used to 
      simulate substitution errors.
    inputBinding:
      position: 102
      prefix: --base-calling-profile
  - id: compress
    type:
      - 'null'
      - boolean
    doc: Equivalent to -c gzip.
    inputBinding:
      position: 102
      prefix: -z
  - id: coverage
    type:
      - 'null'
      - float
    doc: Set the average sequencing coverage (sometimes called depth). It may be
      either a floating-point number or an integer.
    inputBinding:
      position: 102
      prefix: --coverage
  - id: cyclicize
    type:
      - 'null'
      - boolean
    doc: 'Make the paired-end reads face away from either other, as in a jumping library.
      Default: the reads face towards each other.'
    inputBinding:
      position: 102
      prefix: --cyclicize
  - id: diploid
    type:
      - 'null'
      - boolean
    doc: This option asserts that reads are being simulated from a diploid 
      genome. It causes the program to abort if there are not exactly two 
      reference sequences; in addition, the coverage is divided in half, since 
      the two reference sequences are in reality the same genome. This option is
      not required to simulate diploid reads, but you must set the coverage 
      correctly otherwise (it will be half as much as you think).
    inputBinding:
      position: 102
      prefix: --diploid
  - id: eamss
    type:
      - 'null'
      - string
    doc: Use the EAMSS algorithm for masking read quality. MODE may be the 
      string "quality" or "lowercase".
    inputBinding:
      position: 102
      prefix: --eamss
  - id: error_rate
    type:
      - 'null'
      - float
    doc: Set the substitution error rate. The base-calling profile will still be
      used, but the average frequency of errors will be changed to RATE. Set to 
      0 to disable substitution errors completely. In that case, the 
      base-calling profile will not be used.
    inputBinding:
      position: 102
      prefix: --error-rate
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: Do not simulate quality values. The simulated reads will be written as 
      a FASTA file rather than a FASTQ file.
    inputBinding:
      position: 102
      prefix: --fasta
  - id: gc_bias_profile
    type:
      - 'null'
      - File
    doc: Use FILE as the GC content bias profile. This profile will adjust the 
      read coverage based on the GC content of fragments.
    inputBinding:
      position: 102
      prefix: --gc-bias-profile
  - id: gc_content_bias_profile
    type:
      - 'null'
      - File
    doc: Use FILE as the GC content bias profile. This profile will adjust the 
      read coverage based on the GC content of fragments.
    inputBinding:
      position: 102
      prefix: --gc-content-bias-profile
  - id: indel_error_profile
    type:
      - 'null'
      - File
    doc: Use FILE as the indel-error profile. This profile will be used to 
      simulate insertions and deletions in the reads that are artifacts of the 
      sequencing process.
    inputBinding:
      position: 102
      prefix: --indel-error-profile
  - id: indel_profile
    type:
      - 'null'
      - File
    doc: Use FILE as the indel-error profile. This profile will be used to 
      simulate insertions and deletions in the reads that are artifacts of the 
      sequencing process.
    inputBinding:
      position: 102
      prefix: --indel-profile
  - id: insert_len_mean
    type:
      - 'null'
      - int
    doc: Generate inserts (fragments) having an average length of LEN.
    inputBinding:
      position: 102
      prefix: --insert-len-mean
  - id: insert_len_sd
    type:
      - 'null'
      - string
    doc: Set the standard deviation of the insert (fragment) length.
    inputBinding:
      position: 102
      prefix: --insert-len-sd
  - id: jumping
    type:
      - 'null'
      - boolean
    doc: 'Make the paired-end reads face away from either other, as in a jumping library.
      Default: the reads face towards each other.'
    inputBinding:
      position: 102
      prefix: --jumping
  - id: mask
    type:
      - 'null'
      - string
    doc: Use the EAMSS algorithm for masking read quality. MODE may be the 
      string "quality" or "lowercase".
    inputBinding:
      position: 102
      prefix: --mask
  - id: no_gc_bias
    type:
      - 'null'
      - boolean
    doc: Do not simulate GC bias. The GC bias profile will not be used.
    inputBinding:
      position: 102
      prefix: --no-gc-bias
  - id: no_gc_content_bias
    type:
      - 'null'
      - boolean
    doc: Do not simulate GC bias. The GC bias profile will not be used.
    inputBinding:
      position: 102
      prefix: --no-gc-content-bias
  - id: no_indel_errors
    type:
      - 'null'
      - boolean
    doc: Do not simulate indels. The indel error profile will not be used.
    inputBinding:
      position: 102
      prefix: --no-indel-errors
  - id: no_indels
    type:
      - 'null'
      - boolean
    doc: Do not simulate indels. The indel error profile will not be used.
    inputBinding:
      position: 102
      prefix: --no-indels
  - id: no_log_files
    type:
      - 'null'
      - boolean
    doc: Do not write the log files.
    inputBinding:
      position: 102
      prefix: --no-log-files
  - id: no_logs
    type:
      - 'null'
      - boolean
    doc: Do not write the log files.
    inputBinding:
      position: 102
      prefix: --no-logs
  - id: no_quality_values
    type:
      - 'null'
      - boolean
    doc: Do not simulate quality values. The simulated reads will be written as 
      a FASTA file rather than a FASTQ file.
    inputBinding:
      position: 102
      prefix: --no-quality-values
  - id: no_substitution_errors
    type:
      - 'null'
      - boolean
    doc: Do not simulate substitution errors. Equivalent to --error-rate=0.
    inputBinding:
      position: 102
      prefix: --no-subst-errors
  - id: no_substitution_errors_alias
    type:
      - 'null'
      - boolean
    doc: Do not simulate substitution errors. Equivalent to --error-rate=0.
    inputBinding:
      position: 102
      prefix: --no-substitution-errors
  - id: output_file_type
    type:
      - 'null'
      - string
    doc: The string "text" or "gzip" to specify the type of the output FASTQ 
      files containing the simulated reads of the genome, as well as the log 
      files.
    inputBinding:
      position: 102
      prefix: --output-file-type
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Use PREFIX as the prefix of the output files.
    inputBinding:
      position: 102
      prefix: --output-prefix
  - id: phred_offset
    type:
      - 'null'
      - int
    doc: Set the ASCII shift of the quality value (usually 64 or 33 for Illumina
      data).
    inputBinding:
      position: 102
      prefix: --phred-offset
  - id: quality_shift
    type:
      - 'null'
      - int
    doc: Set the ASCII shift of the quality value (usually 64 or 33 for Illumina
      data).
    inputBinding:
      position: 102
      prefix: --quality-shift
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not print informational messages.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: random_seed
    type:
      - 'null'
      - int
    doc: 'Use SEED as the random seed. Default: time(NULL) * getpid().'
    inputBinding:
      position: 102
      prefix: --random-seed
  - id: read_len
    type:
      - 'null'
      - int
    doc: Generate reads having a length of LEN.
    inputBinding:
      position: 102
      prefix: --read-len
  - id: subst_error_algo
    type:
      - 'null'
      - string
    doc: Set the algorithm used for simulating substitition errors. It may be 
      set to the string "dist" or "qtrans". The default is "qtrans".
    inputBinding:
      position: 102
      prefix: --subst-error-algo
  - id: subst_error_profile
    type:
      - 'null'
      - File
    doc: Use FILE as the base-calling profile. This profile will be used to 
      simulate substitution errors.
    inputBinding:
      position: 102
      prefix: --subst-error-profile
  - id: subst_error_rate
    type:
      - 'null'
      - float
    doc: Set the substitution error rate. The base-calling profile will still be
      used, but the average frequency of errors will be changed to RATE. Set to 
      0 to disable substitution errors completely. In that case, the 
      base-calling profile will not be used.
    inputBinding:
      position: 102
      prefix: --subst-error-rate
  - id: substitution_error_algorithm
    type:
      - 'null'
      - string
    doc: Set the algorithm used for simulating substitition errors. It may be 
      set to the string "dist" or "qtrans". The default is "qtrans".
    inputBinding:
      position: 102
      prefix: --substitution-error-algorithm
  - id: threads
    type:
      - 'null'
      - int
    doc: Use NUM_THREADS threads to simulate reads. This option is not available
      if pIRS was compiled with the --disable-threads option.
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pirs:2.0.2--pl5.22.0_1
stdout: pirs_simulate.out
