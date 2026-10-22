cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seismic
  - export
label: seismic-rna_seismic_export
doc: 'Export each sample to SEISMICgraph (https://seismicrna.org).


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
  - id: samples_meta
    type:
      - 'null'
      - File
    doc: Add sample metadata from this CSV file to exported results
    inputBinding:
      position: 100
      prefix: --samples-meta
  - id: refs_meta
    type:
      - 'null'
      - File
    doc: Add reference metadata from this CSV file to exported results
    inputBinding:
      position: 100
      prefix: --refs-meta
  - id: all_pos
    type:
      - 'null'
      - boolean
    doc: 'Export all positions (not just unmasked positions) [default: all-pos]'
    inputBinding:
      position: 100
      prefix: --all-pos
  - id: unmasked_pos
    type:
      - 'null'
      - boolean
    doc: 'Export all positions (not just unmasked positions) [default: all-pos]'
    inputBinding:
      position: 100
      prefix: --unmasked-pos
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
