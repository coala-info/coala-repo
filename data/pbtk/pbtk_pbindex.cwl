cwlVersion: v1.2
class: CommandLineTool
baseCommand: pbindex
label: pbtk_pbindex
doc: "pbindex creates a index file that enables random-access to PacBio-specific data
  in BAM files. Generated index filename will be the same as input BAM plus .pbi suffix.\n
  \nTool homepage: https://github.com/PacificBiosciences/pbbioconda"
inputs:
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log to a file, instead of stderr.
    inputBinding:
      position: 102
      prefix: --log-file
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Set log level. Valid choices: (TRACE, DEBUG, INFO, WARN, FATAL).'
    inputBinding:
      position: 102
      prefix: --log-level
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use, 0 means autodetection.
    inputBinding:
      position: 102
      prefix: --num-threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbtk:3.5.0--h9ee0642_0
stdout: pbtk_pbindex.out
