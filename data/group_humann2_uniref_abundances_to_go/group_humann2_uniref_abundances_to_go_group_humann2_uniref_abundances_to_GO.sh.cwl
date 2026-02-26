cwlVersion: v1.2
class: CommandLineTool
baseCommand: group_humann2_uniref_abundances_to_GO.sh
label: 
  group_humann2_uniref_abundances_to_go_group_humann2_uniref_abundances_to_GO.sh
doc: "Groups UniRef abundances to Gene Ontology (GO) terms.\n\nTool homepage: https://github.com/ASaiM/group_humann2_uniref_abundances_to_GO"
inputs:
  - id: basic_go_file
    type:
      - 'null'
      - File
    doc: Path to basic Gene Ontology file
    inputBinding:
      position: 101
      prefix: -a
  - id: basic_slim_go_file
    type:
      - 'null'
      - File
    doc: Path to basic slim Gene Ontology file
    inputBinding:
      position: 101
      prefix: -s
  - id: biological_process_abundances_file
    type: File
    doc: Path to file which will contain GO slim term abudances corresponding to
      biological processes
    inputBinding:
      position: 101
      prefix: -b
  - id: cellular_component_abundances_file
    type: File
    doc: Path to file which will contain GO slim term abudances corresponding to
      cellular components
    inputBinding:
      position: 101
      prefix: -c
  - id: goa_tools_scripts_dir
    type:
      - 'null'
      - Directory
    doc: Path to GoaTools scripts
    inputBinding:
      position: 101
      prefix: -g
  - id: humann2_scripts_dir
    type:
      - 'null'
      - Directory
    doc: Path to HUMAnN2 scripts
    inputBinding:
      position: 101
      prefix: -p
  - id: molecular_function_abundances_file
    type: File
    doc: Path to file which will contain GO slim term abudances corresponding to
      molecular functions
    inputBinding:
      position: 101
      prefix: -m
  - id: uniref_abundance_file
    type: File
    doc: Path to file with UniRef50 gene family abundance (HUMAnN2 output)
    inputBinding:
      position: 101
      prefix: -i
  - id: uniref_go_correspondence_file
    type:
      - 'null'
      - File
    doc: Path to file with HUMAnN2 correspondance betwen UniRef50 and GO
    inputBinding:
      position: 101
      prefix: -u
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/group_humann2_uniref_abundances_to_go:1.3.0--0
stdout: 
  group_humann2_uniref_abundances_to_go_group_humann2_uniref_abundances_to_GO.sh.out
