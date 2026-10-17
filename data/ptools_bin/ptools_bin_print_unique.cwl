cwlVersion: v1.2
class: CommandLineTool
baseCommand: print_unique
label: ptools_bin_print_unique
doc: "Print the header and the records of a pBAM whose line numbers are listed in linenumbers.txt. The pBAM records (without header) come from standard input; the tool reads header.txt and linenumbers.txt from the working directory.\n\nTool homepage: https://github.com/ENCODE-DCC/ptools_bin"
inputs:
  - id: sam_file
    type: File
    doc: pBAM records without header (output of samtools view), read from standard input
  - id: header_file
    type: File
    doc: SAM header text, staged as header.txt
  - id: linenumbers_file
    type: File
    doc: Zero-based record line numbers to keep, one per line, staged as linenumbers.txt
outputs:
  - id: filtered_sam
    type: stdout
    doc: Header and the selected records in SAM text format
stdin: $(inputs.sam_file.path)
stdout: print_unique.sam
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entryname: header.txt
        entry: $(inputs.header_file)
      - entryname: linenumbers.txt
        entry: $(inputs.linenumbers_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ptools_bin:0.0.7--pyh5e36f6f_0
