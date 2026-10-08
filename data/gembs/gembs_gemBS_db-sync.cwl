cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gemBS
  - db-sync
label: gembs_gemBS_db-sync
doc: "Synchronize database with filesystem\n\nTool homepage: https://github.com/heathsc/gemBS"
inputs:
  - id: confirm
    type:
      - 'null'
      - boolean
    doc: Confirm operation
    inputBinding:
      position: 101
      prefix: --yes
  - id: project_dirs
    type:
      type: array
      items: Directory
    doc: Project directories made by earlier gemBS steps (.gemBS, index, mapping, calls), staged writable in the working directory
  - id: project_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Project files named in the configuration, such as the reference FASTA and the FASTQ files, staged in the working directory
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: gemBS_state
    type:
      - 'null'
      - Directory
    doc: The .gemBS project directory (database and JSON file), updated by this step
    outputBinding:
      glob: .gemBS
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.project_dirs)
        writable: true
      - entry: '$(inputs.project_files ? inputs.project_files : [])'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gembs:3.5.5_IHEC--py39h6859054_8
stdout: gembs_gemBS_db-sync.out