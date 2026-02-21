cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedextract
label: bedops_bedextract
doc: "The provided text does not contain help information for the tool, but rather
  error logs from a container runtime (Singularity/Apptainer) indicating a 'no space
  left on device' failure during image extraction. Based on the tool name hint, bedextract
  is a BEDOPS utility used to quickly extract features from sorted BED files.\n\n
  Tool homepage: http://bedops.readthedocs.io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedops:2.4.42--hd6d6fdc_1
stdout: bedops_bedextract.out
