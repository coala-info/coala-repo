cwlVersion: v1.2
class: CommandLineTool
baseCommand: seg
label: ncbi-seg
doc: "The provided text is an error message from a container runtime (Apptainer/Singularity)
  indicating a failure to build the container image due to insufficient disk space.
  It does not contain the help text or usage information for the ncbi-seg tool.\n\n
  Tool homepage: https://github.com/abelardoacm/genomic_seg_plots"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ncbi-seg:v0.0.20000620-5-deb_cv1
stdout: ncbi-seg.out
