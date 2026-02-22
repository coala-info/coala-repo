cwlVersion: v1.2
class: CommandLineTool
baseCommand: batchcorrection
label: batchcorrection
doc: "A tool for batch correction (Note: The provided text contains system error logs
  rather than help documentation, so no arguments could be extracted).\n\nTool homepage:
  https://github.com/carpenter-singh-lab/2023_Arevalo_NatComm_BatchCorrection"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      biocontainers/batchcorrection:phenomenal-vphenomenal_2017.12.14_cv0.3.3
stdout: batchcorrection.out
