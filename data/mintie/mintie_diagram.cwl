cwlVersion: v1.2
class: CommandLineTool
baseCommand: bpipe
label: mintie_diagram
doc: "bpipe is a build and automation tool for bioinformatics pipelines.\n\nTool homepage:
  https://github.com/Oshlack/MINTIE"
inputs:
  - id: command
    type: string
    doc: The bpipe command to execute (e.g., run, test, debug, diagram, 
      diagrameditor, etc.)
    inputBinding:
      position: 1
  - id: pipeline
    type:
      - 'null'
      - string
    doc: The pipeline to execute or operate on.
    inputBinding:
      position: 2
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files for the pipeline.
    inputBinding:
      position: 3
  - id: autoarchive
    type:
      - 'null'
      - string
    doc: Clean up all internal files after run into given archive
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
  - id: dir
    type:
      - 'null'
      - Directory
    doc: Output directory
    inputBinding:
      position: 104
      prefix: --dir
  - id: env
    type:
      - 'null'
      - string
    doc: Environment to select from alternate configurations in bpipe.config
    inputBinding:
      position: 104
      prefix: --env
  - id: filename
    type:
      - 'null'
      - string
    doc: Output file name of report
    inputBinding:
      position: 104
      prefix: --filename
  - id: interval
    type:
      - 'null'
      - string
    doc: The default genomic interval to execute pipeline for (samtools format)
    inputBinding:
      position: 104
      prefix: --interval
  - id: memory
    type:
      - 'null'
      - string
    doc: Maximum memory in MB, or specified as <n>GB or <n>MB
    inputBinding:
      position: 104
      prefix: --memory
  - id: param
    type:
      - 'null'
      - string
    doc: Defines a pipeline parameter, or file of parameters via @<file>
    inputBinding:
      position: 104
      prefix: --param
  - id: report
    type:
      - 'null'
      - boolean
    doc: Generate an HTML report / documentation for pipeline
    inputBinding:
      position: 104
      prefix: --report
  - id: report_template
    type:
      - 'null'
      - string
    doc: Generate report using named template
    inputBinding:
      position: 104
      prefix: --report
  - id: resource
    type:
      - 'null'
      - string
    doc: Place limit on named resource
    inputBinding:
      position: 104
      prefix: --resource
  - id: source
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
    doc: Test mode
    inputBinding:
      position: 104
      prefix: --test
  - id: threads
    type:
      - 'null'
      - int
    doc: Maximum threads
    inputBinding:
      position: 104
      prefix: --threads
  - id: until
    type:
      - 'null'
      - string
    doc: Run until stage given
    inputBinding:
      position: 104
      prefix: --until
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print internal logging to standard error
    inputBinding:
      position: 104
      prefix: --verbose
  - id: yes
    type:
      - 'null'
      - boolean
    doc: Answer yes to any prompts or questions
    inputBinding:
      position: 104
      prefix: --yes
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mintie:0.4.3--hdfd78af_0
stdout: mintie_diagram.out
