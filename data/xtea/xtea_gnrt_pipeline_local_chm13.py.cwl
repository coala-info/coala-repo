cwlVersion: v1.2
class: CommandLineTool
baseCommand: xtea_gnrt_pipeline_local_chm13.py
label: xtea_gnrt_pipeline_local_chm13.py
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains log messages related to a failed Apptainer/Singularity image
  build process.\n\nTool homepage: https://github.com/parklab/xTea"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xtea:0.1.9--hdfd78af_0
stdout: xtea_gnrt_pipeline_local_chm13.py.out
