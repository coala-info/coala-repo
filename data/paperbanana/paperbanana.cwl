cwlVersion: v1.2
class: CommandLineTool
baseCommand: 
- python 
- /app/generate.py
label: generate
doc: PaperVizAgent single-sample processing (direct text input)
inputs:
  - id: task_name
    type:
      - 'null'
      - string
    doc: 'task type: diagram or plot'
    inputBinding:
      position: 101
      prefix: --task_name
  - id: raw_text
    type:
      - 'null'
      - string
    doc: methodology text (diagram) or raw plot data as text/JSON (plot)
    inputBinding:
      position: 101
      prefix: --raw_text
  - id: raw_file
    type: File
    doc: file containing raw_text (diagram methodology or plot raw data)
    inputBinding:
      position: 101
      prefix: --raw_file
  - id: caption_intent
    type:
      - 'null'
      - string
    doc: figure caption (diagram) or visual intent (plot)
    inputBinding:
      position: 101
      prefix: --caption_intent
  - id: model_config
    type:
      - 'null'
      - File
    doc: path to model_config.yaml
    inputBinding:
      position: 101
      prefix: --model_config
  - id: exp_mode
    type:
      - 'null'
      - string
    doc: experiment pipeline mode
    inputBinding:
      position: 101
      prefix: --exp_mode
  - id: retrieval_setting
    type:
      - 'null'
      - string
    doc: retrieval setting for planner agent
    inputBinding:
      position: 101
      prefix: --retrieval_setting
  - id: ref_dir
    type:
      - 'null'
      - Directory
    doc: directory with ref.json and reference images for Retriever/Planner
    inputBinding:
      position: 101
      prefix: --ref_dir
  - id: planner_metaphor
    type:
      - 'null'
      - boolean
    doc: enable diagram-only Planner visual-metaphor discovery before detailed 
      description output
    inputBinding:
      position: 101
      prefix: --planner-metaphor
  - id: max_critic_rounds
    type:
      - 'null'
      - int
    doc: maximum number of critic rounds
    inputBinding:
      position: 101
      prefix: --max_critic_rounds
  - id: main_model_name
    type:
      - 'null'
      - string
    doc: main model name
    inputBinding:
      position: 101
      prefix: --main_model_name
  - id: image_gen_model_name
    type:
      - 'null'
      - string
    doc: image generation model name
    inputBinding:
      position: 101
      prefix: --image_gen_model_name
  - id: aspect_ratio
    type:
      - 'null'
      - string
    doc: output image aspect ratio, e.g. 1:1, 16:9, 21:9
    inputBinding:
      position: 101
      prefix: --aspect_ratio
  - id: image_size
    type:
      - 'null'
      - string
    doc: output image resolution for providers that support it
    inputBinding:
      position: 101
      prefix: --image_size
  - id: output
    type: string
    doc: output JSON path
    inputBinding:
      position: 101
      prefix: --output
  - id: image_output
    type: string
    doc: output image path
    inputBinding:
      position: 101
      prefix: --image_output
outputs:
  - id: output_output
    type:
      - 'null'
      - File
    doc: output JSON path
    outputBinding:
      glob: $(inputs.output)
  - id: output_image_output
    type:
      - 'null'
      - File
    doc: output image path
    outputBinding:
      glob: $(inputs.image_output)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: hubentu/paperbanana
s:url: https://github.com/dwzhu-pku/PaperBanana
$namespaces:
  s: https://schema.org/
