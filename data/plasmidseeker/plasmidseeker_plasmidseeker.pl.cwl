cwlVersion: v1.2
class: CommandLineTool
baseCommand: plasmidseeker.pl
label: plasmidseeker_plasmidseeker.pl
doc: "The provided text is a system error log from a container runtime (Singularity/Apptainer)
  and does not contain the tool's help text or argument definitions. PlasmidSeeker
  is generally used for identifying plasmids from whole-genome sequencing reads.\n
  \nTool homepage: https://github.com/bioinfo-ut/PlasmidSeeker"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/plasmidseeker:v1.0dfsg-1-deb_cv1
stdout: plasmidseeker_plasmidseeker.pl.out
