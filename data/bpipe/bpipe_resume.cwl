cwlVersion: v1.2
class: CommandLineTool
baseCommand: bpipe
label: bpipe_resume
doc: "bpipe [run|test|debug|touch|execute] [options] <pipeline> <in1> <in2>...\n \
  \            retry [job id] [test]\n             remake <file1> <file2>...\n   \
  \          resume\n             stop [preallocated]\n             history\n    \
  \         log [-n <lines>] [job id]\n             jobs\n             checks [options]\n\
  \             override\n             status\n             cleanup\n            \
  \ query <file>\n             preallocate\n             archive [--delete] <zip file
  path>\n             autoarchive\n             preserve\n             register <pipeline>
  <in1> <in2>...\n             diagram <pipeline> <in1> <in2>...\n             diagrameditor
  <pipeline> <in1> <in2>...\n\nTool homepage: http://docs.bpipe.org/"
inputs:
  - id: autoarchive
    type:
      - 'null'
      - string
    doc: clean up all internal files after run into given archive
    inputBinding:
      position: 101
      prefix: --autoarchive
  - id: branch
    type:
      - 'null'
      - string
    doc: Comma separated list of branches to limit execution to
    inputBinding:
      position: 101
      prefix: --branch
  - id: delay
    type:
      - 'null'
      - string
    doc: Delay in seconds before starting pipeline
    inputBinding:
      position: 101
      prefix: --delay
  - id: environment
    type:
      - 'null'
      - string
    doc: "Environment to select from alternate configurations in\n               \
      \                   bpipe.config"
    inputBinding:
      position: 101
      prefix: --env
  - id: generate_report
    type:
      - 'null'
      - boolean
    doc: generate an HTML report / documentation for pipeline
    inputBinding:
      position: 101
      prefix: --report
  - id: genomic_interval
    type:
      - 'null'
      - string
    doc: "the default genomic interval to execute pipeline for (samtools\n       \
      \                           format)"
    inputBinding:
      position: 101
      prefix: --interval
  - id: memory
    type:
      - 'null'
      - string
    doc: maximum memory in MB, or specified as <n>GB or <n>MB
    inputBinding:
      position: 101
      prefix: --memory
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: output directory
    inputBinding:
      position: 101
      prefix: --dir
  - id: param
    type:
      - 'null'
      - type: array
        items: string
    doc: defines a pipeline parameter, or file of parameters via @<file>
    inputBinding:
      position: 101
      prefix: --param
  - id: report_filename
    type:
      - 'null'
      - string
    doc: output file name of report
    inputBinding:
      position: 101
      prefix: --filename
  - id: report_template
    type:
      - 'null'
      - string
    doc: generate report using named template
    inputBinding:
      position: 101
      prefix: --report
  - id: resource_limit
    type:
      - 'null'
      - string
    doc: place limit on named resource
    inputBinding:
      position: 101
      prefix: --resource
  - id: source_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Load the given pipeline file(s) before running / executing
    inputBinding:
      position: 101
      prefix: --source
  - id: test_mode
    type:
      - 'null'
      - boolean
    doc: test mode
    inputBinding:
      position: 101
      prefix: --test
  - id: threads
    type:
      - 'null'
      - int
    doc: maximum threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: until_stage
    type:
      - 'null'
      - string
    doc: run until stage given
    inputBinding:
      position: 101
      prefix: --until
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print internal logging to standard error
    inputBinding:
      position: 101
      prefix: --verbose
  - id: yes
    type:
      - 'null'
      - boolean
    doc: answer yes to any prompts or questions
    inputBinding:
      position: 101
      prefix: --yes
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bpipe:0.9.13--hdfd78af_0
stdout: bpipe_resume.out
