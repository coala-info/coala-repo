cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyamilyseq
  - Group-Splitter
label: pyamilyseq_Group-Splitter
doc: "The provided text does not contain help information for the tool. It contains
  log messages from a container runtime (Apptainer/Singularity) indicating a fatal
  error while attempting to fetch and build the SIF format from a Docker URI.\n\n
  Tool homepage: https://github.com/NickJD/PyamilySeq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyamilyseq:1.3.2--pyhdfd78af_0
stdout: pyamilyseq_Group-Splitter.out
