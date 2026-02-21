cwlVersion: v1.2
class: CommandLineTool
baseCommand: group_humann2_uniref_abundances_to_go_install_dependencies.sh
label: group_humann2_uniref_abundances_to_go_install_dependencies.sh
doc: "Install dependencies for grouping HUMAnN2 UniRef abundances to Gene Ontology
  (GO) terms.\n\nTool homepage: https://github.com/ASaiM/group_humann2_uniref_abundances_to_GO"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/group_humann2_uniref_abundances_to_go:1.3.0--0
stdout: group_humann2_uniref_abundances_to_go_install_dependencies.sh.out
