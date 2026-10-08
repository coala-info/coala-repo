cwlVersion: v1.2
class: CommandLineTool
baseCommand: sraconvert
label: geofetch_sraconvert
doc: "The SRA data converter is a wrapper around sra-tools that provides convenience
  functions for converting or deleting sra data in various formats.\n\nTool homepage:
  https://github.com/pepkit/geofetch"
inputs:
  - id: srr
    type:
      type: array
      items: string
    doc: SRR files
    inputBinding:
      position: 101
      prefix: --srr
  - id: mode
    type:
      - 'null'
      - string
    doc: "What do you want to do? One of convert, delete_sra, delete_bam, delete_fq.
      Default: convert"
    inputBinding:
      position: 101
      prefix: --mode
  - id: format
    type:
      - 'null'
      - string
    doc: "Convert to what format? fastq or bam. Default: fastq"
    inputBinding:
      position: 101
      prefix: --format
  - id: bamfolder
    type:
      - 'null'
      - string
    doc: "Optional: Specify a location to store bam files"
    inputBinding:
      position: 101
      prefix: --bamfolder
  - id: fqfolder
    type:
      - 'null'
      - string
    doc: "Optional: Specify a location to store fastq files"
    inputBinding:
      position: 101
      prefix: --fqfolder
  - id: srafolder
    type:
      - 'null'
      - Directory
    doc: "Optional: Specify a location of the sra files"
    inputBinding:
      position: 101
      prefix: --srafolder
  - id: keep_sra
    type:
      - 'null'
      - boolean
    doc: On convert mode, keep original sra data?
    inputBinding:
      position: 101
      prefix: --keep-sra
  - id: sample_name
    type:
      - 'null'
      - type: array
        items: string
    doc: Name for sample to run
    inputBinding:
      position: 101
      prefix: --sample-name
  - id: config
    type:
      - 'null'
      - File
    doc: Pipeline configuration file (YAML). Relative paths are with respect to the
      pipeline script.
    inputBinding:
      position: 101
      prefix: --config
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Silence logging. Overrides verbosity.
    inputBinding:
      position: 101
      prefix: --silent
  - id: verbosity
    type:
      - 'null'
      - string
    doc: Set logging level (1-5 or logging module level name)
    inputBinding:
      position: 101
      prefix: --verbosity
  - id: logdev
    type:
      - 'null'
      - boolean
    doc: Expand content of logging message format.
    inputBinding:
      position: 101
      prefix: --logdev
  - id: output_parent
    type:
      - 'null'
      - string
    doc: Parent output directory of project
    inputBinding:
      position: 101
      prefix: --output-parent
  - id: recover
    type:
      - 'null'
      - boolean
    doc: Overwrite locks to recover from previous failed run
    inputBinding:
      position: 101
      prefix: --recover
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: fastq_folder_out
    type:
      - 'null'
      - Directory
    doc: Folder with the converted fastq files
    outputBinding:
      glob: $(inputs.fqfolder)
  - id: bam_folder_out
    type:
      - 'null'
      - Directory
    doc: Folder with the converted bam files
    outputBinding:
      glob: $(inputs.bamfolder)
  - id: output_parent_out
    type:
      - 'null'
      - Directory
    doc: Parent output directory of the project
    outputBinding:
      glob: $(inputs.output_parent)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/geofetch:0.12.10--pyhdfd78af_0
stdout: geofetch_sraconvert.out
