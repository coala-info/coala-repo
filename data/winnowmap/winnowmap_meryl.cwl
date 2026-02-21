cwlVersion: v1.2
class: CommandLineTool
baseCommand: meryl
label: winnowmap_meryl
doc: "The provided text does not contain help documentation or usage instructions.
  It contains container runtime logs and a fatal error message regarding a failure
  to build or fetch the OCI image.\n\nTool homepage: https://github.com/marbl/Winnowmap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/winnowmap:2.03--h5ca1c30_4
stdout: winnowmap_meryl.out
