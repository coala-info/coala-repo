cwlVersion: v1.2
class: CommandLineTool
baseCommand: cmash_StreamingQueryDNADatabase.py
label: cmash_StreamingQueryDNADatabase.py
doc: "The provided text does not contain help information for the tool. It is a system
  error log indicating a failure to build a Singularity/Apptainer image due to insufficient
  disk space ('no space left on device').\n\nTool homepage: https://github.com/dkoslicki/CMash"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cmash:0.5.2--pyh5e36f6f_0
stdout: cmash_StreamingQueryDNADatabase.py.out
