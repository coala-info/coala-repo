cwlVersion: v1.2
class: CommandLineTool
baseCommand: clearcut_analyze_flows.py
label: clearcut_analyze_flows.py
doc: "The provided text does not contain help information or a description of the
  tool; it contains system error logs related to a container runtime (Singularity/Apptainer)
  failure.\n\nTool homepage: https://github.com/DavidJBianco/Clearcut"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/clearcut:v1.0.9-3-deb_cv1
stdout: clearcut_analyze_flows.py.out
