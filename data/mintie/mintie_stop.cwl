cwlVersion: v1.2
class: CommandLineTool
baseCommand: bpipe
label: mintie_stop
doc: "bpipe is a build and deployment tool for bioinformatics pipelines.\n\nTool homepage:
  https://github.com/Oshlack/MINTIE"
inputs:
  - id: command
    type: string
    doc: The bpipe command to execute (e.g., run, test, debug, stop, history, 
      log, jobs, checks, status, cleanup, query, preallocate, archive, 
      autoarchive, preserve, register, diagram, diagrameditor, retry, remake, 
      resume)
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
      type: array
      items: File
    doc: Output files to remake
    inputBinding:
      position: 3
  - id: pipeline
    type:
      - 'null'
      - string
    doc: The pipeline to run
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
  - id: autoarchive
    type:
      - 'null'
      - string
    doc: Clean up all internal files after run into given archive
    inputBinding:
      position: 106
      prefix: --autoarchive
  - id: branch
    type:
      - 'null'
      - string
    doc: Comma separated list of branches to limit execution to
    inputBinding:
      position: 106
      prefix: --branch
  - id: delete
    type:
      - 'null'
      - boolean
    doc: Delete files after archiving
    inputBinding:
      position: 106
  - id: environment
    type:
      - 'null'
      - string
    doc: Environment to select from alternate configurations in bpipe.config
    inputBinding:
      position: 106
      prefix: --env
  - id: generate_report
    type:
      - 'null'
      - boolean
    doc: Generate an HTML report / documentation for pipeline
    inputBinding:
      position: 106
      prefix: --report
  - id: genomic_interval
    type:
      - 'null'
      - string
    doc: The default genomic interval to execute pipeline for (samtools format)
    inputBinding:
      position: 106
      prefix: --interval
  - id: lines
    type:
      - 'null'
      - int
    doc: Number of lines to display in log
    inputBinding:
      position: 106
      prefix: --lines
  - id: memory
    type:
      - 'null'
      - string
    doc: Maximum memory in MB, or specified as <n>GB or <n>MB
    inputBinding:
      position: 106
      prefix: --memory
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory
    inputBinding:
      position: 106
      prefix: --dir
  - id: pipeline_param
    type:
      - 'null'
      - type: array
        items: string
    doc: Defines a pipeline parameter, or file of parameters via @<file>
    inputBinding:
      position: 106
      prefix: --param
  - id: preallocated
    type:
      - 'null'
      - boolean
    doc: Stop preallocated jobs
    inputBinding:
      position: 106
  - id: report_template
    type:
      - 'null'
      - string
    doc: Generate report using named template
    inputBinding:
      position: 106
      prefix: --report
  - id: resource_limit
    type:
      - 'null'
      - string
    doc: Place limit on named resource (e.g., resource=value)
    inputBinding:
      position: 106
      prefix: --resource
  - id: run_until
    type:
      - 'null'
      - string
    doc: Run until stage given
    inputBinding:
      position: 106
      prefix: --until
  - id: source_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Load the given pipeline file(s) before running / executing
    inputBinding:
      position: 106
      prefix: --source
  - id: test_mode
    type:
      - 'null'
      - boolean
    doc: Test mode
    inputBinding:
      position: 106
      prefix: --test
  - id: threads
    type:
      - 'null'
      - int
    doc: Maximum threads
    inputBinding:
      position: 106
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print internal logging to standard error
    inputBinding:
      position: 106
      prefix: --verbose
  - id: yes
    type:
      - 'null'
      - boolean
    doc: Answer yes to any prompts or questions
    inputBinding:
      position: 106
      prefix: --yes
outputs:
  - id: archive_file
    type: File
    doc: Path to the archive file
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
