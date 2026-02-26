cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bpipe
  - remake
label: mintie_remake
doc: "Remake files\n\nTool homepage: https://github.com/Oshlack/MINTIE"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Files to remake
    inputBinding:
      position: 1
  - id: autoarchive
    type:
      - 'null'
      - string
    doc: clean up all internal files after run into given archive
    inputBinding:
      position: 102
      prefix: --autoarchive
  - id: branch
    type:
      - 'null'
      - string
    doc: Comma separated list of branches to limit execution to
    inputBinding:
      position: 102
      prefix: --branch
  - id: environment
    type:
      - 'null'
      - string
    doc: Environment to select from alternate configurations in bpipe.config
    inputBinding:
      position: 102
      prefix: --env
  - id: generate_report
    type:
      - 'null'
      - boolean
    doc: generate an HTML report / documentation for pipeline
    inputBinding:
      position: 102
      prefix: --report
  - id: genomic_interval
    type:
      - 'null'
      - string
    doc: the default genomic interval to execute pipeline for (samtools format)
    inputBinding:
      position: 102
      prefix: --interval
  - id: memory
    type:
      - 'null'
      - string
    doc: maximum memory in MB, or specified as <n>GB or <n>MB
    inputBinding:
      position: 102
      prefix: --memory
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: output directory
    inputBinding:
      position: 102
      prefix: --dir
  - id: pipeline_param
    type:
      - 'null'
      - string
    doc: defines a pipeline parameter, or file of parameters via @<file>
    inputBinding:
      position: 102
      prefix: --param
  - id: report_filename
    type:
      - 'null'
      - string
    doc: output file name of report
    inputBinding:
      position: 102
      prefix: --filename
  - id: report_template
    type:
      - 'null'
      - string
    doc: generate report using named template
    inputBinding:
      position: 102
      prefix: --report
  - id: resource_limit
    type:
      - 'null'
      - string
    doc: place limit on named resource
    inputBinding:
      position: 102
      prefix: --resource
  - id: run_until
    type:
      - 'null'
      - string
    doc: run until stage given
    inputBinding:
      position: 102
      prefix: --until
  - id: source_pipelines
    type:
      - 'null'
      - type: array
        items: File
    doc: Load the given pipeline file(s) before running / executing
    inputBinding:
      position: 102
      prefix: --source
  - id: test_mode
    type:
      - 'null'
      - boolean
    doc: test mode
    inputBinding:
      position: 102
      prefix: --test
  - id: threads
    type:
      - 'null'
      - int
    doc: maximum threads
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print internal logging to standard error
    inputBinding:
      position: 102
      prefix: --verbose
  - id: yes
    type:
      - 'null'
      - boolean
    doc: answer yes to any prompts or questions
    inputBinding:
      position: 102
      prefix: --yes
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mintie:0.4.3--hdfd78af_0
stdout: mintie_remake.out
