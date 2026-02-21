cwlVersion: v1.2
class: CommandLineTool
baseCommand: igda_pipe_detect_ont
label: igda-script_igda_pipe_detect_ont
doc: "IGDA pipeline for ONT detection. (Note: The provided help text was an error
  log and did not contain usage information.)\n\nTool homepage: https://github.com/zhixingfeng/shell"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
stdout: igda-script_igda_pipe_detect_ont.out
