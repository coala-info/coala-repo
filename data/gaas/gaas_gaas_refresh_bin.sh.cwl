cwlVersion: v1.2
class: CommandLineTool
baseCommand: gaas_gaas_refresh_bin.sh
label: gaas_gaas_refresh_bin.sh
doc: "A tool from the GAAS (Genome Annotation Assessment Service) suite, likely used
  for refreshing binary dependencies or internal data structures.\n\nTool homepage:
  https://github.com/NBISweden/GAAS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gaas:1.2.0--pl5321r42hdfd78af_1
stdout: gaas_gaas_refresh_bin.sh.out
