cwlVersion: v1.2
class: CommandLineTool
baseCommand: rbpbench_info
label: rbpbench_info
doc: "Show information about RBPBench motif databases.\n\nTool homepage: https://github.com/michauhl/RBPBench"
inputs:
  - id: custom_db
    type:
      - 'null'
      - string
    doc: Provide custom motif database folder and print included IDs
    inputBinding:
      position: 101
      prefix: --custom-db
  - id: motif_db
    type:
      - 'null'
      - string
    doc: 'Built-in motif database to use. 1: human RBP motifs (257 RBPs, 599 motifs,
      "catrapid_omics_v2.1_human_6plus_ext"), 2: human RBP motifs + 23 ucRBP motifs
      (277 RBPs, 622 motifs, "catrapid_omics_v2.1_human_6plus_ext_ucrbps"), 3: human
      RBP motifs from Ray et al. 2013 (80 RBPs, 102 motifs, "ray2013_human_rbps_rnacompete")'
    inputBinding:
      position: 101
      prefix: --motif-db
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rbpbench:1.1.0--pyhdfd78af_0
stdout: rbpbench_info.out
