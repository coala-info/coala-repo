cwlVersion: v1.2
class: CommandLineTool
baseCommand: bpipe
label: bpipe_execute
doc: "Bpipe Version 0.9.13   Built on Fri Aug 23 09:45:10 GMT 2024\n\nTool homepage:
  http://docs.bpipe.org/"
inputs:
  - id: command
    type: string
    doc: Command to execute (run, test, debug, touch, execute, retry, remake, 
      resume, stop, history, log, jobs, checks, override, status, cleanup, 
      query, preallocate, archive, autoarchive, preserve, register, diagram, 
      diagrameditor)
    inputBinding:
      position: 1
  - id: pipeline
    type:
      - 'null'
      - string
    doc: Pipeline to execute
    inputBinding:
      position: 2
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files for the pipeline
    inputBinding:
      position: 3
  - id: autoarchive
    type:
      - 'null'
      - string
    doc: clean up all internal files after run into given archive
    inputBinding:
      position: 104
      prefix: --autoarchive
  - id: branch
    type:
      - 'null'
      - string
    doc: Comma separated list of branches to limit execution to
    inputBinding:
      position: 104
      prefix: --branch
  - id: delay
    type:
      - 'null'
      - int
    doc: Delay in seconds before starting pipeline
    inputBinding:
      position: 104
      prefix: --delay
  - id: environment
    type:
      - 'null'
      - string
    doc: Environment to select from alternate configurations in bpipe.config
    inputBinding:
      position: 104
      prefix: --env
  - id: generate_report
    type:
      - 'null'
      - boolean
    doc: generate an HTML report / documentation for pipeline
    inputBinding:
      position: 104
      prefix: --report
  - id: genomic_interval
    type:
      - 'null'
      - string
    doc: the default genomic interval to execute pipeline for (samtools format)
    inputBinding:
      position: 104
      prefix: --interval
  - id: memory
    type:
      - 'null'
      - string
    doc: maximum memory in MB, or specified as <n>GB or <n>MB
    inputBinding:
      position: 104
      prefix: --memory
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: output directory
    inputBinding:
      position: 104
      prefix: --dir
  - id: param
    type:
      - 'null'
      - type: array
        items: string
    doc: defines a pipeline parameter, or file of parameters via @<file>
    inputBinding:
      position: 104
      prefix: --param
  - id: report_filename
    type:
      - 'null'
      - string
    doc: output file name of report
    inputBinding:
      position: 104
      prefix: --filename
  - id: report_template
    type:
      - 'null'
      - string
    doc: generate report using named template
    inputBinding:
      position: 104
      prefix: --report
  - id: resource_limit
    type:
      - 'null'
      - string
    doc: place limit on named resource
    inputBinding:
      position: 104
      prefix: --resource
  - id: source_pipeline
    type:
      - 'null'
      - type: array
        items: File
    doc: Load the given pipeline file(s) before running / executing
    inputBinding:
      position: 104
      prefix: --source
  - id: test_mode
    type:
      - 'null'
      - boolean
    doc: test mode
    inputBinding:
      position: 104
      prefix: --test
  - id: threads
    type:
      - 'null'
      - int
    doc: maximum threads
    inputBinding:
      position: 104
      prefix: --threads
  - id: until_stage
    type:
      - 'null'
      - string
    doc: run until stage given
    inputBinding:
      position: 104
      prefix: --until
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print internal logging to standard error
    inputBinding:
      position: 104
      prefix: --verbose
  - id: yes
    type:
      - 'null'
      - boolean
    doc: answer yes to any prompts or questions
    inputBinding:
      position: 104
      prefix: --yes
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bpipe:0.9.13--hdfd78af_0
stdout: bpipe_execute.out
