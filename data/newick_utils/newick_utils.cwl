cwlVersion: v1.2
class: CommandLineTool
baseCommand: newick_utils
label: newick_utils
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to build a Singularity/Apptainer container due to insufficient
  disk space.\n\nTool homepage: http://cegg.unige.ch/newick_utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/newick_utils:1.6--hd747bf3_9
stdout: newick_utils.out
