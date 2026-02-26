cwlVersion: v1.2
class: CommandLineTool
baseCommand: svhip.py
label: svhip_evaluate
doc: "Evaluate SVHIP models or make predictions.\n\nTool homepage: https://github.com/chrisBioInf/Svhip"
inputs:
  - id: input_file
    type: File
    doc: The input directory or file (Required).
    inputBinding:
      position: 101
      prefix: --input
  - id: model_path
    type:
      - 'null'
      - string
    doc: If running a model test (--task test) or prediction (--task predict), 
      this is the path of the model to evaluate. The data set to use should be 
      handed over with -i, --input.
    inputBinding:
      position: 101
      prefix: --model-path
outputs:
  - id: outfile
    type: Directory
    doc: Name for the output directory (Required).
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svhip:1.0.9--hdfd78af_0
