cwlVersion: v1.2
class: CommandLineTool
baseCommand: kalamari_downloadKalamari.sh
label: kalamari_downloadKalamari.sh
doc: "A script to download Kalamari-related data or containers. Note: The provided
  text is an error log indicating a failure to build a Singularity/Apptainer image
  due to insufficient disk space, rather than standard help documentation.\n\nTool
  homepage: https://github.com/lskatz/kalamari"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kalamari:5.8.0--pl5321hdfd78af_0
stdout: kalamari_downloadKalamari.sh.out
