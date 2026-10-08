cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gemBS
  - merge-bams
label: gembs_gemBS_merge-bams
doc: "Merges all BAM alignments of a gemBS project, or of one sample, into one BAM per sample, then indexes the BAM and calculates its MD5 sum.\n\nTool homepage: https://github.com/heathsc/gemBS"
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
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads, default 1"
    inputBinding:
      position: 101
      prefix: --threads
  - id: sample_name
    type:
      - 'null'
      - string
    doc: "Sample to be merged"
    inputBinding:
      position: 101
      prefix: --sample_name
  - id: barcode
    type:
      - 'null'
      - string
    doc: "Sample to be merged, by barcode"
    inputBinding:
      position: 101
      prefix: --barcode
  - id: remove
    type:
      - 'null'
      - boolean
    doc: "Remove individual BAM files after merging."
    inputBinding:
      position: 101
      prefix: --remove
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
  - id: mapping_dir
    type:
      - 'null'
      - Directory
    doc: The mapping directory with the merged BAM files
    outputBinding:
      glob: mapping
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
