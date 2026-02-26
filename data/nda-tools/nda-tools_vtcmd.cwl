cwlVersion: v1.2
class: CommandLineTool
baseCommand: vtcmd
label: nda-tools_vtcmd
doc: "This application allows you to validate files and submit data into NDA. You\n\
  Must enter a list of at least one file to be validated. If your data contains\n\
  manifest files, you must specify the location of the manifests. If your data\nalso
  includes associated files, you must enter a list of at least one\ndirectory where
  the associated files are saved. Alternatively, if any of your\ndata is stored in
  AWS, you must provide your account credentials, the AWS\nbucket, and a prefix, if
  it exists. Any files that are created while running\nthe client (ie. results files)
  will be downloaded in your home directory under\nNDAValidationResults. If your submission
  was interrupted in the middle, you\nmay resume your upload by entering a valid submission
  ID.\n\nTool homepage: https://github.com/NDAR/nda-tools"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: Returns validation results for list of files
    inputBinding:
      position: 1
  - id: batch
    type:
      - 'null'
      - int
    doc: Batch size
    inputBinding:
      position: 102
      prefix: --batch
  - id: build_package
    type:
      - 'null'
      - boolean
    doc: Flag whether to construct the submission package
    inputBinding:
      position: 102
      prefix: --buildPackage
  - id: collection_id
    type:
      - 'null'
      - string
    doc: The integer part of an NDA collection ID, i.e., for collection C1234, 
      enter 1234
    inputBinding:
      position: 102
      prefix: --collectionID
  - id: description
    type:
      - 'null'
      - string
    doc: The description of the submission
    inputBinding:
      position: 102
      prefix: --description
  - id: directory_list
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Specifies the directories in which the associated files are files 
      located.
    inputBinding:
      position: 102
      prefix: --listDir
  - id: force
    type:
      - 'null'
      - boolean
    doc: Ignores all warnings and continues without prompting for input from the
      user.
    inputBinding:
      position: 102
      prefix: --force
  - id: hide_progress
    type:
      - 'null'
      - boolean
    doc: Hides upload/processing progress
    inputBinding:
      position: 102
      prefix: --hideProgress
  - id: json
    type:
      - 'null'
      - boolean
    doc: Flag whether to additionally download validation results in JSON 
      format.
    inputBinding:
      position: 102
      prefix: --JSON
  - id: log_dir
    type:
      - 'null'
      - Directory
    doc: Customize the file directory of logs. If this value is not provided or 
      the provided directory does not exist, logs will be saved to 
      NDA/nda-tools/vtcmd/logs inside your root folder.
    inputBinding:
      position: 102
      prefix: --log-dir
  - id: manifest_path
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Specifies the directories in which the manifest files are located
    inputBinding:
      position: 102
      prefix: --manifestPath
  - id: replace_submission
    type:
      - 'null'
      - string
    doc: Use this argument to replace a submission that has QA errors or that 
      NDA staff has authorized manually to replace.
    inputBinding:
      position: 102
      prefix: --replace-submission
  - id: resume
    type:
      - 'null'
      - boolean
    doc: Restart an in-progress submission, resuming from the last successful 
      part in a multi-part upload. A valid Submission ID must immediately follow
      -r, i.e., vtcmd -r 12345
    inputBinding:
      position: 102
      prefix: --resume
  - id: scope
    type:
      - 'null'
      - string
    doc: Flag whether to validate using a custom scope. Must enter a custom 
      scope
    inputBinding:
      position: 102
      prefix: --scope
  - id: title
    type:
      - 'null'
      - string
    doc: The title of the submission
    inputBinding:
      position: 102
      prefix: --title
  - id: username
    type:
      - 'null'
      - string
    doc: NDA username
    inputBinding:
      position: 102
      prefix: --username
  - id: validation_timeout
    type:
      - 'null'
      - int
    doc: Timeout in seconds until the program errors out with an error. In most 
      cases the default value of 300 seconds should be sufficient to validate 
      submissions however it maybe necessary to increase this value to a 
      specific duration.
    inputBinding:
      position: 102
      prefix: --validation-timeout
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enables detailed logging.
    inputBinding:
      position: 102
      prefix: --verbose
  - id: warning
    type:
      - 'null'
      - boolean
    doc: Returns validation warnings for list of files
    inputBinding:
      position: 102
      prefix: --warning
  - id: worker_threads
    type:
      - 'null'
      - int
    doc: Number of worker threads
    inputBinding:
      position: 102
      prefix: --workerThreads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nda-tools:0.6.0--pyh7e72e81_0
stdout: nda-tools_vtcmd.out
