cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mrs
  - build
label: mrs_build
doc: "Build a databank from its raw data\n\nTool homepage: https://mrs.cmbi.ru.nl/"
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
  - id: raw_dir
    type: Directory
    doc: Directory with the raw data files (the "raw" directory named in the
      configuration file)
  - id: mrs_dir
    type:
      - 'null'
      - Directory
    doc: Existing directory with built databanks (the "mrs" directory named in
      the configuration file); an empty one is created when not given
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: mrs_dir_out
    type:
      - 'null'
      - Directory
    doc: The mrs directory with the databank files
    outputBinding:
      glob: mrs
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: raw
        entry: $(inputs.raw_dir)
        writable: true
      - entryname: mrs
        entry: |-
          ${ if (inputs.mrs_dir) { return inputs.mrs_dir; } return {class: 'Directory', basename: 'mrs', listing: []}; }
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mrs:v6.0.5dfsg-2b2-deb_cv1
stdout: mrs_build.out
