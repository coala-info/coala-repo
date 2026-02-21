cwlVersion: v1.2
class: CommandLineTool
baseCommand: multiqc_sav
label: multiqc_sav
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a fatal error log from a container runtime (Singularity/Apptainer)
  indicating a failure to build the image due to insufficient disk space.\n\nTool
  homepage: http://multiqc.info"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/multiqc:1.33--pyhdfd78af_0
stdout: multiqc_sav.out
