cwlVersion: v1.2
class: CommandLineTool
baseCommand: debarcer.py preprocess
label: debarcer_preprocess
doc: "Preprocess FASTQ files for debarcer.\n\nTool homepage: https://github.com/oicr-gsi/debarcer"
inputs:
  - id: config
    type:
      - 'null'
      - File
    doc: Path to your config file
    inputBinding:
      position: 101
      prefix: --Config
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory. Available from command or config
    inputBinding:
      position: 101
      prefix: --OutDir
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for naming umi-reheradered fastqs. Use Prefix from Read1 if not 
      provided
    inputBinding:
      position: 101
      prefix: --Prefix
  - id: prepfile
    type:
      - 'null'
      - File
    doc: Path to your library_prep_types.ini file
    inputBinding:
      position: 101
      prefix: --Prepfile
  - id: prepname
    type: string
    doc: Name of library prep to use (defined in library_prep_types.ini)
    inputBinding:
      position: 101
      prefix: --Prepname
  - id: read1
    type: File
    doc: Path to first FASTQ file.
    inputBinding:
      position: 101
      prefix: --Read1
  - id: read2
    type:
      - 'null'
      - File
    doc: Path to second FASTQ file, if applicable
    inputBinding:
      position: 101
      prefix: --Read2
  - id: read3
    type:
      - 'null'
      - File
    doc: Path to third FASTQ file, if applicable
    inputBinding:
      position: 101
      prefix: --Read3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/debarcer:2.1.4--pyhdfd78af_2
stdout: debarcer_preprocess.out
