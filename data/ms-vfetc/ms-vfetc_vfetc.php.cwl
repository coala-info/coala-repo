cwlVersion: v1.2
class: CommandLineTool
baseCommand: ms-vfetc_vfetc.php
label: ms-vfetc_vfetc.php
doc: "Variable Filtered Exact Test Cluster (VFETC) for Mass Spectrometry data.\n\n
  Tool homepage: https://github.com/leidenuniv-lacdr-abs/ms-vfetc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ms-vfetc:phenomenal-v0.6_cv1.1.27
stdout: ms-vfetc_vfetc.php.out
