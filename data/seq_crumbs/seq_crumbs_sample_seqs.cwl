cwlVersion: v1.2
class: CommandLineTool
baseCommand: seq_crumbs_sample_seqs
label: seq_crumbs_sample_seqs
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log indicating a failure to build a Singularity/Apptainer container
  due to insufficient disk space ('no space left on device').\n\nTool homepage: https://github.com/JoseBlanca/seq_crumbs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequana_pipetools:1.3.1--pyhdfd78af_0
stdout: seq_crumbs_sample_seqs.out
