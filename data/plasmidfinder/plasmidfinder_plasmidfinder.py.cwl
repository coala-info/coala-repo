cwlVersion: v1.2
class: CommandLineTool
baseCommand: plasmidfinder.py
label: plasmidfinder_plasmidfinder.py
doc: "The provided text does not contain help documentation or usage instructions.
  It contains system logs indicating a failure to build a Singularity/Apptainer container
  due to insufficient disk space ('no space left on device').\n\nTool homepage: https://bitbucket.org/genomicepidemiology/plasmidfinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plasmidfinder:2.1.6--py314hdfd78af_2
stdout: plasmidfinder_plasmidfinder.py.out
