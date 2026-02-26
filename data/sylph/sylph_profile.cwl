cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sylph
  - profile
label: sylph_profile
doc: "Species-level taxonomic profiling with abundances and ANIs\n\nTool homepage:
  https://github.com/bluenote-1577/sylph"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: Pre-sketched *.syldb/*.sylsp files. Raw single-end fastq/fasta are 
      allowed and will be automatically sketched to .sylsp/.syldb
    inputBinding:
      position: 1
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug output
    inputBinding:
      position: 102
      prefix: --debug
  - id: estimate_read_counts
    type:
      - 'null'
      - boolean
    doc: Very roughly estimate read counts in the 'Sequence_abundance' column 
      instead of relative abundance. This forces `-u`, which may have caveats 
      for long reads and complex environments.
    inputBinding:
      position: 102
      prefix: --estimate-read-counts
  - id: estimate_unknown
    type:
      - 'null'
      - boolean
    doc: Estimate true coverage and scale sequence abundance in `profile` by 
      estimated unknown sequence percentage
    inputBinding:
      position: 102
      prefix: --estimate-unknown
  - id: file_list
    type:
      - 'null'
      - File
    doc: Newline delimited file of file inputs
    inputBinding:
      position: 102
      prefix: --list
  - id: first_pairs
    type:
      - 'null'
      - type: array
        items: File
    doc: First pairs for raw paired-end reads (fastx/gzip)
    inputBinding:
      position: 102
      prefix: --first-pairs
  - id: individual_records
    type:
      - 'null'
      - boolean
    doc: Use individual records (e.g. contigs) for database construction 
      instead. Does nothing for pre-sketched files
    inputBinding:
      position: 102
      prefix: --individual-records
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: Value of k. Only k = 21, 31 are currently supported. Does nothing for 
      pre-sketched files
    default: 31
    inputBinding:
      position: 102
      prefix: -k
  - id: log_reassignments
    type:
      - 'null'
      - boolean
    doc: 'Output information for how k-mers for genomes are reassigned during `profile`.
      Caution: can be verbose and slows down computation.'
    inputBinding:
      position: 102
      prefix: --log-reassignments
  - id: min_count_correct
    type:
      - 'null'
      - int
    doc: Minimum k-mer multiplicity needed for coverage correction. Higher 
      values gives more precision but lower sensitivity
    default: 3
    inputBinding:
      position: 102
      prefix: --min-count-correct
  - id: min_number_kmers
    type:
      - 'null'
      - int
    doc: Exclude genomes with less than this number of sampled k-mers
    default: 50
    inputBinding:
      position: 102
      prefix: --min-number-kmers
  - id: min_spacing_kmer
    type:
      - 'null'
      - int
    doc: Minimum spacing between selected k-mers on the database genomes. Does 
      nothing for pre-sketched files
    default: 30
    inputBinding:
      position: 102
      prefix: --min-spacing
  - id: minimum_ani
    type:
      - 'null'
      - float
    doc: Minimum adjusted ANI to consider (0-100). Default is 90 for query and 
      95 for profile. Smaller than 95 for profile will give inaccurate results.
    inputBinding:
      position: 102
      prefix: --minimum-ani
  - id: read_seq_id
    type:
      - 'null'
      - float
    doc: Sequence identity (%) of reads. Only used in -u option and overrides 
      automatic detection.
    inputBinding:
      position: 102
      prefix: --read-seq-id
  - id: reads
    type:
      - 'null'
      - type: array
        items: File
    doc: Single-end raw reads (fastx/gzip)
    inputBinding:
      position: 102
      prefix: --reads
  - id: sample_threads
    type:
      - 'null'
      - int
    doc: 'Number of samples to be processed concurrently. Default: (# of total threads
      / 3) + 1 for profile, 1 for query'
    inputBinding:
      position: 102
      prefix: --sample-threads
  - id: second_pairs
    type:
      - 'null'
      - type: array
        items: File
    doc: Second pairs for raw paired-end reads (fastx/gzip)
    inputBinding:
      position: 102
      prefix: --second-pairs
  - id: subsampling_rate
    type:
      - 'null'
      - int
    doc: Subsampling rate. Does nothing for pre-sketched files
    default: 200
    inputBinding:
      position: 102
      prefix: -c
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 3
    inputBinding:
      position: 102
      prefix: -t
  - id: trace
    type:
      - 'null'
      - boolean
    doc: 'Trace output (caution: very verbose)'
    inputBinding:
      position: 102
      prefix: --trace
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output to this file (TSV format).
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sylph:0.9.0--ha6fb395_0
