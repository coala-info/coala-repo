cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mrs
  - entry
label: mrs_entry
doc: "Retrieve and print an entry\n\nTool homepage: https://mrs.cmbi.ru.nl/"
inputs:
  - id: config
    type: File
    secondaryFiles:
      - pattern: ^.dtd
        required: true
    doc: 'MRS configuration file. It must be named mrs-config.xml and have its DTD
      mrs-config.dtd beside it. Directories in it should be relative paths such as
      mrs, raw (the directories staged by this tool) so they resolve in the working
      directory.'
    inputBinding:
      position: 101
      prefix: --config
  - id: databank
    type: string
    doc: Databank
    inputBinding:
      position: 101
      prefix: --databank
  - id: entry
    type: string
    doc: Entry ID to display
    inputBinding:
      position: 101
      prefix: --entry
  - id: threads
    type:
      - 'null'
      - int
    doc: Nr of threads/pipelines
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be verbose
    inputBinding:
      position: 101
      prefix: --verbose
  - id: mrs_dir
    type: Directory
    doc: Directory with the built databanks (the "mrs" directory named in the
      configuration file)
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: mrs
        entry: $(inputs.mrs_dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mrs:v6.0.5dfsg-2b2-deb_cv1
stdout: mrs_entry.out
