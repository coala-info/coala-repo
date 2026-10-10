cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mrs
  - password
label: mrs_password
doc: "Generate password for use in configuration file: modifies user password information in the configuration file\n\nTool homepage: https://mrs.cmbi.ru.nl/"
inputs:
  - id: config
    type: File
    secondaryFiles:
      - pattern: ^.dtd
        required: true
    doc: 'MRS configuration file to update. It must be named mrs-config.xml and have its DTD
      mrs-config.dtd beside it. Directories in it should be relative paths such as
      mrs, raw (the directories staged by this tool) so they resolve in the working
      directory.'
    inputBinding:
      position: 101
      valueFrom: $(self.basename)
      prefix: --config
  - id: user
    type: string
    doc: User to modify
    inputBinding:
      position: 101
      prefix: --user
  - id: realm
    type: string
    doc: Realm to modify
    inputBinding:
      position: 101
      prefix: --realm
  - id: password_input
    type: File
    doc: Text file with the new password on two lines (mrs asks for it twice on
      standard input)
    streamable: false
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: config_out
    type: File
    doc: The updated configuration file
    secondaryFiles:
      - pattern: ^.dtd
        required: false
    outputBinding:
      glob: $(inputs.config.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.config)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mrs:v6.0.5dfsg-2b2-deb_cv1
stdin: $(inputs.password_input.path)
stdout: mrs_password.out
