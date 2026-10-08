cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - easypqp
  - filter-unimod
label: easypqp_filter-unimod
doc: "Reduce UniMod XML Database file\n\nTool homepage: https://github.com/grosenberger/easypqp"
inputs:
  - id: in_file
    type:
      - 'null'
      - File
    doc: Input UniMod XML file. The tool uses its built-in unimod.xml when not
      given.
    inputBinding:
      position: 101
      prefix: --in
  - id: ids
    type:
      - 'null'
      - string
    doc: UniMod record ids to filter for, i.e. 1,2,4,21.
    inputBinding:
      position: 101
      prefix: --ids
  - id: sites
    type:
      - 'null'
      - string
    doc: "Optional further restriction for specificity, i.e.
      [n,],M,nK[,QN,STY,*,*,*,EDcRK,WM,RK,Y,K,[TKnS,K,R,EK,Y]. Give one site
      entry per UniMod id, in the same order as --ids (for example --ids 1,21,35
      with --sites n,STY,M). Valid sites: * (wildcard, no restriction), [
      (protein N-term), ] (protein C-term), n (any N-term), c (any C-term), or
      amino acid one letter codes."
    inputBinding:
      position: 101
      prefix: --sites
  - id: out_path
    type: string
    default: unimod_ipf.xml
    doc: Output Filtered UniMod XML file.
    inputBinding:
      position: 102
      prefix: --out
outputs:
  - id: out
    type: File
    doc: Output Filtered UniMod XML file.
    outputBinding:
      glob: $(inputs.out_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/easypqp:0.1.56--pyhdfd78af_0
