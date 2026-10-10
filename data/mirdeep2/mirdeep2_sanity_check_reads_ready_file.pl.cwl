cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sanity_check_reads_ready_file.pl
label: mirdeep2_sanity_check_reads_ready_file.pl
doc: "Check a collapsed reads fasta file for miRDeep2: ids of the form name_number_xcount without whitespace, sequences of at least 17 letters [ACGTUNacgtun], no duplicate sequence within a sample. The script prints a message to standard error and exits non-zero when the file is broken; stdout and stderr are collected and the exit codes 0, 2, 25 and 255 count as success so the verdict can be read from the outputs.\n\nTool homepage: https://github.com/rajewsky-lab/mirdeep2"
inputs:
  - id: input_file
    type: File
    doc: Collapsed reads file in fasta format
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Error message describing the first broken line; empty when the file is valid
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
stdout: sanity_check_reads_ready_file.out
stderr: sanity_check_reads_ready_file.err
successCodes: [0, 2, 25, 255]
