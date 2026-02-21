cwlVersion: v1.2
class: CommandLineTool
baseCommand: updio_add_hom_refs_to_sorted_vcfs.pl
label: updio_add_hom_refs_to_sorted_vcfs.pl
doc: "Add homozygous references to sorted VCF files. (Note: The provided text contains
  container runtime errors and does not include usage or argument information.)\n\n
  Tool homepage: https://github.com/rhpvorderman/updio"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/updio:1.1.0--hdfd78af_0
stdout: updio_add_hom_refs_to_sorted_vcfs.pl.out
