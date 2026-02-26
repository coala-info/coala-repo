cwlVersion: v1.2
class: CommandLineTool
baseCommand: bpipe
label: mintie_query
doc: "bpipe is a build and automation tool for bioinformatics pipelines.\n\nTool homepage:
  https://github.com/Oshlack/MINTIE"
inputs:
  - id: command
    type: string
    doc: The bpipe command to execute (e.g., run, test, query, etc.)
    inputBinding:
      position: 1
  - id: command_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments specific to the chosen bpipe command
    inputBinding:
      position: 2
  - id: autoarchive
    type:
      - 'null'
      - string
    doc: clean up all internal files after run into given archive
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
  - id: dir
    type:
      - 'null'
      - Directory
    doc: output directory
    inputBinding:
      position: 103
      prefix: --dir
  - id: env
    type:
      - 'null'
      - string
    doc: Environment to select from alternate configurations in bpipe.config
    inputBinding:
      position: 103
      prefix: --env
  - id: filename
    type:
      - 'null'
      - string
    doc: output file name of report
    inputBinding:
      position: 103
      prefix: --filename
  - id: interval
    type:
      - 'null'
      - string
    doc: the default genomic interval to execute pipeline for (samtools format)
    inputBinding:
      position: 103
      prefix: --interval
  - id: memory
    type:
      - 'null'
      - string
    doc: maximum memory in MB, or specified as <n>GB or <n>MB
    inputBinding:
      position: 103
      prefix: --memory
  - id: param
    type:
      - 'null'
      - string
    doc: defines a pipeline parameter, or file of parameters via @<file>
    inputBinding:
      position: 103
      prefix: --param
  - id: report
    type:
      - 'null'
      - boolean
    doc: generate an HTML report / documentation for pipeline
    inputBinding:
      position: 103
      prefix: --report
  - id: report_template
    type:
      - 'null'
      - string
    doc: generate report using named template
    inputBinding:
      position: 103
      prefix: --report
  - id: resource
    type:
      - 'null'
      - string
    doc: place limit on named resource
    inputBinding:
      position: 103
      prefix: --resource
  - id: source
    type:
      - 'null'
      - type: array
        items: File
    doc: Load the given pipeline file(s) before running / executing
    inputBinding:
      position: 103
      prefix: --source
  - id: test
    type:
      - 'null'
      - boolean
    doc: test mode
    inputBinding:
      position: 103
      prefix: --test
  - id: threads
    type:
      - 'null'
      - int
    doc: maximum threads
    inputBinding:
      position: 103
      prefix: --threads
  - id: until
    type:
      - 'null'
      - string
    doc: run until stage given
    inputBinding:
      position: 103
      prefix: --until
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print internal logging to standard error
    inputBinding:
      position: 103
      prefix: --verbose
  - id: yes
    type:
      - 'null'
      - boolean
    doc: answer yes to any prompts or questions
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
stdout: mintie_query.out
