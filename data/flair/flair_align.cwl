cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - flair
  - align
label: flair_align
doc: "FLAIR align outputs an unfiltered bam file and a filtered bed file for use in
  the downstream pipeline\n\nTool homepage: https://github.com/BrooksLabUCSC/flair"
inputs:
  - id: filtertype
    type:
      - 'null'
      - string
    doc: 'method of filtering chimeric alignments (potential fusion reads). Options:
      removesup (default), separate (required for downstream work with fusions), keepsup
      (keeps supplementary alignments for isoform detection, does not allow gene fusion
      detection)'
    default: removesup
    inputBinding:
      position: 101
      prefix: --filtertype
  - id: genome
    type:
      - 'null'
      - File
    doc: FASTA of reference genome, can be minimap2 indexed
    inputBinding:
      position: 101
      prefix: --genome
  - id: gtf
    type:
      - 'null'
      - File
    doc: reference annotation, only used if --remove_internal_priming is specified,
      recommended if so
    inputBinding:
      position: 101
      prefix: --gtf
  - id: intprimingfrac_as
    type:
      - 'null'
      - int
    doc: number of bases that are at least 75% As required to call read as internal
      priming
    inputBinding:
      position: 101
      prefix: --intprimingfracAs
  - id: intprimingthreshold
    type:
      - 'null'
      - int
    doc: number of bases that are at leas 75% As required to call read as internal
      priming
    inputBinding:
      position: 101
      prefix: --intprimingthreshold
  - id: junction_bed
    type:
      - 'null'
      - File
    doc: annotated isoforms/junctions bed file for splice site-guided minimap2 genomic
      alignment
    inputBinding:
      position: 101
      prefix: --junction_bed
  - id: log_conf
    type:
      - 'null'
      - File
    doc: Python logging configuration file, see logging.config.fileConfig()
    inputBinding:
      position: 101
      prefix: --log-conf
  - id: log_debug
    type:
      - 'null'
      - boolean
    doc: short-cut that that sets --log-stderr and --log-level=DEBUG
    inputBinding:
      position: 101
      prefix: --log-debug
  - id: log_level
    type:
      - 'null'
      - string
    doc: Set level to case-insensitive symbolic value, one of CRITICAL, DEBUG, ERROR,
      FATAL, INFO, NOTSET, WARN, WARNING
    inputBinding:
      position: 101
      prefix: --log-level
  - id: log_stderr
    type:
      - 'null'
      - boolean
    doc: also log to stderr, even when logging to syslog
    inputBinding:
      position: 101
      prefix: --log-stderr
  - id: maxintronlen
    type:
      - 'null'
      - int
    doc: maximum intron length in genomic alignment. Longer can help recover more
      novel isoforms with long introns
    inputBinding:
      position: 101
      prefix: --maxintronlen
  - id: minfragmentsize
    type:
      - 'null'
      - int
    doc: minimum size of alignment kept, used in minimap -s. More important when doing
      downstream fusion detection
    inputBinding:
      position: 101
      prefix: --minfragmentsize
  - id: mm_index
    type:
      - 'null'
      - File
    doc: minimap2 index .mmi file
    inputBinding:
      position: 101
      prefix: --mm_index
  - id: nvrna
    type:
      - 'null'
      - boolean
    doc: specify this flag to use native-RNA specific alignment parameters for minimap2
    inputBinding:
      position: 101
      prefix: --nvrna
  - id: quality
    type:
      - 'null'
      - int
    doc: minimum MAPQ of read alignment to the genome
    default: 0
    inputBinding:
      position: 101
      prefix: --quality
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress minimap progress statements from being printed
    inputBinding:
      position: 101
      prefix: --quiet
  - id: reads
    type:
      type: array
      items: File
    doc: FASTA/FASTQ file(s) of raw reads, either space or comma separated
    inputBinding:
      position: 101
      prefix: --reads
  - id: remove_internal_priming
    type:
      - 'null'
      - boolean
    doc: specify if want to remove reads with internal priming
    inputBinding:
      position: 101
      prefix: --remove_internal_priming
  - id: remove_singleexon
    type:
      - 'null'
      - boolean
    doc: specify if want to remove unspliced reads
    inputBinding:
      position: 101
      prefix: --remove_singleexon
  - id: threads
    type:
      - 'null'
      - int
    doc: minimap2 number of threads
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output file name base
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flair:3.0.0--pyhdfd78af_0
