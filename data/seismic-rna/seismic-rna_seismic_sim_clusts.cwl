cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seismic
  - sim
  - clusts
label: seismic-rna_seismic_sim_clusts
doc: 'Simulate the proportions of 5'' and 3'' end coordinates.


  Tool homepage: https://github.com/rouskinlab/seismic-rna'
inputs:
  - id: input_dir
    type: Directory
    doc: Output directory of the previous step(s). It is copied into the working directory
      under the name given by the output directory option (default out, or sim for
      the sim commands).
  - id: ct_file
    type:
      - 'null'
      - string
    doc: Simulate parameters using the structure(s) in this CT file (path inside the
      staged sim directory, for example sim/params/<ref>/<region>/<profile>.ct)
    inputBinding:
      position: 100
      prefix: --ct-file
  - id: clust_conc
    type:
      - 'null'
      - float
    doc: 'Set the concentration parameter for simulating cluster proportions [default:
      0.0]'
    inputBinding:
      position: 100
      prefix: --clust-conc
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
  - id: sim_dir_result
    type: Directory
    doc: Simulation directory with the input and the new files
    outputBinding:
      glob: sim
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_dir)
        entryname: sim
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
