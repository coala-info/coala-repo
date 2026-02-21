cwlVersion: v1.2
class: CommandLineTool
baseCommand: python3-biopython-sql
label: python3-biopython-sql
doc: The provided text does not contain help information for the tool. It appears
  to be an error log from a container build process (Apptainer/Singularity) failing
  to fetch the image for python3-biopython-sql.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/python3-biopython-sql:v1.68dfsg-3-deb_cv1
stdout: python3-biopython-sql.out
