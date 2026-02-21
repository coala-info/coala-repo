cwlVersion: v1.2
class: CommandLineTool
baseCommand: clustalw_run_gpu.sh
label: clustalw_run_gpu.sh
doc: "Multiple sequence alignment tool (Note: The provided text contains system logs
  and a fatal error regarding container image extraction rather than command-line
  help documentation).\n\nTool homepage: https://github.com/coldfunction/CUDA-clustalW"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clustalw:2.1--h9948957_12
stdout: clustalw_run_gpu.sh.out
