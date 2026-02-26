cwlVersion: v1.2
class: CommandLineTool
baseCommand: htsinfer
label: htsinfer
doc: "Command-line interface client for inferring metadata from High-Throughput Sequencing
  (HTS) data.\n\nTool homepage: https://github.com/zavolanlab/htsinfer"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: either one or two paths to FASTQ files representing the sequencing 
      library to be evaluated, for single- or paired-ended libraries, 
      respectively
    inputBinding:
      position: 1
  - id: cleanup_regime
    type:
      - 'null'
      - string
    doc: determine which data to keep after each run; in default mode, both 
      temporary data and results are kept when '--verbosity' is set to 'DEBUG', 
      no data is kept when all metadata could be successfully determined, and 
      only results are kept otherwise
    default: DEFAULT
    inputBinding:
      position: 102
      prefix: --cleanup-regime
  - id: library_source_min_frequency_ratio
    type:
      - 'null'
      - float
    doc: minimum frequency ratio between the first and second most frequent 
      source in order for the former to be considered the library's source
    default: 2.0
    inputBinding:
      position: 102
      prefix: --library-source-min-frequency-ratio
  - id: library_source_min_match_percentage
    type:
      - 'null'
      - float
    doc: minimum percentage of reads that are consistent with a given source in 
      order for it to be considered the library's source
    default: 5.0
    inputBinding:
      position: 102
      prefix: --library-source-min-match-percentage
  - id: library_type_mates_cutoff
    type:
      - 'null'
      - float
    doc: minimum fraction of mates that can be mapped to compatible loci and are
      considered concordant pairs / all mates
    default: 0.85
    inputBinding:
      position: 102
      prefix: --library-type-mates-cutoff
  - id: library_type_max_distance
    type:
      - 'null'
      - int
    doc: upper limit on the difference in the reference sequence coordinates 
      between the two mates to be considered as coming from a single fragment
    default: 1000
    inputBinding:
      position: 102
      prefix: --library-type-max-distance
  - id: read_layout_adapters
    type:
      - 'null'
      - File
    doc: path to text file containing 3' adapter sequences to scan for (one 
      sequence per line)
    default: /usr/local/lib/python3.10/site-packages/data/adapter_fragments.txt
    inputBinding:
      position: 102
      prefix: --read-layout-adapters
  - id: read_layout_min_frequency_ratio
    type:
      - 'null'
      - float
    doc: minimum frequency ratio between the first and second most frequent 
      adapter in order for the former to be considered as the library's 3'-end 
      adapter
    default: 2.0
    inputBinding:
      position: 102
      prefix: --read-layout-min_frequency_ratio
  - id: read_layout_min_match_percentage
    type:
      - 'null'
      - float
    doc: minimum percentage of reads that contain a given adapter sequence in 
      order for it to be considered as the library's 3'-end adapter
    default: 0.1
    inputBinding:
      position: 102
      prefix: --read-layout-min-match-percentage
  - id: read_orientation_min_fraction
    type:
      - 'null'
      - float
    doc: minimum fraction of mapped reads required to be consistent with a given
      read orientation state in order for that orientation to be reported. Must 
      be above 0.5
    default: 0.75
    inputBinding:
      position: 102
      prefix: --read-orientation-min-fraction
  - id: read_orientation_min_mapped_reads
    type:
      - 'null'
      - int
    doc: minimum number of mapped reads for deeming the read orientation result 
      reliable
    default: 20
    inputBinding:
      position: 102
      prefix: --read-orientation-min-mapped-reads
  - id: records
    type:
      - 'null'
      - int
    doc: number of records to process; if set to ``0`` or if the specified value
      equals or exceeds the number of available records, all records will be 
      processed
    default: 1000000
    inputBinding:
      position: 102
      prefix: --records
  - id: tax_id
    type:
      - 'null'
      - int
    doc: NCBI taxonomic identifier of source organism of the library; if 
      provided, will not be inferred by the application
    inputBinding:
      position: 102
      prefix: --tax-id
  - id: temporary_directory
    type:
      - 'null'
      - Directory
    doc: path to directory where temporary output is written to
    default: /tmp/tmp_htsinfer
    inputBinding:
      position: 102
      prefix: --temporary-directory
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to run STAR with
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: transcripts
    type:
      - 'null'
      - File
    doc: FASTA file containing transcripts to be used for mapping files 
      `--file-1` and `--file-2` for inferring library source and read 
      orientation.
    default: /usr/local/lib/python3.10/site-packages/data/transcripts.fasta.gz
    inputBinding:
      position: 102
      prefix: --transcripts
  - id: verbosity
    type:
      - 'null'
      - string
    doc: logging verbosity level
    default: INFO
    inputBinding:
      position: 102
      prefix: --verbosity
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: path to directory where output is written to
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/htsinfer:1.0.0_rc.1--pyhdfd78af_0
