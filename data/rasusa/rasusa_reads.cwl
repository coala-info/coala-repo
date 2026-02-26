cwlVersion: v1.2
class: CommandLineTool
baseCommand: rasusa_reads
label: rasusa_reads
doc: "Randomly subsample reads\n\nTool homepage: https://github.com/mbhall88/rasusa"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: "The fast{a,q} file(s) to subsample.\n          \n          For paired Illumina,
      the order matters. i.e., R1 then R2."
    inputBinding:
      position: 1
  - id: bases
    type:
      - 'null'
      - string
    doc: "Explicitly set the number of bases required e.g., 4.3kb, 7Tb, 9000, 4.1MB\n\
      \          \n          If this option is given, --coverage and --genome-size
      are ignored"
    inputBinding:
      position: 102
      prefix: --bases
  - id: compress_level
    type:
      - 'null'
      - int
    doc: Compression level to use if compressing output. Uses the default level 
      for the format if not specified
    inputBinding:
      position: 102
      prefix: --compress-level
  - id: coverage
    type:
      - 'null'
      - float
    doc: "The desired depth of coverage to subsample the reads to\n          \n  \
      \        If --bases is not provided, this option and --genome-size are required"
    inputBinding:
      position: 102
      prefix: --coverage
  - id: fraction
    type:
      - 'null'
      - float
    doc: "Subsample to a fraction of the reads - e.g., 0.5 samples half the reads\n\
      \          \n          Values >1 and <=100 will be automatically converted -
      e.g., 25 => 0.25"
    inputBinding:
      position: 102
      prefix: --frac
  - id: genome_size
    type:
      - 'null'
      - string
    doc: "Genome size to calculate coverage with respect to. e.g., 4.3kb, 7Tb, 9000,
      4.1MB\n          \n          Alternatively, a FASTA/Q index file can be provided
      and the genome size will be set to the sum of all reference sequences.\n   \
      \       \n          If --bases is not provided, this option and --coverage are
      required"
    inputBinding:
      position: 102
      prefix: --genome-size
  - id: num_reads
    type:
      - 'null'
      - int
    doc: "Subsample to a specific number of reads\n          \n          If paired-end
      reads are passed, this is the number of (matched) reads from EACH file. This
      option accepts the same format as genome size - e.g., 1k will take 1000 reads"
    inputBinding:
      position: 102
      prefix: --num
  - id: output_type
    type:
      - 'null'
      - string
    doc: "u: uncompressed; b: Bzip2; g: Gzip; l: Lzma; x: Xz (Lzma); z: Zstd\n   \
      \       \n          Rasusa will attempt to infer the output compression format
      automatically from the filename extension. This option is used to override that.
      If writing to stdout, the default is uncompressed"
    inputBinding:
      position: 102
      prefix: --output-type
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed to use
    inputBinding:
      position: 102
      prefix: --seed
  - id: strict
    type:
      - 'null'
      - boolean
    doc: Exit with an error if the requested coverage/bases/reads is not 
      possible
    inputBinding:
      position: 102
      prefix: --strict
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Switch on verbosity
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: output_filepaths
    type: File
    doc: "Output filepath(s); stdout if not present.\n          \n          For paired
      Illumina pass this flag twice `-o o1.fq -o o2.fq`\n          \n          NOTE:
      The order of the pairs is assumed to be the same as the input - e.g., R1 then
      R2.\n          \n          This option is required for paired input."
    outputBinding:
      glob: $(inputs.output_filepaths)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rasusa:3.0.0--h54198d6_0
