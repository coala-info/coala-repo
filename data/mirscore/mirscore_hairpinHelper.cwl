cwlVersion: v1.2
class: CommandLineTool
baseCommand: hairpinHelper
label: mirscore_hairpinHelper
doc: "Creates a hairpin FASTA file with one precursor entry for every mature miRNA
  that shares a single hairpin locus (for example osa-miR159a.1 and osa-miR159a.2
  from osa-MIR159a). The new file is miRScore_adjusted_hairpins.fa and is written
  only when entries were added.\n\nTool homepage: https://github.com/Aez35/miRScore"
inputs:
  - id: mature
    type: File
    doc: fasta file of mature miRNA sequence
    inputBinding:
      position: 1
      prefix: -mature
  - id: hairpin
    type: File
    doc: fasta file of hairpin precursor sequence
    inputBinding:
      position: 2
      prefix: -hairpin
outputs:
  - id: adjusted_hairpins
    type:
      - 'null'
      - File
    doc: Hairpin FASTA file with one entry per mature miRNA (written only when
      entries were added).
    outputBinding:
      glob: miRScore_adjusted_hairpins.fa
  - id: log
    type: stdout
stdout: hairpinHelper.log
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirscore:0.3.4--hdfd78af_0
