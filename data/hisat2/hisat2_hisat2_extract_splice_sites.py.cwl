cwlVersion: v1.2
class: CommandLineTool
baseCommand: hisat2_extract_splice_sites.py
label: hisat2_hisat2_extract_splice_sites.py
doc: "The provided text does not contain help information for the tool. It contains
  a fatal error message from the Singularity/Apptainer container runtime indicating
  a failure to build the image due to insufficient disk space.\n\nTool homepage: http://daehwankimlab.github.io/hisat2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hisat2:2.2.2--h503566f_0
stdout: hisat2_hisat2_extract_splice_sites.py.out
