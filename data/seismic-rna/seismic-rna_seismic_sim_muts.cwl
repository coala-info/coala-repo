cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seismic
  - sim
  - muts
label: seismic-rna_seismic_sim_muts
doc: 'Simulate the rate of each kind of mutation at each position.


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
  - id: pmut_paired
    type:
      - 'null'
      - type: array
        items: pmut_paired_rec
        inputBinding:
          position: 100
    doc: ' Set the mean rate of each kind of mutation for paired bases (give the option
      once per record)'
  - id: pmut_unpaired
    type:
      - 'null'
      - type: array
        items: pmut_unpaired_rec
        inputBinding:
          position: 100
    doc: ' Set the mean rate of each kind of mutation for unpaired bases (give the
      option once per record)'
  - id: vmut_paired
    type:
      - 'null'
      - float
    doc: 'Set the relative variance of mutation rates of paired bases [default: 0.001]'
    inputBinding:
      position: 100
      prefix: --vmut-paired
  - id: vmut_unpaired
    type:
      - 'null'
      - float
    doc: 'Set the relative variance of mutation rates of unpaired bases [default:
      0.02]'
    inputBinding:
      position: 100
      prefix: --vmut-unpaired
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
  - class: SchemaDefRequirement
    types:
      - name: pmut_paired_rec
        type: record
        fields:
          - name: mutation_type
            type: string
            inputBinding:
              position: 1
              prefix: --pmut-paired
          - name: rate
            type: float
            inputBinding:
              position: 2
      - name: pmut_unpaired_rec
        type: record
        fields:
          - name: mutation_type
            type: string
            inputBinding:
              position: 1
              prefix: --pmut-unpaired
          - name: rate
            type: float
            inputBinding:
              position: 2
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_dir)
        entryname: sim
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
