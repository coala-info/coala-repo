cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sanity_check_genome.pl
label: mirdeep2_sanity_check_genome.pl
doc: "Check a genome fasta file for miRDeep2: ids without whitespace and unique, sequences only [ACGTNacgtn]. The script prints a message to standard error and exits non-zero when the file is broken; stdout and stderr are collected and the exit codes 0, 2, 25 and 255 count as success so the verdict can be read from the outputs.\n\nTool homepage: https://github.com/rajewsky-lab/mirdeep2"
inputs:
  - id: input_file
    type: File
    doc: Genome file in fasta format
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
stdout: sanity_check_genome.out
stderr: sanity_check_genome.err
successCodes: [0, 2, 25, 255]
