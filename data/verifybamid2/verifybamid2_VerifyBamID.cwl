cwlVersion: v1.2
class: CommandLineTool
baseCommand: VerifyBamID
label: verifybamid2_VerifyBamID
doc: "The provided text does not contain help information. It appears to be a log
  of a failed container execution (Singularity/Apptainer) while attempting to fetch
  the image.\n\nTool homepage: https://github.com/Griffan/VerifyBamID"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/verifybamid2:2.0.1--h32f71e1_2
stdout: verifybamid2_VerifyBamID.out
