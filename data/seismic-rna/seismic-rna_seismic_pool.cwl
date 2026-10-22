cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seismic
  - pool
label: seismic-rna_seismic_pool
doc: 'Merge samples (vertically) from the Relate step.


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
  - id: pooled
    type:
      - 'null'
      - string
    doc: 'Pooled sample name [default: ""]'
    inputBinding:
      position: 100
      prefix: --pooled
  - id: relate_pos_table
    type:
      - 'null'
      - boolean
    doc: ' Tabulate relationships per position for relate data [default: relate-pos-table]'
    inputBinding:
      position: 100
      prefix: --relate-pos-table
  - id: no_relate_pos_table
    type:
      - 'null'
      - boolean
    doc: ' Tabulate relationships per position for relate data [default: relate-pos-table]'
    inputBinding:
      position: 100
      prefix: --no-relate-pos-table
  - id: relate_read_table
    type:
      - 'null'
      - boolean
    doc: ' Tabulate relationships per read for relate data [default: no-relate-read-table]'
    inputBinding:
      position: 100
      prefix: --relate-read-table
  - id: no_relate_read_table
    type:
      - 'null'
      - boolean
    doc: ' Tabulate relationships per read for relate data [default: no-relate-read-table]'
    inputBinding:
      position: 100
      prefix: --no-relate-read-table
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
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_dir)
        entryname: out
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
