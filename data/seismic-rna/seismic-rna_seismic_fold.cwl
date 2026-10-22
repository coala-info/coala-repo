cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seismic
  - fold
label: seismic-rna_seismic_fold
doc: 'Predict RNA secondary structures using mutation rates.


  Tool homepage: https://github.com/rouskinlab/seismic-rna'
inputs:
  - id: input_dir
    type: Directory
    doc: Output directory of the previous step. It is copied into the working directory
      as the output directory (named by --out-dir, default out)
  - id: input_path
    type:
      - 'null'
      - type: array
        items: string
    default:
      - out
    doc: Files or directories inside the output directory to process (paths start
      with the output directory name)
    inputBinding:
      position: 201
  - id: branch
    type:
      - 'null'
      - string
    doc: 'Create a new branch of the workflow with this name [default: ""]'
    inputBinding:
      position: 100
      prefix: --branch
  - id: fold_regions_file
    type:
      - 'null'
      - File
    doc: Fold regions of references from coordinates/primers in a CSV file
    inputBinding:
      position: 100
      prefix: --fold-regions-file
  - id: fold_coords
    type:
      - 'null'
      - type: array
        items: fold_coords_rec
        inputBinding:
          position: 100
    doc: ' Fold a region of a reference given its 5'' and 3'' end coordinates'
  - id: fold_primers
    type:
      - 'null'
      - type: array
        items: fold_primers_rec
        inputBinding:
          position: 100
    doc: ' Fold a region of a reference given its forward and reverse primers'
  - id: fold_full
    type:
      - 'null'
      - boolean
    doc: 'If no regions are specified, whether to default to the full region or to
      the table''s region [default: fold-full]'
    inputBinding:
      position: 100
      prefix: --fold-full
  - id: fold_table
    type:
      - 'null'
      - boolean
    doc: 'If no regions are specified, whether to default to the full region or to
      the table''s region [default: fold-full]'
    inputBinding:
      position: 100
      prefix: --fold-table
  - id: quantile
    type:
      - 'null'
      - float
    doc: 'Normalize and winsorize ratios to this quantile (0.0 disables) [default:
      0.0]'
    inputBinding:
      position: 100
      prefix: --quantile
  - id: fold_temp
    type:
      - 'null'
      - float
    doc: 'Predict structures at this temperature (Kelvin) [default: 310.15]'
    inputBinding:
      position: 100
      prefix: --fold-temp
  - id: fold_constraint
    type:
      - 'null'
      - File
    doc: Force bases to be paired/unpaired from a file of constraints
    inputBinding:
      position: 100
      prefix: --fold-constraint
  - id: fold_md
    type:
      - 'null'
      - int
    doc: 'Limit base pair distances to this number of bases (0 for no limit) [default:
      0]'
    inputBinding:
      position: 100
      prefix: --fold-md
  - id: fold_mfe
    type:
      - 'null'
      - boolean
    doc: 'Predict only the minimum free energy (MFE) structure [default: fold-sub]'
    inputBinding:
      position: 100
      prefix: --fold-mfe
  - id: fold_sub
    type:
      - 'null'
      - boolean
    doc: 'Predict only the minimum free energy (MFE) structure [default: fold-sub]'
    inputBinding:
      position: 100
      prefix: --fold-sub
  - id: fold_max
    type:
      - 'null'
      - int
    doc: 'Output at most this many structures (overriden by --fold-mfe) [default:
      20]'
    inputBinding:
      position: 100
      prefix: --fold-max
  - id: fold_percent
    type:
      - 'null'
      - float
    doc: 'Stop outputting structures when the % difference in energy exceeds this
      value (overriden by --fold-mfe) [default: 20.0]'
    inputBinding:
      position: 100
      prefix: --fold-percent
  - id: tmp_pfx
    type:
      - 'null'
      - string
    doc: 'Write all temporary files to a directory with this prefix [default: ./tmp]'
    inputBinding:
      position: 100
      prefix: --tmp-pfx
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: 'Keep temporary files after finishing [default: erase-tmp]'
    inputBinding:
      position: 100
      prefix: --keep-tmp
  - id: erase_tmp
    type:
      - 'null'
      - boolean
    doc: 'Keep temporary files after finishing [default: erase-tmp]'
    inputBinding:
      position: 100
      prefix: --erase-tmp
  - id: verify_times
    type:
      - 'null'
      - boolean
    doc: ' Verify that report files from later steps have later timestamps [default:
      verify- times]'
    inputBinding:
      position: 100
      prefix: --verify-times
  - id: no_verify_times
    type:
      - 'null'
      - boolean
    doc: ' Verify that report files from later steps have later timestamps [default:
      verify- times]'
    inputBinding:
      position: 100
      prefix: --no-verify-times
  - id: num_cpus
    type:
      - 'null'
      - int
    doc: 'Use up to this many CPUs simultaneously [default: 20]'
    inputBinding:
      position: 100
      prefix: --num-cpus
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
outputs:
  - id: out_dir_result
    type: Directory
    doc: Output directory with all results
    outputBinding:
      glob: out
requirements:
  - class: InlineJavascriptRequirement
  - class: SchemaDefRequirement
    types:
      - name: fold_coords_rec
        type: record
        fields:
          - name: reference
            type: string
            inputBinding:
              position: 1
              prefix: --fold-coords
          - name: end5
            type: int
            inputBinding:
              position: 2
          - name: end3
            type: int
            inputBinding:
              position: 3
      - name: fold_primers_rec
        type: record
        fields:
          - name: reference
            type: string
            inputBinding:
              position: 1
              prefix: --fold-primers
          - name: forward_primer
            type: string
            inputBinding:
              position: 2
          - name: reverse_primer
            type: string
            inputBinding:
              position: 3
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_dir)
        entryname: out
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
