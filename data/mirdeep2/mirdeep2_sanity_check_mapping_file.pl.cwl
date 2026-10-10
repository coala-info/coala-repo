cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sanity_check_mapping_file.pl
label: mirdeep2_sanity_check_mapping_file.pl
doc: "Check a mapping file for miRDeep2: every line must follow the arf format. The script prints a message to standard error and exits non-zero when the file is broken; stdout and stderr are collected and the exit codes 0, 2, 25 and 255 count as success so the verdict can be read from the outputs.\n\nTool homepage: https://github.com/rajewsky-lab/mirdeep2"
inputs:
  - id: input_file
    type: File
    doc: Mapping file in arf format
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (a message for non-unique ids)
  - id: stderr
    type: stderr
    doc: Error message describing the first broken line; empty when the file is valid
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
stdout: sanity_check_mapping_file.out
stderr: sanity_check_mapping_file.err
successCodes: [0, 2, 25, 255]
