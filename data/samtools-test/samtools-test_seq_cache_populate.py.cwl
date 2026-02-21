cwlVersion: v1.2
class: CommandLineTool
baseCommand: samtools-test_seq_cache_populate.py
label: samtools-test_seq_cache_populate.py
doc: "Note: The provided text does not contain help information or usage instructions
  for the tool. It appears to be a log of a failed container build process (Singularity/Apptainer).\n
  \nTool homepage: https://github.com/samtools/samtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/samtools-test:v1.9-4-deb_cv1
stdout: samtools-test_seq_cache_populate.py.out
