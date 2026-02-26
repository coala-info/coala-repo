cwlVersion: v1.2
class: CommandLineTool
baseCommand: ivar_getmasked
label: ivar_getmasked
doc: "This step is used only for amplicon-based sequencing.\n\nTool homepage: https://andersen-lab.github.io/ivar/html/"
inputs:
  - id: input_filtered_tsv
    type: File
    doc: Input filtered variants tsv generated from `ivar filtervariants`
    inputBinding:
      position: 101
      prefix: -i
  - id: prefix
    type: string
    doc: Prefix for the output text file
    inputBinding:
      position: 101
      prefix: -p
  - id: primer_pairs_tsv
    type: File
    doc: Primer pair information file containing left and right primer names for
      the same amplicon separated by a tab
    inputBinding:
      position: 101
      prefix: -f
  - id: primers_bed
    type: File
    doc: BED file with primer sequences and positions
    inputBinding:
      position: 101
      prefix: -b
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ivar:1.4.4--h077b44d_0
stdout: ivar_getmasked.out
