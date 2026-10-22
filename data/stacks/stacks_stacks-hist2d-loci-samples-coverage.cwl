cwlVersion: v1.2
class: CommandLineTool
baseCommand: stacks-hist2d-loci-samples-coverage
label: stacks_stacks-hist2d-loci-samples-coverage
doc: "Draw a 2D histogram of loci by number of samples and coverage from a table of read counts per sample per locus.

Tool homepage: https://catchenlab.life.illinois.edu/stacks/"
inputs:
  - id: reads_per_sample_per_locus
    type: File
    doc: "Table of read counts per sample (columns) per locus (row), e.g. the output of stacks-count-reads-per-sample-per-locus"
    inputBinding:
      position: 201
outputs:
  - id: pdf
    type: File
    doc: Histogram PDF written next to the input table
    outputBinding:
      glob: $(inputs.reads_per_sample_per_locus.basename).pdf
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.reads_per_sample_per_locus)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stacks:2.68--h077b44d_3
stdout: stacks_stacks-hist2d-loci-samples-coverage.out
