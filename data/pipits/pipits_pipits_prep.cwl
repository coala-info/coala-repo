cwlVersion: v1.2
class: CommandLineTool
baseCommand: pipits_prep
label: pipits_pipits_prep
doc: "Reindex, join (VSEARCH), quality filter, convert and merge Illumina FASTQ data.\n\
  \nTool homepage: https://github.com/hsgweon/pipits"
inputs:
  - id: base_quality_encoding
    type:
      - 'null'
      - int
    doc: Base PHRED quality score encoding of input FASTQ files (e.g., 33 or 64)
    default: 33
    inputBinding:
      position: 101
      prefix: -b
  - id: fastx_quality_filter_min_percent
    type:
      - 'null'
      - int
    doc: "FASTX quality filter: Minimum percent of bases that must have '--FASTX-q'
      quality"
    default: 80
    inputBinding:
      position: 101
      prefix: --FASTX-p
  - id: fastx_quality_filter_min_quality
    type:
      - 'null'
      - int
    doc: 'FASTX quality filter: Minimum quality score to keep'
    default: 30
    inputBinding:
      position: 101
      prefix: --FASTX-q
  - id: input_dir
    type: Directory
    doc: Directory containing raw sequence files (FASTQ format, can be .gz or 
      .bz2 compressed).
    inputBinding:
      position: 101
      prefix: -i
  - id: keep_ns
    type:
      - 'null'
      - boolean
    doc: Keep sequences containing 'N' nucleotides during FASTQ to FASTA 
      conversion
    default: false
    inputBinding:
      position: 101
      prefix: --keep-Ns
  - id: list_file
    type: File
    doc: 'Tab-separated file with three columns: SampleID, ForwardReadFilename, ReverseReadFilename.
      Only files listed here will be processed.'
    inputBinding:
      position: 101
      prefix: -l
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory to output results
    default: pipits_prep_output
    inputBinding:
      position: 101
      prefix: -o
  - id: retain_intermediate_files
    type:
      - 'null'
      - boolean
    doc: Retain intermediate files in the 'tmp' subdirectory.
    inputBinding:
      position: 101
      prefix: --retain
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads for VSEARCH joining
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode (log debug messages to console and file).
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pipits:4.0--pyhdfd78af_0
stdout: pipits_pipits_prep.out
