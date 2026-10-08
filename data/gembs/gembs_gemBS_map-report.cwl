cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gemBS
  - map-report
label: gembs_gemBS_map-report
doc: "Bisulfite mapping report generation. Builds an HTML and a SPHINX report per dataset and sample.\n\nTool homepage: https://github.com/heathsc/gemBS"
inputs:
  - id: project_dirs
    type:
      type: array
      items: Directory
    doc: "Project directories made by earlier gemBS steps (.gemBS, index, mapping, calls), staged writable in the working directory"
  - id: project_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Project files named in the configuration, such as the reference FASTA and the FASTQ files, staged in the working directory"
  - id: project
    type:
      - 'null'
      - string
    doc: "Output title for report (project name)"
    inputBinding:
      position: 101
      prefix: --project
  - id: output_dir
    type:
      - 'null'
      - string
    doc: "Output directory to store the HTML mapping report"
    inputBinding:
      position: 101
      prefix: --output-dir
outputs:
  - id: gemBS_state
    type:
      - 'null'
      - Directory
    doc: The .gemBS project directory (database and JSON file), updated by this step
    outputBinding:
      glob: .gemBS
  - id: report_dir
    type:
      - 'null'
      - Directory
    doc: The report directory
    outputBinding:
      glob: report
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Directory written with --output-dir
    outputBinding:
      glob: $(inputs.output_dir)
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
