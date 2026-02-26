cwlVersion: v1.2
class: CommandLineTool
baseCommand: bpipe
label: mintie_resume
doc: "Manage and execute pipelines\n\nTool homepage: https://github.com/Oshlack/MINTIE"
inputs:
  - id: command
    type: string
    doc: Command to execute (e.g., run, test, debug, retry, resume, etc.)
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
    doc: Output files to remake
    inputBinding:
      position: 3
  - id: pipeline
    type:
      - 'null'
      - string
    doc: Pipeline file to execute
    inputBinding:
      position: 4
  - id: pipeline_to_diagram
    type:
      - 'null'
      - string
    doc: Pipeline to generate diagram for
    inputBinding:
      position: 5
  - id: pipeline_to_diagram_editor
    type:
      - 'null'
      - string
    doc: Pipeline to open in diagram editor
    inputBinding:
      position: 6
  - id: pipeline_to_register
    type:
      - 'null'
      - string
    doc: Pipeline to register
    inputBinding:
      position: 7
  - id: query_file
    type:
      - 'null'
      - File
    doc: File to query
    inputBinding:
      position: 8
  - id: zip_file_path
    type:
      - 'null'
      - File
    doc: Path to the zip file for archiving
    inputBinding:
      position: 9
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files for the pipeline
    inputBinding:
      position: 10
  - id: input_files_for_diagram
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files for diagram generation
    inputBinding:
      position: 11
  - id: input_files_for_diagram_editor
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files for diagram editor
    inputBinding:
      position: 12
  - id: input_files_for_register
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files for registration
    inputBinding:
      position: 13
  - id: test_arg
    type:
      - 'null'
      - string
    doc: Test argument for retry command
    inputBinding:
      position: 14
  - id: autoarchive
    type:
      - 'null'
      - string
    doc: Clean up all internal files after run into given archive
    inputBinding:
      position: 115
      prefix: --autoarchive
  - id: branch
    type:
      - 'null'
      - string
    doc: Comma separated list of branches to limit execution to
    inputBinding:
      position: 115
      prefix: --branch
  - id: delete_archive
    type:
      - 'null'
      - boolean
    doc: Delete archive after creation
    inputBinding:
      position: 115
      prefix: --delete
  - id: environment
    type:
      - 'null'
      - string
    doc: Environment to select from alternate configurations in bpipe.config
    inputBinding:
      position: 115
      prefix: --env
  - id: generate_report
    type:
      - 'null'
      - boolean
    doc: Generate an HTML report / documentation for pipeline
    inputBinding:
      position: 115
      prefix: --report
  - id: genomic_interval
    type:
      - 'null'
      - string
    doc: The default genomic interval to execute pipeline for (samtools format)
    inputBinding:
      position: 115
      prefix: --interval
  - id: lines
    type:
      - 'null'
      - int
    doc: Number of lines to show in log
    inputBinding:
      position: 115
      prefix: -n
  - id: memory
    type:
      - 'null'
      - string
    doc: Maximum memory in MB, or specified as <n>GB or <n>MB
    inputBinding:
      position: 115
      prefix: --memory
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory
    inputBinding:
      position: 115
      prefix: --dir
  - id: param
    type:
      - 'null'
      - type: array
        items: string
    doc: Defines a pipeline parameter, or file of parameters via @<file>
    inputBinding:
      position: 115
      prefix: --param
  - id: report_filename
    type:
      - 'null'
      - string
    doc: Output file name of report
    inputBinding:
      position: 115
      prefix: --filename
  - id: report_template
    type:
      - 'null'
      - string
    doc: Generate report using named template
    inputBinding:
      position: 115
      prefix: --report
  - id: resource_limit
    type:
      - 'null'
      - string
    doc: Place limit on named resource (e.g., resource=value)
    inputBinding:
      position: 115
      prefix: --resource
  - id: source_pipelines
    type:
      - 'null'
      - type: array
        items: File
    doc: Load the given pipeline file(s) before running / executing
    inputBinding:
      position: 115
      prefix: --source
  - id: test_mode
    type:
      - 'null'
      - boolean
    doc: Test mode
    inputBinding:
      position: 115
      prefix: --test
  - id: threads
    type:
      - 'null'
      - int
    doc: Maximum threads
    inputBinding:
      position: 115
      prefix: --threads
  - id: until_stage
    type:
      - 'null'
      - string
    doc: Run until stage given
    inputBinding:
      position: 115
      prefix: --until
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print internal logging to standard error
    inputBinding:
      position: 115
      prefix: --verbose
  - id: yes
    type:
      - 'null'
      - boolean
    doc: Answer yes to any prompts or questions
    inputBinding:
      position: 115
      prefix: --yes
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mintie:0.4.3--hdfd78af_0
stdout: mintie_resume.out
