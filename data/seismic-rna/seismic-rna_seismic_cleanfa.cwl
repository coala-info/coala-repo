cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seismic
  - cleanfa
label: seismic-rna_seismic_cleanfa
doc: 'Clean the names and sequences in FASTA files.


  Tool homepage: https://github.com/rouskinlab/seismic-rna'
inputs:
  - id: input_path
    type:
      type: array
      items: File
    doc: Input files to process
    inputBinding:
      position: 201
  - id: inplace
    type:
      - 'null'
      - boolean
    doc: 'Modify files in-place instead of writing new files (CAUTION: you cannot
      recover the original files afterwards) [default: no-inplace]'
    inputBinding:
      position: 100
      prefix: --inplace
  - id: no_inplace
    type:
      - 'null'
      - boolean
    doc: 'Modify files in-place instead of writing new files (CAUTION: you cannot
      recover the original files afterwards) [default: no-inplace]'
    inputBinding:
      position: 100
      prefix: --no-inplace
  - id: out_dir
    type: string
    default: out
    doc: 'Write all output files to this directory [default: ./out]'
    inputBinding:
      position: 100
      prefix: --out-dir
  - id: force
    type:
      - 'null'
      - boolean
    doc: 'Force all tasks to run, overwriting any existing output files [default:
      no-force]'
    inputBinding:
      position: 100
      prefix: --force
  - id: no_force
    type:
      - 'null'
      - boolean
    doc: 'Force all tasks to run, overwriting any existing output files [default:
      no-force]'
    inputBinding:
      position: 100
      prefix: --no-force
  - id: num_cpus
    type:
      - 'null'
      - int
    doc: 'Use up to this many CPUs simultaneously [default: 20]'
    inputBinding:
      position: 100
      prefix: --num-cpus
outputs:
  - id: out_dir_result
    type: Directory
    doc: Output directory with all results
    outputBinding:
      glob: $(inputs.out_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
