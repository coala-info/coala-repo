cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bpipe
  - diagrameditor
label: mintie_diagrameditor
doc: "Diagram editor for a bpipe pipeline\n\nTool homepage: https://github.com/Oshlack/MINTIE"
inputs:
  - id: pipeline
    type: string
    doc: The bpipe pipeline file
    inputBinding:
      position: 1
  - id: input_files
    type:
      type: array
      items: File
    doc: Input files for the pipeline
    inputBinding:
      position: 2
  - id: autoarchive
    type:
      - 'null'
      - string
    doc: Clean up all internal files after run into given archive
    inputBinding:
      position: 103
      prefix: --autoarchive
  - id: branch
    type:
      - 'null'
      - string
    doc: Comma separated list of branches to limit execution to
    inputBinding:
      position: 103
      prefix: --branch
  - id: default_genomic_interval
    type:
      - 'null'
      - string
    doc: The default genomic interval to execute pipeline for (samtools format)
    inputBinding:
      position: 103
      prefix: --interval
  - id: environment
    type:
      - 'null'
      - string
    doc: Environment to select from alternate configurations in bpipe.config
    inputBinding:
      position: 103
      prefix: --env
  - id: generate_report
    type:
      - 'null'
      - boolean
    doc: Generate an HTML report / documentation for pipeline
    inputBinding:
      position: 103
      prefix: --report
  - id: memory
    type:
      - 'null'
      - string
    doc: Maximum memory in MB, or specified as <n>GB or <n>MB
    inputBinding:
      position: 103
      prefix: --memory
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory
    inputBinding:
      position: 103
      prefix: --dir
  - id: param
    type:
      - 'null'
      - type: array
        items: string
    doc: Defines a pipeline parameter, or file of parameters via @<file>
    inputBinding:
      position: 103
      prefix: --param
  - id: report_filename
    type:
      - 'null'
      - string
    doc: Output file name of report
    inputBinding:
      position: 103
      prefix: --filename
  - id: report_template
    type:
      - 'null'
      - string
    doc: Generate report using named template
    inputBinding:
      position: 103
      prefix: --report
  - id: resource_limit
    type:
      - 'null'
      - string
    doc: Place limit on named resource (e.g., resource=value)
    inputBinding:
      position: 103
      prefix: --resource
  - id: source_pipelines
    type:
      - 'null'
      - type: array
        items: File
    doc: Load the given pipeline file(s) before running / executing
    inputBinding:
      position: 103
      prefix: --source
  - id: test_mode
    type:
      - 'null'
      - boolean
    doc: Test mode
    inputBinding:
      position: 103
      prefix: --test
  - id: threads
    type:
      - 'null'
      - int
    doc: Maximum threads
    inputBinding:
      position: 103
      prefix: --threads
  - id: until_stage
    type:
      - 'null'
      - string
    doc: Run until stage given
    inputBinding:
      position: 103
      prefix: --until
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print internal logging to standard error
    inputBinding:
      position: 103
      prefix: --verbose
  - id: yes
    type:
      - 'null'
      - boolean
    doc: Answer yes to any prompts or questions
    inputBinding:
      position: 103
      prefix: --yes
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mintie:0.4.3--hdfd78af_0
stdout: mintie_diagrameditor.out
