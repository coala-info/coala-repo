cwlVersion: v1.2
class: CommandLineTool
baseCommand: strainseeker
label: strainseeker
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help text or argument definitions for the tool.\n\nTool homepage:
  http://bioinfo.ut.ee/strainseeker"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strainseeker:1.5.1--h7b50bb2_5
stdout: strainseeker.out
