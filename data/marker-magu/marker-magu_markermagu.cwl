cwlVersion: v1.2
class: CommandLineTool
baseCommand: markermagu
label: marker-magu_markermagu
doc: "Marker-MAGu is a read mapping pipeline which uses marker genes to detect and
  measure bacteria, phages, archaea, and microeukaryotes.\n\nTool homepage: https://github.com/cmmr/Marker-MAGu"
inputs:
  - id: cpu
    type:
      - 'null'
      - int
    doc: Number of CPUs available for Marker-MAGu.
    default: 20
    inputBinding:
      position: 101
      prefix: --cpu
  - id: db
    type:
      - 'null'
      - Directory
    doc: DB path. If not set, Marker-MAGu looks for environmental variable 
      MARKERMAGU_DB. Then, if this variable is unset, it this is unset, DB path 
      is assumed to be /usr/local/lib/python3.10/site-packages/markermagu
    inputBinding:
      position: 101
      prefix: --db
  - id: detection
    type:
      - 'null'
      - string
    doc: Stringency of SGB detection. "default" setting requires >=75 percent of
      marker genes with at least 1 read mapped. "relaxed" setting requires >= 
      33.3 percent of marker genes with at least 1 read mapped AND at least 3 
      marker genes detected.
    default: default
    inputBinding:
      position: 101
      prefix: --detection
  - id: filter_dir
    type:
      - 'null'
      - Directory
    doc: path to directory of sequences to filter. If not set, Marker-MAGu looks
      for environmental variable MARKERMAGU_FILTER. Then, if this variable is 
      unset, it this is unset, DB path is assumed to be 
      /usr/local/lib/python3.10/site-packages/markermagu
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
    doc: True of False. Keep the intermediate files, located in the temporary 
      directory? These can add up, so it is not recommended if space is a 
      concern.
    inputBinding:
      position: 101
      prefix: --keep
  - id: qual
    type:
      - 'null'
      - boolean
    doc: True or False. Remove low-quality reads with fastp?
    inputBinding:
      position: 101
      prefix: --qual
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
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: path of temporary directory.
    default: '{OUTPUT_DIR}/{SAMPLE}_temp/'
    inputBinding:
      position: 101
      prefix: --temp
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory name. Will be created if it does not exist. Can be 
      shared with other samples. No space characters, please.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/marker-magu:0.4.0--pyhdfd78af_1
