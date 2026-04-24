cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - panorama
  - utils
label: panorama_utils
doc: "Create input files used by PANORAMA\n\nTool homepage: https://github.com/labgem/panorama"
inputs:
  - id: binary
    type:
      - 'null'
      - boolean
    doc: Flag to rewrite the HMM in binary mode. Useful to speed up annotation
    inputBinding:
      position: 101
      prefix: --binary
  - id: coverage
    type:
      - 'null'
      - type: array
        items: string
    doc: Set the coverage threshold for the hmm and the target. The same 
      threshold will be used for all HMM and target. It's Not recommended for 
      PADLOC. For defense finder and macsy finder see --hmm_coverage.
    inputBinding:
      position: 101
      prefix: --coverage
  - id: disable_prog_bar
    type:
      - 'null'
      - boolean
    doc: disables the progress bars
    inputBinding:
      position: 101
      prefix: --disable_prog_bar
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force writing in output directory and in pangenome output file.
    inputBinding:
      position: 101
      prefix: --force
  - id: hmm
    type:
      - 'null'
      - type: array
        items: File
    doc: Path to HMM files or directory containing HMM
    inputBinding:
      position: 101
      prefix: --hmm
  - id: hmm_coverage
    type:
      - 'null'
      - string
    doc: Set the coverage threshold on the hmm. The same threshold will be used 
      for all HMM. It's Not recommended for PADLOC. For defense finders it's 
      correspond to --coverage arguments.For macsyfinder it's correspond to 
      --coverage-profile.
    inputBinding:
      position: 101
      prefix: --hmm_coverage
  - id: log
    type:
      - 'null'
      - File
    doc: log output file
    inputBinding:
      position: 101
      prefix: --log
  - id: meta
    type:
      - 'null'
      - string
    doc: Path to metadata file to add some to list file
    inputBinding:
      position: 101
      prefix: --meta
  - id: models
    type:
      - 'null'
      - type: array
        items: string
    doc: Create a models_list.tsv file from the given models and check them.
    inputBinding:
      position: 101
      prefix: --models
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Flag to indicate if directories should be read recursively
    inputBinding:
      position: 101
      prefix: --recursive
  - id: source
    type:
      - 'null'
      - string
    doc: Available sources that we know how to translate.The directory will be 
      read recursively to catch all models.
    inputBinding:
      position: 101
      prefix: --source
  - id: target_coverage
    type:
      - 'null'
      - string
    doc: Set the coverage threshold on the target. The same threshold will be 
      used for all target. It's Not recommended for PADLOC, defensefinder or 
      macsyfinder.
    inputBinding:
      position: 101
      prefix: --target_coverage
  - id: translate
    type:
      - 'null'
      - string
    doc: Path to models to be translated. Give the directory with models, hmms 
      and other files.PANORAMA will take care of everything it needs to 
      translate.
    inputBinding:
      position: 101
      prefix: --translate
  - id: verbose
    type:
      - 'null'
      - int
    doc: Indicate verbose level (0 for warning and errors only, 1 for info, 2 
      for debug)
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Path to output directory.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panorama:1.0.0--pyhdfd78af_0
