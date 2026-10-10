cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mgatk-del
label: mgatk_mgatk-del
doc: "mgatk-del: quantify deletion heteroplasmy in mtDNA.\n\nTool homepage: https://github.com/caleblareau/mgatk"
inputs:
  - id: input
    type:
      - File
      - Directory
    doc: Input; either a directory of .bam files or a single .bam file
    inputBinding:
      position: 101
      prefix: --input
  - id: mito_chromosome
    type: string
    doc: Mitochondria chromosome name
    inputBinding:
      position: 101
      prefix: --mito-chromosome
  - id: name
    type:
      - 'null'
      - string
    doc: Prefix for project name
    inputBinding:
      position: 101
      prefix: --name
  - id: ncores
    type:
      - 'null'
      - int
    doc: Number of cores to run the main job in parallel.
    inputBinding:
      position: 101
      prefix: --ncores
  - id: cluster
    type:
      - 'null'
      - string
    doc: Message to send to Snakemake to execute jobs on cluster interface.
    inputBinding:
      position: 101
      prefix: --cluster
  - id: jobs
    type:
      - 'null'
      - int
    doc: Max number of jobs to be running concurrently on the cluster interface.
    inputBinding:
      position: 101
      prefix: --jobs
  - id: left_coordinates
    type:
      - 'null'
      - string
    doc: Comma separated values for left coordinate of deletions
    inputBinding:
      position: 101
      prefix: --left-coordinates
  - id: right_coordinates
    type:
      - 'null'
      - string
    doc: Comma separated values for right coordinate of deletions
    inputBinding:
      position: 101
      prefix: --right-coordinates
  - id: read_length
    type:
      - 'null'
      - int
    doc: Expected length of a single read from the .bam file
    inputBinding:
      position: 101
      prefix: --read-length
  - id: window_outer
    type:
      - 'null'
      - int
    doc: Number of bases from the start of each read mates ("outer" part of 
      read) ignored for estimating heteroplasmy.
    inputBinding:
      position: 101
      prefix: --window-outer
  - id: window_inner
    type:
      - 'null'
      - int
    doc: Number of bases near the insert of the read mates ("inner" part of read)
      ignored for estimating heteroplasmy.
    inputBinding:
      position: 101
      prefix: --window-inner
  - id: keep_temp_files
    type:
      - 'null'
      - boolean
    doc: Keep all intermediate files.
    inputBinding:
      position: 101
      prefix: --keep-temp-files
  - id: snake_stdout
    type:
      - 'null'
      - boolean
    doc: Write snakemake log to sdout rather than a file.
    inputBinding:
      position: 101
      prefix: --snake-stdout
  - id: output_path
    type: string
    default: mgatk_del_out
    doc: Output directory for analysis.
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: Directory
    doc: Output directory; the table final/mgatk_del.deletion_heteroplasmy.tsv holds
      the deletion heteroplasmy per cell
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mgatk:0.7.0--pyhdfd78af_2
