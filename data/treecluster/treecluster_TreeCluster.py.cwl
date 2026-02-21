cwlVersion: v1.2
class: CommandLineTool
baseCommand: TreeCluster.py
label: treecluster_TreeCluster.py
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log indicating a failure to build a Singularity/Apptainer container
  due to insufficient disk space ('no space left on device').\n\nTool homepage: https://github.com/niemasd/TreeCluster"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treecluster:1.0.5--pyh7e72e81_0
stdout: treecluster_TreeCluster.py.out
