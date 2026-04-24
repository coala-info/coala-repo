cwlVersion: v1.2
class: CommandLineTool
baseCommand: fast5seek
label: fast5seek
doc: "Outputs paths of all the fast5 files from a given directory that are contained
  within a fastq or BAM/SAM file.\n\nTool homepage: https://github.com/mbhall88/fast5seek"
inputs:
  - id: fast5_dir
    type:
      type: array
      items: Directory
    doc: Directory of fast5 files you want to query. Program will walk 
      recursively through subdirectories.
    inputBinding:
      position: 101
      prefix: --fast5_dir
  - id: log_level
    type:
      - 'null'
      - int
    doc: Level of logging. 0 is none, 5 is for debugging. Default is 4 which 
      will report info, warnings, errors, and critical information.
    inputBinding:
      position: 101
      prefix: --log_level
  - id: mapped
    type:
      - 'null'
      - boolean
    doc: Only extract read ids for mapped reads in BAM/SAM files.
    inputBinding:
      position: 101
      prefix: --mapped
  - id: no_progress_bar
    type:
      - 'null'
      - boolean
    doc: Do not display progress bar.
    inputBinding:
      position: 101
      prefix: --no_progress_bar
  - id: reference
    type:
      type: array
      items: File
    doc: Fastq or BAM/SAM file(s).
    inputBinding:
      position: 101
      prefix: --reference
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Filename to write fast5 paths to. If nothing is entered, it will write 
      the paths to STDOUT.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fast5seek:0.1.1--py35_0
