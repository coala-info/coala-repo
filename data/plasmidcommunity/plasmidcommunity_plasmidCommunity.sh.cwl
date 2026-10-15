cwlVersion: v1.2
class: CommandLineTool
baseCommand: plasmidCommunity.sh
label: plasmidcommunity_plasmidCommunity.sh
doc: "Three modes are provided for analysis: silhouetteCurve, getCommunity and pan\n\
  \nTool homepage: https://github.com/wuxinmiao5/PlasmidCommunity"
inputs:
  - id: discutoff
    type:
      - 'null'
      - float
    doc: the distance cutoff to generate community
    inputBinding:
      position: 101
      prefix: -d
  - id: fastani
    type:
      - 'null'
      - File
    doc: the fastani result for input, it's the result saved by silhouetteCurve
    inputBinding:
      position: 101
      prefix: -c
  - id: input_membership
    type:
      - 'null'
      - File
    doc: the membership file of the network nodes
    inputBinding:
      position: 101
      prefix: -f
  - id: input_mode
    type: string
    doc: 'the mode chosen for analysis: silhouetteCurve, getCommunity or pan'
    inputBinding:
      position: 101
      prefix: -a
  - id: input_plasmid_seq
    type:
      - 'null'
      - Directory
    doc: the path of a directory containing plasmids genomes
    inputBinding:
      position: 101
      prefix: -s
  - id: membershipcutoff
    type:
      - 'null'
      - int
    doc: the minimum of community size
    inputBinding:
      position: 101
      prefix: -m
  - id: output_tag
    type: string
    doc: the output tag
    inputBinding:
      position: 101
      prefix: -o
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: treedist
    type:
      - 'null'
      - File
    doc: R object with the ANI distance matrix (silhouetteCurve mode)
    outputBinding:
      glob: treedist
  - id: fastani_output
    type:
      - 'null'
      - File
    doc: fastANI all-against-all result (silhouetteCurve mode)
    outputBinding:
      glob: fastani_output.txt
  - id: silhouette_curve_pdf
    type:
      - 'null'
      - File
    doc: Silhouette curve plot (silhouetteCurve mode)
    outputBinding:
      glob: Silhouette_curve_*.pdf
  - id: membership_info
    type:
      - 'null'
      - File
    doc: Community membership of each plasmid (getCommunity mode)
    outputBinding:
      glob: membership_info.txt
  - id: network_plot_pdf
    type:
      - 'null'
      - File
    doc: Network plot of the communities (getCommunity mode)
    outputBinding:
      glob: network_plot_*.pdf
  - id: pan_plot_pdf
    type:
      - 'null'
      - File
    doc: New-gene curves per community (pan mode)
    outputBinding:
      glob: '*_allmem.pdf'
  - id: newgene_alpha
    type:
      - 'null'
      - File
    doc: Fitted parameters per community (pan mode)
    outputBinding:
      glob: roary_newgene_alpha1.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plasmidcommunity:1.0.2--r44hdfd78af_1
stdout: plasmidcommunity_plasmidCommunity.sh.out
