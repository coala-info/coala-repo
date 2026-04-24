cwlVersion: v1.2
class: CommandLineTool
baseCommand: prefetch
label: parallel-fastq-dump_prefetch
doc: "Download SRA accessions and their dependencies\n\nTool homepage: https://github.com/rvalieris/parallel-fastq-dump"
inputs:
  - id: accessions
    type:
      - 'null'
      - type: array
        items: string
    doc: list of accessions to process
    inputBinding:
      position: 1
  - id: cart
    type:
      - 'null'
      - File
    doc: <path> to cart file
    inputBinding:
      position: 102
      prefix: --cart
  - id: check_all
    type:
      - 'null'
      - boolean
    doc: Double-check all refseqs
    inputBinding:
      position: 102
      prefix: --check-all
  - id: disable_multithreading
    type:
      - 'null'
      - boolean
    doc: disable multithreading
    inputBinding:
      position: 102
      prefix: --disable-multithreading
  - id: force
    type:
      - 'null'
      - string
    doc: 'Force object download - one of: no, yes, all, ALL. no [default]: skip download
      if the object if found and complete; yes: download it even if it is found and
      is complete; all: ignore lock files; ALL: ignore lock files, restart download
      from beginning'
    inputBinding:
      position: 102
      prefix: --force
  - id: location
    type:
      - 'null'
      - string
    doc: location in cloud
    inputBinding:
      position: 102
      prefix: --location
  - id: log_level
    type:
      - 'null'
      - string
    doc: Logging level as number or enum string. One of (fatal|sys|int|err|warn|info|debug)
      or (0-6) Current/default is warn
    inputBinding:
      position: 102
      prefix: --log-level
  - id: max_size
    type:
      - 'null'
      - string
    doc: 'Maximum file size to download in KB (exclusive). Default: 20G'
    inputBinding:
      position: 102
      prefix: --max-size
  - id: min_size
    type:
      - 'null'
      - int
    doc: Minimum file size to download in KB (inclusive).
    inputBinding:
      position: 102
      prefix: --min-size
  - id: ngc
    type:
      - 'null'
      - File
    doc: <path> to ngc file
    inputBinding:
      position: 102
      prefix: --ngc
  - id: option_file
    type:
      - 'null'
      - File
    doc: Read more options and parameters from the file.
    inputBinding:
      position: 102
      prefix: --option-file
  - id: perm
    type:
      - 'null'
      - File
    doc: <path> to permission file
    inputBinding:
      position: 102
      prefix: --perm
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Show progress
    inputBinding:
      position: 102
      prefix: --progress
  - id: resume
    type:
      - 'null'
      - string
    doc: 'Resume partial downloads - one of: no, yes [default]'
    inputBinding:
      position: 102
      prefix: --resume
  - id: type
    type:
      - 'null'
      - string
    doc: 'Specify file type to download. Default: sra'
    inputBinding:
      position: 102
      prefix: --type
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Increase the verbosity of the program status messages. Use multiple times
      for more verbosity.
    inputBinding:
      position: 102
      prefix: --verbose
  - id: verify
    type:
      - 'null'
      - string
    doc: 'Verify after download - one of: no, yes [default]'
    inputBinding:
      position: 102
      prefix: --verify
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Write file to <file> when downloading single file
    outputBinding:
      glob: $(inputs.output_file)
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Save files to <directory>/
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parallel-fastq-dump:0.6.7--pyhdfd78af_0
