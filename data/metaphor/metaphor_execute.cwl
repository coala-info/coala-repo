cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaphor execute
label: metaphor_execute
doc: "Execute a Metaphor workflow.\n\nTool homepage: https://github.com/vinisalazar/metaphor"
inputs:
  - id: conda_prefix
    type:
      - 'null'
      - Directory
    doc: Conda prefix where conda environments will be installed. Default is 
      config directory, this way multiple runs of Metaphor will share the same 
      environments.
    inputBinding:
      position: 101
      prefix: --conda-prefix
  - id: configfile
    type:
      - 'null'
      - File
    doc: Configuration file to run the workflow.
    inputBinding:
      position: 101
      prefix: --configfile
  - id: confirm
    type:
      - 'null'
      - boolean
    doc: Don't ask for confirmation when running tests.
    inputBinding:
      position: 101
      prefix: --confirm
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of cores to be used.
    inputBinding:
      position: 101
      prefix: --cores
  - id: extras
    type:
      - 'null'
      - string
    doc: String of extra arguments to be passed on to Snakemake.
    inputBinding:
      position: 101
      prefix: --extras
  - id: input_dir
    type:
      - 'null'
      - Directory
    doc: Input directory containing FASTQ files.
    inputBinding:
      position: 101
      prefix: --input-dir
  - id: join_units
    type:
      - 'null'
      - boolean
    doc: Whether to join units (S001, S002) with the same preffix as the same 
      file.
    inputBinding:
      position: 101
      prefix: --join-units
  - id: max_mb
    type:
      - 'null'
      - int
    doc: Max amount of MB RAM to be used. Can be set in config.
    inputBinding:
      position: 101
      prefix: --max_mb
  - id: profile
    type:
      - 'null'
      - string
    doc: Profile to be used to run Metaphor.
    inputBinding:
      position: 101
      prefix: --profile
  - id: skip_report
    type:
      - 'null'
      - boolean
    doc: Don't create report when run finishes.
    inputBinding:
      position: 101
      prefix: --skip-report
  - id: unlock
    type:
      - 'null'
      - boolean
    doc: Unlock the working directory. For more information, see the Snakemake 
      '--unlock' flag.
    inputBinding:
      position: 101
      prefix: --unlock
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaphor:1.7.14--pyhdfd78af_0
stdout: metaphor_execute.out
