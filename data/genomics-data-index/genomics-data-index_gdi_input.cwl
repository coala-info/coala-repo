cwlVersion: v1.2
class: CommandLineTool
baseCommand: gdi
label: genomics-data-index_gdi_input
doc: "Write a table of samples and genome files (assembly or reads) for use with gdi analysis.\n\nThe tool needs a project folder made by \"gdi init\". It is passed as project_dir.\n\nTool homepage: https://github.com/apetkau/genomics-data-index"
arguments:
  - position: 3
    valueFrom: input
inputs:
  - id: project_dir
    type: Directory
    doc: "project folder made by gdi init (global option --project-dir)"
    inputBinding:
      position: 1
      prefix: --project-dir
      valueFrom: $(self.basename)
  - id: ncores
    type:
      - 'null'
      - int
    doc: "Number of cores for any parallel processing"
    inputBinding:
      position: 1
      prefix: --ncores
  - id: log_level
    type:
      - 'null'
      - string
    doc: "Sets the log level (TRACE, DEBUG, INFO, WARNING, ERROR, CRITICAL)"
    inputBinding:
      position: 1
      prefix: --log-level
  - id: skip_existing_samples
    type:
      - 'null'
      - boolean
    doc: "Skip samples that already exist in the index (default)"
    inputBinding:
      position: 10
      prefix: --skip-existing-samples
  - id: no_skip_existing_samples
    type:
      - 'null'
      - boolean
    doc: "Do not skip existing samples"
    inputBinding:
      position: 11
      prefix: --no-skip-existing-samples
  - id: absolute
    type:
      - 'null'
      - boolean
    doc: "Convert paths to absolute paths"
    inputBinding:
      position: 12
      prefix: --absolute
  - id: no_absolute
    type:
      - 'null'
      - boolean
    doc: "Keep relative paths (default)"
    inputBinding:
      position: 13
      prefix: --no-absolute
  - id: input_genomes_file
    type:
      - 'null'
      - File
    doc: "A file listing the genomes to process, one per line"
    inputBinding:
      position: 14
      prefix: --input-genomes-file
  - id: check_files_exist
    type:
      - 'null'
      - boolean
    doc: "Check that the files in the input genomes file exist (default)"
    inputBinding:
      position: 15
      prefix: --check-files-exist
  - id: no_check_files_exist
    type:
      - 'null'
      - boolean
    doc: "Do not check that files exist"
    inputBinding:
      position: 16
      prefix: --no-check-files-exist
  - id: genomes
    type:
      - 'null'
      - type: array
        items: File
    doc: "Genome files (assemblies or reads)"
    inputBinding:
      position: 100
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: USER
        envValue: gdi
      - envName: QT_QPA_PLATFORM
        envValue: offscreen
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [{"entry": inputs.project_dir, "writable": true}];
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomics-data-index:0.9.2--pyhdfd78af_0
stdout: genomics-data-index_gdi_input.out
