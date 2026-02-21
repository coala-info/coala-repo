cwlVersion: v1.2
class: CommandLineTool
baseCommand: cdna_cupcake
label: cdna_cupcake
doc: "The provided text is an error log from a container runtime (Singularity/Apptainer)
  indicating a failure to build or extract the OCI image due to insufficient disk
  space. It does not contain CLI help information or argument definitions.\n\nTool
  homepage: https://github.com/Magdoll/cDNA_Cupcake"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cdna_cupcake:29.0.0--py310h79ef01b_0
stdout: cdna_cupcake.out
