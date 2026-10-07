cwlVersion: v1.2
class: CommandLineTool
baseCommand: check-sort-order
label: check-sort-order
doc: "Check if a bgzipped and tabix-indexed BED, VCF, GTF or tab-separated file is
  sorted in the chromosome order of the specified genome file. Exits 0 with no output
  when the order is correct, and exits 1 with the first out-of-order line on stderr
  otherwise.\n\nTool homepage: https://github.com/gogetdata/ggd-utils"
inputs:
  - id: input_file
    type: File
    doc: Path to the bgzipped file to check (needs a .tbi or .csi index beside it).
    secondaryFiles:
      - pattern: .tbi
        required: false
      - pattern: .csi
        required: false
    inputBinding:
      position: 1
  - id: genome
    type: File
    doc: A genome file of chromosome sizes and order.
    inputBinding:
      position: 102
      prefix: --genome
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Standard error (sort order errors)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/check-sort-order:0.0.7--h9ee0642_1
stdout: check-sort-order.out
stderr: check-sort-order.err
