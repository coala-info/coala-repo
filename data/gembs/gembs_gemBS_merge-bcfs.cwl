cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gemBS
  - merge-bcfs
label: gembs_gemBS_merge-bcfs
doc: "Merges the BCF files of the contig pools of a gemBS project, or of one sample, into one BCF per sample, then indexes it and calculates its MD5 sum.\n\nTool homepage: https://github.com/heathsc/gemBS"
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
  - id: sample_name
    type:
      - 'null'
      - string
    doc: "Name of sample to be merged"
    inputBinding:
      position: 101
      prefix: --sample-name
  - id: sample_barcode
    type:
      - 'null'
      - string
    doc: "Barcode of sample to be merged"
    inputBinding:
      position: 101
      prefix: --sample-barcode
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads"
    inputBinding:
      position: 101
      prefix: --threads
  - id: merge_threads
    type:
      - 'null'
      - int
    doc: "Number of threads for merge step"
    inputBinding:
      position: 101
      prefix: --merge-threads
  - id: remove
    type:
      - 'null'
      - boolean
    doc: "Remove individual BCF files after merging."
    inputBinding:
      position: 101
      prefix: --remove
  - id: jobs
    type:
      - 'null'
      - int
    doc: "Number of parallel jobs"
    inputBinding:
      position: 101
      prefix: --jobs
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: "Output mapping commands without execution"
    inputBinding:
      position: 101
      prefix: --dry-run
  - id: json_file
    type:
      - 'null'
      - string
    doc: "Output JSON file with details of pending commands"
    inputBinding:
      position: 101
      prefix: --json
  - id: ignore_db
    type:
      - 'null'
      - boolean
    doc: "Ignore database for --dry-run and --json commands"
    inputBinding:
      position: 101
      prefix: --ignore-db
  - id: ignore_dep
    type:
      - 'null'
      - boolean
    doc: "Ignore dependencies for --dry-run and --json commands"
    inputBinding:
      position: 101
      prefix: --ignore-dep
  - id: benchmark_mode
    type:
      - 'null'
      - boolean
    doc: "Omit dates etc. to make file comparison simpler"
    inputBinding:
      position: 101
      prefix: --benchmark-mode
outputs:
  - id: gemBS_state
    type:
      - 'null'
      - Directory
    doc: The .gemBS project directory (database and JSON file), updated by this step
    outputBinding:
      glob: .gemBS
  - id: calls_dir
    type:
      - 'null'
      - Directory
    doc: The calls directory with the merged BCF files
    outputBinding:
      glob: calls
  - id: json_output
    type:
      - 'null'
      - File
    doc: JSON file written with --json
    outputBinding:
      glob: $(inputs.json_file)
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
