cwlVersion: v1.2
class: CommandLineTool
baseCommand: bpipe
label: mintie_preallocate
doc: "Manage and execute Bpipe pipelines.\n\nTool homepage: https://github.com/Oshlack/MINTIE"
inputs:
  - id: command
    type: string
    doc: The bpipe command to execute (e.g., run, test, debug, retry, remake, 
      resume, stop, history, log, jobs, checks, override, status, cleanup, 
      query, preallocate, archive, autoarchive, preserve, register, diagram, 
      diagrameditor)
    inputBinding:
      position: 1
  - id: archive_file_path
    type: File
    doc: Path to the zip file for archiving
    inputBinding:
      position: 2
  - id: diagram_pipeline
    type: string
    doc: Pipeline to diagram
    inputBinding:
      position: 3
  - id: diagrameditor_pipeline
    type: string
    doc: Pipeline to open in diagram editor
    inputBinding:
      position: 4
  - id: job_id
    type:
      - 'null'
      - string
    doc: Job ID for retry or log commands
    inputBinding:
      position: 5
  - id: output_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Output files for the remake command
    inputBinding:
      position: 6
  - id: pipeline
    type:
      - 'null'
      - string
    doc: The pipeline to execute
    inputBinding:
      position: 7
  - id: query_file
    type: File
    doc: File to query
    inputBinding:
      position: 8
  - id: register_pipeline
    type: string
    doc: Pipeline to register
    inputBinding:
      position: 9
  - id: diagram_input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files for diagramming
    inputBinding:
      position: 10
  - id: diagrameditor_input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files for diagram editor
    inputBinding:
      position: 11
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files for the pipeline
    inputBinding:
      position: 12
  - id: register_input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files for registration
    inputBinding:
      position: 13
  - id: autoarchive
    type:
      - 'null'
      - string
    doc: Clean up all internal files after run into given archive
    inputBinding:
      position: 114
      prefix: --autoarchive
  - id: branch
    type:
      - 'null'
      - string
    doc: Comma separated list of branches to limit execution to
    inputBinding:
      position: 114
      prefix: --branch
  - id: delete_archive
    type:
      - 'null'
      - boolean
    doc: Delete archive after creation
    inputBinding:
      position: 114
  - id: environment
    type:
      - 'null'
      - string
    doc: Environment to select from alternate configurations in bpipe.config
    inputBinding:
      position: 114
      prefix: --env
  - id: generate_report
    type:
      - 'null'
      - boolean
    doc: Generate an HTML report / documentation for pipeline
    inputBinding:
      position: 114
      prefix: --report
  - id: genomic_interval
    type:
      - 'null'
      - string
    doc: The default genomic interval to execute pipeline for (samtools format)
    inputBinding:
      position: 114
      prefix: --interval
  - id: log_lines
    type:
      - 'null'
      - int
    doc: Number of lines to display for log command
    inputBinding:
      position: 114
      prefix: -n
  - id: memory
    type:
      - 'null'
      - string
    doc: Maximum memory in MB, or specified as <n>GB or <n>MB
    inputBinding:
      position: 114
      prefix: --memory
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory
    inputBinding:
      position: 114
      prefix: --dir
  - id: pipeline_param
    type:
      - 'null'
      - string
    doc: 'Defines a pipeline parameter, or file of parameters via @<file> (format:
      param=value)'
    inputBinding:
      position: 114
      prefix: --param
  - id: preallocated_stop
    type:
      - 'null'
      - boolean
    doc: Stop preallocated jobs
    inputBinding:
      position: 114
  - id: report_filename
    type:
      - 'null'
      - string
    doc: Output file name of report
    inputBinding:
      position: 114
      prefix: --filename
  - id: report_template
    type:
      - 'null'
      - string
    doc: Generate report using named template
    inputBinding:
      position: 114
      prefix: --report
  - id: resource_limit
    type:
      - 'null'
      - string
    doc: 'Place limit on named resource (format: resource=value)'
    inputBinding:
      position: 114
      prefix: --resource
  - id: source_pipeline
    type:
      - 'null'
      - type: array
        items: File
    doc: Load the given pipeline file(s) before running / executing
    inputBinding:
      position: 114
      prefix: --source
  - id: test_mode
    type:
      - 'null'
      - boolean
    doc: Test mode
    inputBinding:
      position: 114
      prefix: --test
  - id: threads
    type:
      - 'null'
      - int
    doc: Maximum threads
    inputBinding:
      position: 114
      prefix: --threads
  - id: until_stage
    type:
      - 'null'
      - string
    doc: Run until stage given
    inputBinding:
      position: 114
      prefix: --until
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print internal logging to standard error
    inputBinding:
      position: 114
      prefix: --verbose
  - id: yes
    type:
      - 'null'
      - boolean
    doc: Answer yes to any prompts or questions
    inputBinding:
      position: 114
      prefix: --yes
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mintie:0.4.3--hdfd78af_0
stdout: mintie_preallocate.out
