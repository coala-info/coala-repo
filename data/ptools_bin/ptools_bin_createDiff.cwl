cwlVersion: v1.2
class: CommandLineTool
baseCommand: createDiff
label: ptools_bin_createDiff
doc: "Make a diff text from SAM records read on standard input: for each read that has soft clips, insertions or mismatches (CIGAR S, H, I, D or X) write the CIGAR, the non-reference bases and the AS, MD and NM tags, otherwise write d and the tags. Part of the pBAM privacy tools.\n\nTool homepage: https://github.com/ENCODE-DCC/ptools_bin"
inputs:
  - id: sam_file
    type: File
    doc: SAM records without header (output of samtools view), read from standard input
outputs:
  - id: diff_text
    type: stdout
    doc: Diff text, one line per read
stdin: $(inputs.sam_file.path)
stdout: createDiff.diff.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ptools_bin:0.0.7--pyh5e36f6f_0
