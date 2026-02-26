cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - repic
  - iter_config
label: repic_iter_config
doc: "Generates configuration files for iterative particle picking.\n\nTool homepage:
  https://github.com/ccameron/REPIC"
inputs:
  - id: data_dir
    type: Directory
    doc: path to directory containing training data
    inputBinding:
      position: 1
  - id: box_size
    type: int
    doc: particle bounding box size (in int[pixels])
    inputBinding:
      position: 2
  - id: exp_particles
    type: int
    doc: number of expected particles (int)
    inputBinding:
      position: 3
  - id: cryolo_model
    type: File
    doc: path to LOWPASS SPHIRE-crYOLO model
    inputBinding:
      position: 4
  - id: deep_dir
    type: Directory
    doc: path to DeepPicker scripts
    inputBinding:
      position: 5
  - id: topaz_scale
    type: int
    doc: Topaz scale value (int)
    inputBinding:
      position: 6
  - id: topaz_rad
    type: int
    doc: Topaz particle radius size (in int[pixels])
    inputBinding:
      position: 7
  - id: cryolo_env
    type:
      - 'null'
      - string
    doc: Conda environment name or prefix for SPHIRE-crYOLO installation
    default: cryolo
    inputBinding:
      position: 108
      prefix: --cryolo_env
  - id: deep_env
    type:
      - 'null'
      - string
    doc: Conda environment name or prefix for DeepPicker installation
    default: deep
    inputBinding:
      position: 108
      prefix: --deep_env
  - id: deep_model
    type:
      - 'null'
      - string
    doc: path to pre-trained DeepPicker model
    default: out-of-the-box model
    inputBinding:
      position: 108
      prefix: --deep_model
  - id: topaz_env
    type:
      - 'null'
      - string
    doc: Conda environment name or prefix for Topaz installation
    default: topaz
    inputBinding:
      position: 108
      prefix: --topaz_env
  - id: topaz_model
    type:
      - 'null'
      - string
    doc: path to pre-trained Topaz model
    default: out-of-the-box model
    inputBinding:
      position: 108
      prefix: --topaz_model
outputs:
  - id: out_file_path
    type:
      - 'null'
      - File
    doc: path for created config file
    outputBinding:
      glob: $(inputs.out_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/repic:1.0.0--pyhdfd78af_0
