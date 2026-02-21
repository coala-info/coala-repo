cwlVersion: v1.2
class: CommandLineTool
baseCommand: dartunifrac-cuda
label: dartunifrac-gpu_dartunifrac-cuda
doc: "GPU-accelerated UniFrac distance calculation. (Note: The provided text is an
  error log regarding a failed container build and does not contain usage instructions
  or argument definitions.)\n\nTool homepage: https://github.com/jianshu93/DartUniFrac"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dartunifrac-gpu:0.2.9--hd7384ae_0
stdout: dartunifrac-gpu_dartunifrac-cuda.out
