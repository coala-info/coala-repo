cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rastair
  - mbias
label: rastair_mbias
doc: "Calculate conversion per base position in read\n\nTool homepage: https://bitbucket.org/bsblabludwig/rastair/src/v0.8.2/"
inputs:
  - id: bed_file
    type: File
    doc: Input per-read BED file (can be gzipped)
    inputBinding:
      position: 1
  - id: exclude_flag
    type:
      - 'null'
      - int
    doc: Exclude bitflag as integer
    inputBinding:
      position: 102
      prefix: --exclude-flag
  - id: include_flag
    type:
      - 'null'
      - int
    doc: Include bitflag as integer
    inputBinding:
      position: 102
      prefix: --include-flag
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Output path prefix
    inputBinding:
      position: 102
      prefix: --output-prefix
  - id: r_script_dir
    type:
      - 'null'
      - Directory
    doc: "Override directory to find R scripts\n          \n          When not set,
      tries to look for `$rastair_path/scripts` and `./scripts`\n          \n    \
      \      [env: R_SCRIPT_DIR=]"
    inputBinding:
      position: 102
      prefix: --r-script-dir
  - id: read_length
    type:
      - 'null'
      - int
    doc: Read length as integer
    inputBinding:
      position: 102
      prefix: --read-length
  - id: region
    type:
      - 'null'
      - string
    doc: Genomic region
    inputBinding:
      position: 102
      prefix: --region
  - id: tabix_path
    type:
      - 'null'
      - File
    doc: Path to tabix executable
    inputBinding:
      position: 102
      prefix: --tabix-path
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Enable more logging\n          \n          You can also use the `RASTAIR_LOG`
      environment variable to configure logging in a more precise way. See the documentation
      of the `tracing-subscriber` library to learn more."
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rastair:2.0.0--h03e3cfe_0
stdout: rastair_mbias.out
