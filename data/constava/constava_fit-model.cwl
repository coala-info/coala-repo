cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - constava
  - fit-model
label: constava_fit-model
doc: "The `constava fit-model` submodule is used to generate the probabilistic conformational
  state models used in the analysis. By default, when running `constava analyze` these
  models are generated on-the-fly. In selected cases generating a model beforehand
  and loading it can be useful, though.\n\nWe provide two model types. kde-Models
  are the default. They are fast to fit but may be slow in the inference in large
  conformational ensembles (e.g., long-timescale MD simulations). The idea of grid-Models
  is, to replace the continuous probability density function of the kde-Model by a
  fixed set of grid-points. The PDF for any sample is then estimated by linear interpolation
  between the nearest grid points. This is slightly less accurate than the kde-Model
  but speeds up inference significantly.\n\nTool homepage: https://github.com/bio2byte/constava"
inputs:
  - id: degrees
    type:
      - 'null'
      - boolean
    doc: Set this flag, if dihedrals in `model-data` are in degrees instead of 
      radians.
    inputBinding:
      position: 101
      prefix: --degrees
  - id: grid_points
    type:
      - 'null'
      - int
    doc: This flag controls how many grid points are used to describe the 
      probability density function. Only applies if `--model-type` is set to 
      `grid`.
    default: 10000
    inputBinding:
      position: 101
      prefix: --grid-points
  - id: input_file
    type:
      - 'null'
      - File
    doc: The data to which the new conformational state models will be fitted. 
      It should be provided as a JSON file. The top-most key should indicate the
      names of the conformational states. On the level below, lists of phi-/ psi
      pairs for each stat should be provided. If not provided the default data 
      from the publication will be used.
    inputBinding:
      position: 101
      prefix: --input
  - id: kde_bandwidth
    type:
      - 'null'
      - float
    doc: This flag controls the bandwidth of the Gaussian kernel density 
      estimator.
    default: 0.13
    inputBinding:
      position: 101
      prefix: --kde-bandwidth
  - id: model_type
    type:
      - 'null'
      - string
    doc: "The probabilistic conformational state model used. The default is `kde`.
      The alternative `grid` runs significantly faster while slightly sacrificing
      accuracy: {'kde', 'grid'}"
    default: kde
    inputBinding:
      position: 101
      prefix: --model-type
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Set verbosity level of screen output. Flag can be given multiple times 
      (up to 2) to gradually increase output to debugging mode.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_file
    type: File
    doc: Write the generated model to a pickled file, that can be loaded gain 
      using `constava analyze --load-model`
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/constava:1.2.0--pyhdfd78af_0
