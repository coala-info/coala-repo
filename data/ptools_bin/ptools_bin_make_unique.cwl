cwlVersion: v1.2
class: CommandLineTool
baseCommand: make_unique
label: ptools_bin_make_unique
doc: "List the reads of a pBAM that carry 10x barcode tags. For each SAM record on standard input print the read name, the SR, CR and UR tag values and the line number.\n\nTool homepage: https://github.com/ENCODE-DCC/ptools_bin"
inputs:
  - id: sam_file
    type: File
    doc: pBAM records without header (output of samtools view), read from standard input
outputs:
  - id: reads_text
    type: stdout
    doc: One line per record - name SR CR UR line-number
stdin: $(inputs.sam_file.path)
stdout: make_unique.reads.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ptools_bin:0.0.7--pyh5e36f6f_0
