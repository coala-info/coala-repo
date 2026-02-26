cwlVersion: v1.2
class: CommandLineTool
baseCommand: java -jar webin-cli-9.0.3.jar
label: ena-webin-cli
doc: "Validate and submit files to ENA using the Webin submission service. Use the
  -fields option to see supported manifest fields for all contexts or for a specific
  -context. Detailed instructions are available from: https://ena-docs.readthedocs.io/en/latest/cli.html\n\
  \nTool homepage: https://github.com/enasequence/webin-cli"
inputs:
  - id: ascp
    type:
      - 'null'
      - boolean
    doc: Use Aspera (if Aspera Cli is available) instead of FTP when uploading 
      files. The path to the installed "ascp" program must be in the PATH 
      variable.
    inputBinding:
      position: 101
      prefix: --ascp
  - id: center_name
    type: string
    doc: Mandatory center name for broker accounts.
    inputBinding:
      position: 101
      prefix: --centerName
  - id: context
    type: string
    doc: 'Submission type: genome, transcriptome, sequence, polysample, reads, taxrefset'
    inputBinding:
      position: 101
      prefix: --context
  - id: fields
    type:
      - 'null'
      - boolean
    doc: Show manifest fields for all contexts or for the given -context.
    inputBinding:
      position: 101
      prefix: --fields
  - id: input_dir
    type:
      - 'null'
      - Directory
    doc: Root directory for the files declared in the manifest file. By default 
      the current working directory is used as the input directory.
    default: current working directory
    inputBinding:
      position: 101
      prefix: --inputDir
  - id: manifest
    type: File
    doc: Manifest text file containing file and metadata fields.
    inputBinding:
      position: 101
      prefix: --manifest
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Root directory for any output files written in 
      <context>/<name>/<validate,process,submit> directory structure. By default
      the manifest file directory is used as the output directory. The <name> is
      the unique name from the manifest file. The validation reports are written
      in the <validate> sub-directory.
    default: manifest file directory
    inputBinding:
      position: 101
      prefix: --outputDir
  - id: password
    type:
      - 'null'
      - string
    doc: Webin submission account password.
    inputBinding:
      position: 101
      prefix: --password
  - id: password_env
    type:
      - 'null'
      - string
    doc: Environment variable containing the Webin submission account password.
    inputBinding:
      position: 101
      prefix: --passwordEnv
  - id: password_file
    type:
      - 'null'
      - File
    doc: File containing the Webin submission account password.
    inputBinding:
      position: 101
      prefix: --passwordFile
  - id: sample_update
    type:
      - 'null'
      - boolean
    doc: Update the submitted sample if it already exists.
    inputBinding:
      position: 101
      prefix: --sampleUpdate
  - id: submit
    type:
      - 'null'
      - boolean
    doc: Validate, upload and submit files.
    inputBinding:
      position: 101
      prefix: --submit
  - id: test
    type:
      - 'null'
      - boolean
    doc: Use the test submission service.
    inputBinding:
      position: 101
      prefix: --test
  - id: user_name
    type:
      - 'null'
      - string
    doc: Webin submission account name or e-mail address.
    inputBinding:
      position: 101
      prefix: --userName
  - id: validate
    type:
      - 'null'
      - boolean
    doc: Validate files without uploading or submitting them.
    inputBinding:
      position: 101
      prefix: --validate
  - id: validate_files
    type:
      - 'null'
      - boolean
    doc: All manifest fields become optional to allow read file validation 
      without having to provide metadata.
    inputBinding:
      position: 101
      prefix: --validateFiles
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ena-webin-cli:9.0.3--hdfd78af_0
stdout: ena-webin-cli.out
