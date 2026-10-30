cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seismic
  - sim
  - fold
label: seismic-rna_seismic_sim_fold
doc: 'Simulate secondary structure(s) a reference sequence.


  Tool homepage: https://github.com/rouskinlab/seismic-rna'
inputs:
  - id: input_dir
    type: Directory
    doc: Output directory of the previous step(s). It is copied into the working directory
      under the name given by the output directory option (default out, or sim for
      the sim commands).
  - id: fasta
    type: string
    doc: Path of the FASTA file of reference sequences inside the staged sim directory
      (for example sim/refs/sim-refs.fa)
    inputBinding:
      position: 200
  - id: sim_dir
    type: string
    default: sim
    doc: 'Write all simulated files to this directory [default: ./sim]'
    inputBinding:
      position: 100
      prefix: --sim-dir
  - id: tmp_pfx
    type:
      - 'null'
      - string
    doc: 'Write all temporary files to a directory with this prefix [default: ./tmp]'
    inputBinding:
      position: 100
      prefix: --tmp-pfx
  - id: profile_name
    type:
      - 'null'
      - string
    doc: 'Give the simulated structure and parameters this profile name [default:
      simulated]'
    inputBinding:
      position: 100
      prefix: --profile-name
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
    doc: ' Fold a region of a reference given its 5'' and 3'' end coordinates (give
      the option once per record)'
  - id: fold_primers
    type:
      - 'null'
      - type: array
        items: fold_primers_rec
        inputBinding:
          position: 100
    doc: ' Fold a region of a reference given its forward and reverse primers (give
      the option once per record)'
  - id: fold_constraint
    type:
      - 'null'
      - File
    doc: Force bases to be paired/unpaired from a file of constraints
    inputBinding:
      position: 100
      prefix: --fold-constraint
  - id: fold_temp
    type:
      - 'null'
      - float
    doc: 'Predict structures at this temperature (Kelvin) [default: 310.15]'
    inputBinding:
      position: 100
      prefix: --fold-temp
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
    doc: Simulation directory with the input and the simulated structures
    outputBinding:
      glob: $(inputs.sim_dir)
requirements:
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
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_dir)
        entryname: $(inputs.sim_dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
