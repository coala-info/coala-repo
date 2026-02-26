cwlVersion: v1.2
class: CommandLineTool
baseCommand: bpipe
label: mintie_override
doc: "Manage and execute Bpipe pipelines.\n\nTool homepage: https://github.com/Oshlack/MINTIE"
inputs:
  - id: command
    type: string
    doc: The bpipe command to execute (e.g., run, test, debug, retry, remake, 
      resume, stop, history, log, jobs, checks, override, status, cleanup, 
      query, preallocate, archive, autoarchive, preserve, register, diagram, 
      diagrameditor).
    inputBinding:
      position: 1
  - id: archive_file
    type:
      - 'null'
      - File
    doc: Path to the archive zip file (used with 'archive').
    inputBinding:
      position: 2
  - id: job_id
    type:
      - 'null'
      - string
    doc: The job ID (used with 'retry', 'log').
    inputBinding:
      position: 3
  - id: output_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Output files to remake (used with 'remake').
    inputBinding:
      position: 4
  - id: pipeline
    type:
      - 'null'
      - string
    doc: The pipeline to execute (used with 'run', 'register', 'diagram', 
      'diagrameditor').
    inputBinding:
      position: 5
  - id: query_file
    type:
      - 'null'
      - File
    doc: File to query (used with 'query').
    inputBinding:
      position: 6
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files for the pipeline (used with 'run', 'register', 'diagram', 
      'diagrameditor').
    inputBinding:
      position: 7
  - id: autoarchive
    type:
      - 'null'
      - string
    doc: Clean up all internal files after run into given archive.
    inputBinding:
      position: 108
      prefix: --autoarchive
  - id: branch
    type:
      - 'null'
      - string
    doc: Comma separated list of branches to limit execution to.
    inputBinding:
      position: 108
      prefix: --branch
  - id: delete_archive
    type:
      - 'null'
      - boolean
    doc: Delete the archive file after creation (used with 'archive').
    inputBinding:
      position: 108
      prefix: --delete
  - id: environment
    type:
      - 'null'
      - string
    doc: Environment to select from alternate configurations in bpipe.config.
    inputBinding:
      position: 108
      prefix: --env
  - id: generate_report
    type:
      - 'null'
      - boolean
    doc: Generate an HTML report / documentation for pipeline.
    inputBinding:
      position: 108
      prefix: --report
  - id: genomic_interval
    type:
      - 'null'
      - string
    doc: The default genomic interval to execute pipeline for (samtools format).
    inputBinding:
      position: 108
      prefix: --interval
  - id: lines
    type:
      - 'null'
      - int
    doc: Number of lines to display in the log.
    inputBinding:
      position: 108
      prefix: --lines
  - id: memory
    type:
      - 'null'
      - string
    doc: Maximum memory in MB, or specified as <n>GB or <n>MB.
    inputBinding:
      position: 108
      prefix: --memory
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory.
    inputBinding:
      position: 108
      prefix: --dir
  - id: parameter
    type:
      - 'null'
      - string
    doc: 'Defines a pipeline parameter, or file of parameters via @<file> (format:
      param=value).'
    inputBinding:
      position: 108
      prefix: --param
  - id: report_filename
    type:
      - 'null'
      - string
    doc: Output file name of report.
    inputBinding:
      position: 108
      prefix: --filename
  - id: report_template
    type:
      - 'null'
      - string
    doc: Generate report using named template.
    inputBinding:
      position: 108
      prefix: --report
  - id: resource_limit
    type:
      - 'null'
      - string
    doc: 'Place limit on named resource (format: resource=value).'
    inputBinding:
      position: 108
      prefix: --resource
  - id: source_pipeline
    type:
      - 'null'
      - type: array
        items: File
    doc: Load the given pipeline file(s) before running / executing.
    inputBinding:
      position: 108
      prefix: --source
  - id: test_mode
    type:
      - 'null'
      - boolean
    doc: Test mode.
    inputBinding:
      position: 108
      prefix: --test
  - id: threads
    type:
      - 'null'
      - int
    doc: Maximum threads.
    inputBinding:
      position: 108
      prefix: --threads
  - id: until_stage
    type:
      - 'null'
      - string
    doc: Run until stage given.
    inputBinding:
      position: 108
      prefix: --until
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print internal logging to standard error.
    inputBinding:
      position: 108
      prefix: --verbose
  - id: yes
    type:
      - 'null'
      - boolean
    doc: Answer yes to any prompts or questions.
    inputBinding:
      position: 108
      prefix: --yes
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mintie:0.4.3--hdfd78af_0
stdout: mintie_override.out
