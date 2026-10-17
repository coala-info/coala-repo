cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pycistopic
  - topic_modeling
  - mallet
label: pycistopic_topic_modeling_mallet
doc: "Run LDA topic modeling with Mallet.\n\nTool homepage: https://github.com/aertslab/pycisTopic"
inputs:
  - id: input
    type: File
    doc: "cisTopic object pickle input filename."
    inputBinding:
      position: 1
      prefix: -i
  - id: output
    type: string
    doc: "Topic model list pickle output filename."
    inputBinding:
      position: 1
      prefix: -o
  - id: topics
    type:
      type: array
      items: int
    doc: Number(s) of topics to create during topic modeling.
    inputBinding:
      position: 1
      prefix: -t
  - id: parallel
    type: int
    doc: "Number of threads Mallet is allowed to use."
    inputBinding:
      position: 1
      prefix: -p
  - id: iterations
    type:
      - 'null'
      - int
    doc: "Number of iterations. Default: 500."
    inputBinding:
      position: 1
      prefix: -n
  - id: alpha
    type:
      - 'null'
      - float
    doc: "Alpha value. Default: 50."
    inputBinding:
      position: 1
      prefix: -a
  - id: alpha_by_topic
    type:
      - 'null'
      - string
    doc: "Whether the alpha value should by divided by the number of topics (True or False). Default: True."
    inputBinding:
      position: 1
      prefix: -A
  - id: eta
    type:
      - 'null'
      - float
    doc: "Eta value. Default: 0.1."
    inputBinding:
      position: 1
      prefix: -e
  - id: eta_by_topic
    type:
      - 'null'
      - string
    doc: "Whether the eta value should by divided by the number of topics (True or False). Default: False."
    inputBinding:
      position: 1
      prefix: -E
  - id: keep
    type:
      - 'null'
      - string
    doc: "Whether intermediate topic models should be kept (True or False). Default: False."
    inputBinding:
      position: 1
      prefix: -k
  - id: seed
    type:
      - 'null'
      - int
    doc: "Seed for ensuring reproducibility. Default: 555."
    inputBinding:
      position: 1
      prefix: -s
  - id: temp_dir
    type:
      - 'null'
      - string
    doc: "TMP directory to use instead of the default (/tmp)."
    inputBinding:
      position: 1
      prefix: -T
  - id: memory_in_gb
    type:
      - 'null'
      - int
    doc: "Amount of memory (in GB) Mallet is allowed to use. Default: 100."
    inputBinding:
      position: 1
      prefix: -m
  - id: reuse_corpus
    type:
      - 'null'
      - string
    doc: "Whether to reuse the corpus from Mallet. Default: False."
    inputBinding:
      position: 1
      prefix: -r
  - id: mallet_path
    type:
      - 'null'
      - string
    doc: "Path to Mallet binary. Default: mallet."
    inputBinding:
      position: 1
      prefix: -b
outputs:
  - id: topic_models
    type: File
    doc: "Topic model list pickle file."
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pycistopic:2.0a--pyhdfd78af_0
