cwlVersion: v1.2
class: CommandLineTool
baseCommand: bpipe
label: mintie_checks
doc: "bpipe is a build and deployment tool for bioinformatics pipelines.\n\nTool homepage:
  https://github.com/Oshlack/MINTIE"
inputs:
  - id: command
    type: string
    doc: The bpipe command to execute (e.g., run, test, debug, retry, remake, 
      resume, stop, history, log, jobs, checks, override, status, cleanup, 
      query, preallocate, archive, autoarchive, preserve, register, diagram, 
      diagrameditor)
    inputBinding:
      position: 1
  - id: job_id
    type:
      - 'null'
      - string
    doc: Job ID for retry or log commands
    inputBinding:
      position: 2
  - id: output_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Output files for the remake command
    inputBinding:
      position: 3
  - id: pipeline
    type:
      - 'null'
      - string
    doc: The pipeline to execute
    inputBinding:
      position: 4
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files for the pipeline
    inputBinding:
      position: 5
  - id: test_retry
    type:
      - 'null'
      - string
    doc: Test argument for retry command
    inputBinding:
      position: 6
  - id: autoarchive
    type:
      - 'null'
      - string
    doc: Clean up all internal files after run into given archive
    inputBinding:
      position: 107
      prefix: --autoarchive
  - id: branch
    type:
      - 'null'
      - string
    doc: Comma separated list of branches to limit execution to
    inputBinding:
      position: 107
      prefix: --branch
  - id: delete_archive
    type:
      - 'null'
      - boolean
    doc: Delete archive after creation
    inputBinding:
      position: 107
      prefix: --delete
  - id: environment
    type:
      - 'null'
      - string
    doc: Environment to select from alternate configurations in bpipe.config
    inputBinding:
      position: 107
      prefix: --env
  - id: generate_report
    type:
      - 'null'
      - boolean
    doc: Generate an HTML report / documentation for pipeline
    inputBinding:
      position: 107
      prefix: --report
  - id: genomic_interval
    type:
      - 'null'
      - string
    doc: The default genomic interval to execute pipeline for (samtools format)
    inputBinding:
      position: 107
      prefix: --interval
  - id: lines
    type:
      - 'null'
      - int
    doc: Number of lines to display for log command
    inputBinding:
      position: 107
      prefix: -n
  - id: memory
    type:
      - 'null'
      - string
    doc: Maximum memory in MB, or specified as <n>GB or <n>MB
    inputBinding:
      position: 107
      prefix: --memory
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory
    inputBinding:
      position: 107
      prefix: --dir
  - id: param
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Defines a pipeline parameter, or file of parameters via @<file> (format:
      param=value)'
    inputBinding:
      position: 107
      prefix: --param
  - id: report_template
    type:
      - 'null'
      - string
    doc: Generate report using named template
    inputBinding:
      position: 107
      prefix: --report
  - id: resource_limit
    type:
      - 'null'
      - string
    doc: 'Place limit on named resource (format: resource=value)'
    inputBinding:
      position: 107
      prefix: --resource
  - id: source_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Load the given pipeline file(s) before running / executing
    inputBinding:
      position: 107
      prefix: --source
  - id: test_mode
    type:
      - 'null'
      - boolean
    doc: Test mode
    inputBinding:
      position: 107
      prefix: --test
  - id: threads
    type:
      - 'null'
      - int
    doc: Maximum threads
    inputBinding:
      position: 107
      prefix: --threads
  - id: until_stage
    type:
      - 'null'
      - string
    doc: Run until stage given
    inputBinding:
      position: 107
      prefix: --until
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print internal logging to standard error
    inputBinding:
      position: 107
      prefix: --verbose
  - id: yes
    type:
      - 'null'
      - boolean
    doc: Answer yes to any prompts or questions
    inputBinding:
      position: 107
      prefix: --yes
outputs:
  - id: archive_file
    type:
      - 'null'
      - File
    doc: Path to the archive file for archive command
    outputBinding:
      glob: $(inputs.archive_file)
  - id: report_filename
    type:
      - 'null'
      - File
    doc: Output file name of report
    outputBinding:
      glob: $(inputs.report_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mintie:0.4.3--hdfd78af_0
