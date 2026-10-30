cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seismic
  - sim
  - abstract
label: seismic-rna_seismic_sim_abstract
doc: 'Abstract simulation parameters from existing datasets.


  Tool homepage: https://github.com/rouskinlab/seismic-rna'
inputs:
  - id: input_dir
    type: Directory
    doc: Output directory of the previous step(s). It is copied into the working directory
      under the name given by the output directory option (default out, or sim for
      the sim commands).
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
  - id: struct_file
    type:
      - 'null'
      - string
    doc: Compare mutational profiles to the structure(s) in this CT file (path of
      the CT file inside the staged output directory, for example out/<sample>/fold/<ref>/<region>/<profile>.ct)
    inputBinding:
      position: 100
      prefix: --struct-file
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
outputs:
  - id: out_dir_result
    type: Directory
    doc: Output directory with all results
    outputBinding:
      glob: out
  - id: abstracted_parameters
    type: stdout
    doc: Abstracted simulation parameters printed as seismic sim options
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_dir)
        entryname: out
        writable: true
stdout: abstracted_parameters.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
