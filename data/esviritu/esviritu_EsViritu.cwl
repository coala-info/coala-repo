cwlVersion: v1.2
class: CommandLineTool
baseCommand: EsViritu
label: esviritu_EsViritu
doc: "EsViritu is a read mapping pipeline for detection and measurement of human,
  animal, and plat virus pathogens from short read libraries. It is useful for clinical
  and environmental samples. Version 1.1.6\n\nTool homepage: https://github.com/cmmr/EsViritu"
inputs:
  - id: cpu
    type:
      - 'null'
      - int
    doc: 'Example: 32 -- Number of CPUs available for EsViritu. Default = all available
      CPUs'
    inputBinding:
      position: 101
      prefix: --cpu
  - id: db
    type:
      - 'null'
      - Directory
    doc: path to sequence database. If not set, EsViritu looks for environmental
      variable ESVIRITU_DB. Then, if this variable is unset, it this is unset, 
      DB path is assumed to be /usr/local/lib/python3.13/site- packages/EsViritu
    inputBinding:
      position: 101
      prefix: --db
  - id: dedup
    type:
      - 'null'
      - boolean
    doc: True or False. Remove PCR duplicates during fastp preprocessing? This 
      can reduce processing time and provide more accurate abundance estimates.
    inputBinding:
      position: 101
      prefix: --dedup
  - id: filter_dir
    type:
      - 'null'
      - Directory
    doc: path to directory of sequences to filter. If not set, EsViritu looks 
      for environmental variable ESVIRITU_FILTER. Then, if this variable is 
      unset, it this is unset, DB path is assumed to be 
      /usr/local/lib/python3.13/site-packages/EsViritu
    inputBinding:
      position: 101
      prefix: --filter_dir
  - id: filter_seqs
    type:
      - 'null'
      - boolean
    doc: True or False. Remove reads aligning to sequences at 
      filter_seqs/filter_seqs.fna ?
    inputBinding:
      position: 101
      prefix: --filter_seqs
  - id: keep
    type:
      - 'null'
      - boolean
    doc: True of False. Keep the intermediate files located in the temporary 
      directory? These can add up, so it is not recommended if space is a 
      concern.
    inputBinding:
      position: 101
      prefix: --keep
  - id: minimap2_k
    type:
      - 'null'
      - string
    doc: 'Default: 500M -- minimap2 K parameter for Number of bases loaded into memory
      to process in a mini-batch. Reducing this value lowers memory consumption'
    default: 500M
    inputBinding:
      position: 101
      prefix: --minimap2-K
  - id: output_dir
    type: Directory
    doc: Output directory name (not a path). Will be created if it does not 
      exist. Can be shared with other samples. No space characters, please. See 
      also --working_directory to create at another path.
    inputBinding:
      position: 101
      prefix: --output_dir
  - id: qual
    type:
      - 'null'
      - boolean
    doc: True or False. Remove low-quality reads with fastp?
    inputBinding:
      position: 101
      prefix: --qual
  - id: read_format
    type:
      - 'null'
      - string
    doc: unpaired or paired. Format of input reads. If paired, must provide 2 
      files (R1, then R2) after -r argument.
    inputBinding:
      position: 101
      prefix: --read_format
  - id: reads
    type:
      type: array
      items: File
    doc: read file(s) in .fastq format. You can specify more than one separated 
      by a space
    inputBinding:
      position: 101
      prefix: --reads
  - id: sample
    type: string
    doc: Sample name. No space characters, please.
    inputBinding:
      position: 101
      prefix: --sample
  - id: species_threshold
    type:
      - 'null'
      - float
    doc: 'Default: 0.90 -- minimum ANI of reads to reference to classify record at
      species level. There is no perfect metric for this.'
    default: 0.9
    inputBinding:
      position: 101
      prefix: --species-threshold
  - id: subspecies_threshold
    type:
      - 'null'
      - float
    doc: 'Default: 0.95 -- minimum ANI of reads to reference to classify record at
      subspecies level. There is no perfect metric for this.'
    default: 0.95
    inputBinding:
      position: 101
      prefix: --subspecies-threshold
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: path of temporary directory. Default is {OUTPUT_DIR}/{SAMPLE}_temp/
    default: '{OUTPUT_DIR}/{SAMPLE}_temp/'
    inputBinding:
      position: 101
      prefix: --temp
  - id: working_directory
    type:
      - 'null'
      - Directory
    doc: 'Default: / -- Set working directory with absolute or relative path. Run
      directory will be created within.'
    default: /
    inputBinding:
      position: 101
      prefix: --working_directory
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esviritu:1.1.6--pyhdfd78af_0
stdout: esviritu_EsViritu.out
