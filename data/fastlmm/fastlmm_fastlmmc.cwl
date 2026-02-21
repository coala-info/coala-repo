cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastlmmc
label: fastlmm_fastlmmc
doc: "Fast Linear Mixed Model (FaST-LMM) tool for genome-wide association studies.\n
  \nTool homepage: http://research.microsoft.com/en-us/um/redmond/projects/mscompbio/fastlmm/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastlmm:0.2.32--py27h95a95ce_5
stdout: fastlmm_fastlmmc.out
