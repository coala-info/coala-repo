cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seismic
  - join
label: seismic-rna_seismic_join
doc: 'Merge regions (horizontally) from the Mask or Cluster step.


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
  - id: joined
    type:
      - 'null'
      - string
    doc: 'Name of the region formed by joining other regions [default: ""]'
    inputBinding:
      position: 100
      prefix: --joined
  - id: join_clusts
    type:
      - 'null'
      - File
    doc: Specify which clusters to join clusters using this CSV file
    inputBinding:
      position: 100
      prefix: --join-clusts
  - id: mask_pos_table
    type:
      - 'null'
      - boolean
    doc: ' Tabulate relationships per position for mask data [default: mask-pos-table]'
    inputBinding:
      position: 100
      prefix: --mask-pos-table
  - id: no_mask_pos_table
    type:
      - 'null'
      - boolean
    doc: ' Tabulate relationships per position for mask data [default: mask-pos-table]'
    inputBinding:
      position: 100
      prefix: --no-mask-pos-table
  - id: mask_read_table
    type:
      - 'null'
      - boolean
    doc: ' Tabulate relationships per read for mask data [default: mask-read-table]'
    inputBinding:
      position: 100
      prefix: --mask-read-table
  - id: no_mask_read_table
    type:
      - 'null'
      - boolean
    doc: ' Tabulate relationships per read for mask data [default: mask-read-table]'
    inputBinding:
      position: 100
      prefix: --no-mask-read-table
  - id: cluster_pos_table
    type:
      - 'null'
      - boolean
    doc: ' Tabulate relationships per position for cluster data [default: cluster-pos-table]'
    inputBinding:
      position: 100
      prefix: --cluster-pos-table
  - id: no_cluster_pos_table
    type:
      - 'null'
      - boolean
    doc: ' Tabulate relationships per position for cluster data [default: cluster-pos-table]'
    inputBinding:
      position: 100
      prefix: --no-cluster-pos-table
  - id: cluster_abundance_table
    type:
      - 'null'
      - boolean
    doc: ' Tabulate number of reads per cluster for cluster data [default: cluster-abundance-
      table]'
    inputBinding:
      position: 100
      prefix: --cluster-abundance-table
  - id: no_cluster_abundance_table
    type:
      - 'null'
      - boolean
    doc: ' Tabulate number of reads per cluster for cluster data [default: cluster-abundance-
      table]'
    inputBinding:
      position: 100
      prefix: --no-cluster-abundance-table
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
