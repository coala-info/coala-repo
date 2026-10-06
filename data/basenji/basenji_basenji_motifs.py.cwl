cwlVersion: v1.2
class: CommandLineTool
baseCommand: basenji_motifs.py
label: basenji_basenji_motifs.py
doc: "Analyze and visualize motifs identified by a trained Basenji model.\n\nTool
  homepage: https://github.com/calico/basenji"
inputs:
  - id: params_file
    type: File
    doc: JSON file with model hyperparameters
    inputBinding:
      position: 1
  - id: model_file
    type: File
    doc: Trained model file
    inputBinding:
      position: 2
  - id: data_dir
    type: Directory
    doc: Data directory with statistics.json and tfrecords/
    inputBinding:
      position: 3
  - id: act_t
    type:
      - 'null'
      - float
    doc: Activation threshold (as proportion of max) to consider for PWM
    inputBinding:
      position: 0
      prefix: -a
  - id: post_conv
    type:
      - 'null'
      - boolean
    doc: Embed first layer post-convolution rather than batch norm
    inputBinding:
      position: 0
      prefix: -c
  - id: plot_density
    type:
      - 'null'
      - boolean
    doc: Plot filter activation density
    inputBinding:
      position: 0
      prefix: -d
  - id: plot_heats
    type:
      - 'null'
      - boolean
    doc: Plot heat maps describing filter activations in the test sequences
    inputBinding:
      position: 0
      prefix: --heat
  - id: seq_length_crop
    type:
      - 'null'
      - int
    doc: Crop sequences to shorter length
    inputBinding:
      position: 0
      prefix: -l
  - id: meme_db
    type:
      - 'null'
      - File
    doc: MEME database used to annotate motifs
    inputBinding:
      position: 0
      prefix: -m
  - id: parallel_threads
    type:
      - 'null'
      - int
    doc: Generate weblogos in parallel threads
    inputBinding:
      position: 0
      prefix: -p
  - id: sample
    type:
      - 'null'
      - int
    doc: Sample sequences from the test set
    inputBinding:
      position: 0
      prefix: -s
  - id: trim_filters
    type:
      - 'null'
      - boolean
    doc: Trim uninformative positions off the filter ends
    inputBinding:
      position: 0
      prefix: -t
  - id: tfr_pattern
    type:
      - 'null'
      - string
    doc: TFR pattern string appended to data_dir/tfrecords for subsetting
    inputBinding:
      position: 0
      prefix: --tfr
  - id: high_var_pct
    type:
      - 'null'
      - float
    doc: Highly variable site proportion to take
    inputBinding:
      position: 0
      prefix: -v
  - id: out_dir_path
    type: string
    default: basenji_motifs
    doc: Output directory
    inputBinding:
      position: 0
      prefix: -o
outputs:
  - id: out_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.out_dir_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/basenji:0.6--pyhdfd78af_0
