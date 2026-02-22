cwlVersion: v1.2
class: CommandLineTool
baseCommand: eosc-pilot
label: eosc-pilot
doc: "The provided text is an error log from a container build/pull process (Singularity/Apptainer)
  and does not contain CLI help documentation or argument definitions for the tool
  'eosc-pilot'.\n\nTool homepage: https://github.com/yakneens/eosc_pilot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/eosc-pilot:v1.0-remastering_cv1.0
stdout: eosc-pilot.out
