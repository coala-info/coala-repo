cwlVersion: v1.2
class: CommandLineTool
baseCommand: plastid_counts_in_region
label: plastid_counts_in_region
doc: "The provided text does not contain help information for the tool. It is a system
  error log indicating a failure to build a Singularity/Apptainer container due to
  insufficient disk space ('no space left on device').\n\nTool homepage: http://plastid.readthedocs.io/en/latest/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plastid:0.6.1--py38h7d1810a_2
stdout: plastid_counts_in_region.out
