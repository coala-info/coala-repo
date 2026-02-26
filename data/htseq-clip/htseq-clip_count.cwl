cwlVersion: v1.2
class: CommandLineTool
baseCommand: htseq-clip count
label: htseq-clip_count
doc: "counts the number of crosslink/deletion/insertion sites\n\nTool homepage: https://github.com/EMBL-Hentze-group/htseq-clip"
inputs:
  - id: annotation
    type: File
    doc: "flattened annotation file (.bed[.gz]) \n                            See
      \"htseq-clip annotation -h\" OR sliding window annotation file (.bed[.gz]),
      see \"htseq-clip createSlidingWindows -h\""
    inputBinding:
      position: 101
      prefix: --ann
  - id: copy_tmp
    type:
      - 'null'
      - boolean
    doc: "In certain cases, gzip crashes on while running \"htseq-clip count\" with
      a combination of Slurm and Snakemake.\n                            Copying files
      to the local temp. folder seems to get rid of the issue. Use this flag to copy
      files to a tmp. folder. \n                            Default: use system specific
      \"tmp\" folder, use argument \"--tmp\" to specify a custom one"
    inputBinding:
      position: 101
      prefix: --copy_tmp
  - id: input_bed
    type: File
    doc: extracted crosslink, insertion or deletion sites (.bed[.gz]), see 
      "htseq-clip extract -h"
    inputBinding:
      position: 101
      prefix: --input
  - id: temp_directory
    type:
      - 'null'
      - Directory
    doc: 'temp. directory path to copy files (default: None, use system tmp directory)'
    default: None
    inputBinding:
      position: 101
      prefix: --tmp
  - id: unstranded
    type:
      - 'null'
      - boolean
    doc: "crosslink site counting is strand specific by default. \n              \
      \              Use this flag for non strand specific crosslink site counting"
    inputBinding:
      position: 101
      prefix: --unstranded
  - id: verbose_level
    type:
      - 'null'
      - string
    doc: "Verbose level\n                        Allowed choices: debug, info, warn,
      quiet (default: info)"
    default: info
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: 'output count file (.txt[.gz], default: print to console)'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/htseq-clip:2.19.0b0--pyh086e186_0
