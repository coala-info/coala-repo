cwlVersion: v1.2
class: CommandLineTool
baseCommand: htseqqc_filter.py
label: htseqqc_filter.py
doc: "Quality control analysis of single and paired-end sequence data\n\nTool homepage:
  https://reneshbedre.github.io/blog/htseqqc.html"
inputs:
  - id: adpt_match
    type:
      - 'null'
      - float
    doc: Truncate the read sequence if it matches to adapter sequence equal or 
      more than given percent (0.0-1.0)
    default: 0.9
    inputBinding:
      position: 101
      prefix: --per
  - id: adpt_seqs
    type:
      - 'null'
      - type: array
        items: string
    doc: Trim the adapter and truncate the read sequence (multiple adapter 
      sequences must be separated by comma)
    inputBinding:
      position: 101
      prefix: --adp
  - id: cpu
    type:
      - 'null'
      - int
    doc: Number of CPU
    default: 2
    inputBinding:
      position: 101
      prefix: --cpu
  - id: input_files_1
    type:
      - 'null'
      - type: array
        items: File
    doc: Single end input files or left files for paired-end data (.fastq, .fq).
      Multiple sample files must be separated by comma or space
    inputBinding:
      position: 101
      prefix: --p1
  - id: input_files_2
    type:
      - 'null'
      - type: array
        items: File
    doc: Right files for paired-end data (.fastq, .fq). Multiple files must be 
      separated by comma or space
    inputBinding:
      position: 101
      prefix: --p2
  - id: min_len_filt
    type:
      - 'null'
      - int
    doc: Minimum length of the reads to retain after trimming
    inputBinding:
      position: 101
      prefix: --mlk
  - id: min_size
    type:
      - 'null'
      - int
    doc: Filter the reads which are lesser than minimum size
    inputBinding:
      position: 101
      prefix: --msz
  - id: n_cont
    type:
      - 'null'
      - float
    doc: Filter the reads containing given % of uncalled bases (N)
    inputBinding:
      position: 101
      prefix: --nb
  - id: out_fmt
    type:
      - 'null'
      - string
    doc: Output file format (fastq/fasta)
    default: fastq
    inputBinding:
      position: 101
      prefix: --ofmt
  - id: qual_fmt
    type:
      - 'null'
      - int
    doc: Quality value format [1= Illumina 1.8, 2= Illumina 1.3, 3= Sanger]. If 
      quality format not provided, it will automatically detect based on 
      sequence data
    inputBinding:
      position: 101
      prefix: --qfmt
  - id: qual_thresh
    type:
      - 'null'
      - int
    doc: Filter the read sequence if average quality of bases in reads is lower 
      than threshold (1-40)
    default: 20
    inputBinding:
      position: 101
      prefix: --qthr
  - id: trim_opt
    type:
      - 'null'
      - boolean
    doc: If trim option set to True, the reads with low quality (as defined by 
      option --qthr) will be trimmed instead of discarding [True|False]
    default: false
    inputBinding:
      position: 101
      prefix: --trim
  - id: vis_opt
    type:
      - 'null'
      - boolean
    doc: No figures will be produced [True|False]
    default: false
    inputBinding:
      position: 101
      prefix: --no-vis
  - id: wind_size
    type:
      - 'null'
      - int
    doc: The window size for trimming (5->3) the reads. This option should 
      always set when -trim option is defined
    default: 5
    inputBinding:
      position: 101
      prefix: --wsz
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/htseqqc:v1.0--pyh5bfb8f1_0
stdout: htseqqc_filter.py.out
