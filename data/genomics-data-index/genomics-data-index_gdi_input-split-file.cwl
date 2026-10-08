cwlVersion: v1.2
class: CommandLineTool
baseCommand: gdi
label: genomics-data-index_gdi_input-split-file
doc: "Split multi-sequence FASTA files into one file per sequence and write a table of samples and files.\n\nThe tool needs a project folder made by \"gdi init\". It is passed as project_dir.\n\nTool homepage: https://github.com/apetkau/genomics-data-index"
arguments:
  - position: 3
    valueFrom: input-split-file
inputs:
  - id: absolute
    type:
      - 'null'
      - boolean
    doc: "Convert paths to absolute paths"
    inputBinding:
      position: 10
      prefix: --absolute
  - id: no_absolute
    type:
      - 'null'
      - boolean
    doc: "Keep relative paths (default)"
    inputBinding:
      position: 11
      prefix: --no-absolute
  - id: output_dir
    type: string
    doc: "The directory where individual output sequence files should be written into"
    inputBinding:
      position: 12
      prefix: --output-dir
  - id: output_samples_file
    type:
      - 'null'
      - string
    doc: "The file listing all the samples and linking them back to the individual sequence files (default: standard output)"
    inputBinding:
      position: 13
      prefix: --output-samples-file
  - id: subsample_file
    type:
      - 'null'
      - File
    doc: "Subsample the input files to contain only the samples listed in this file (one sample per line)"
    inputBinding:
      position: 14
      prefix: --subsample-file
  - id: subsample
    type:
      - 'null'
      - float
    doc: "Subsample the input files: a number of samples if >= 1, or a proportion if < 1"
    inputBinding:
      position: 15
      prefix: --subsample
  - id: seed
    type:
      - 'null'
      - int
    doc: "Seed for random number generator when subsampling"
    inputBinding:
      position: 16
      prefix: --seed
  - id: input_files
    type:
      type: array
      items: File
    doc: "Input sequence files"
    inputBinding:
      position: 100
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output"
  - id: output_dir_out
    type:
      - 'null'
      - Directory
    doc: "Folder with the split sequence files"
    outputBinding:
      glob: $(inputs.output_dir)
  - id: output_samples_file_out
    type:
      - 'null'
      - File
    doc: "Table of samples and files"
    outputBinding:
      glob: $(inputs.output_samples_file)
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: USER
        envValue: gdi
      - envName: QT_QPA_PLATFORM
        envValue: offscreen
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomics-data-index:0.9.2--pyhdfd78af_0
stdout: genomics-data-index_gdi_input-split-file.out
