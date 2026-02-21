cwlVersion: v1.2
class: CommandLineTool
baseCommand: clustalw_run_cpu.sh
label: clustalw_run_cpu.sh
doc: "ClustalW is a general purpose multiple sequence alignment program for DNA or
  proteins. (Note: The provided help text contains system error logs regarding container
  extraction and does not list specific command-line arguments).\n\nTool homepage:
  https://github.com/coldfunction/CUDA-clustalW"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clustalw:2.1--h9948957_12
stdout: clustalw_run_cpu.sh.out
