cwlVersion: v1.2
class: CommandLineTool
baseCommand: CRISPRessoPooled
label: crispresso2_CRISPRessoPooled
doc: "The provided text does not contain help information for the tool; it is a log
  of a failed container build process (Singularity/Apptainer) due to insufficient
  disk space.\n\nTool homepage: https://github.com/pinellolab/CRISPResso2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crispresso2:2.3.3--py39hff726c5_0
stdout: crispresso2_CRISPRessoPooled.out
