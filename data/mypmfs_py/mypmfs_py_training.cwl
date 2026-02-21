cwlVersion: v1.2
class: CommandLineTool
baseCommand: mypmfs_py_training
label: mypmfs_py_training
doc: "The provided text does not contain help information or usage instructions. It
  appears to be an error log from a container execution attempt (Singularity/Apptainer)
  indicating a 'no space left on device' failure while pulling the image quay.io/biocontainers/mypmfs_py:0.1.8--pyhdfd78af_0.\n
  \nTool homepage: https://github.com/bibip-impmc/mypmfs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mypmfs_py:0.1.8--pyhdfd78af_0
stdout: mypmfs_py_training.out
