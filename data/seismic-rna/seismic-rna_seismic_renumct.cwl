cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seismic
  - renumct
label: seismic-rna_seismic_renumct
doc: 'Renumber connectivity table (CT) files given a 5'' position.


  Tool homepage: https://github.com/rouskinlab/seismic-rna'
inputs:
  - id: input_dir
    type: Directory
    doc: Output directory of the previous step(s). It is copied into the working directory
      under the name given by the output directory option (default out, or sim for
      the sim commands).
  - id: ct_pos_5
    type:
      - 'null'
      - type: array
        items: ct_pos_5_rec
        inputBinding:
          position: 100
    doc: ' Connectivity table (CT) file or directory of CT files and the 5'' position
      to assign to each file (give the option once per record)'
  - id: inplace
    type:
      - 'null'
      - boolean
    doc: 'Modify files in-place instead of writing new files (CAUTION: you cannot
      recover the original files afterwards) [default: no- inplace]'
    inputBinding:
      position: 100
      prefix: --inplace
  - id: no_inplace
    type:
      - 'null'
      - boolean
    doc: 'Modify files in-place instead of writing new files (CAUTION: you cannot
      recover the original files afterwards) [default: no- inplace]'
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
  - class: SchemaDefRequirement
    types:
      - name: ct_pos_5_rec
        type: record
        fields:
          - name: ct_file
            type: string
            inputBinding:
              position: 1
              prefix: --ct-pos-5
          - name: pos5
            type: int
            inputBinding:
              position: 2
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_dir)
        entryname: $(inputs.out_dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
