cwlVersion: v1.2
class: CommandLineTool
baseCommand: PReFerSim
label: prefersim_PReFerSim
doc: "General usage of the program: GSL_RNG_SEED=<seed> GSL_RNG_TYPE=mrg PReFerSim\n\
  <parameter file> <replicate number>. PReFerSim simulates allele frequency trajectories\n\
  under a Wright-Fisher model with selection and a demographic history.\n\nTool homepage:\
  \ https://github.com/LohmuellerLab/PReFerSim"
inputs:
  - id: parameter_file
    type: File
    doc: Parameter file
    inputBinding:
      position: 1
  - id: replicate_number
    type: int
    doc: Replicate number
    inputBinding:
      position: 2
  - id: random_seed
    type: int
    default: 1
    doc: Random seed, passed in the GSL_RNG_SEED environment variable
  - id: support_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files named inside the parameter file (demographic history, allele list,
      selection file); staged in the working directory so the names resolve
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_files
    type:
      type: array
      items: File
    doc: Output files written with the FilePrefix of the parameter file (the prefix
      must not contain a directory)
    outputBinding:
      glob: '*_out.txt'
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: GSL_RNG_SEED
        envValue: "$(String(inputs.random_seed))"
      - envName: GSL_RNG_TYPE
        envValue: mrg
  - class: InitialWorkDirRequirement
    listing: "$(inputs.support_files ? inputs.support_files : [])"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prefersim:1.0--h940b034_4
stdout: prefersim_PReFerSim.out
