cwlVersion: v1.2
class: CommandLineTool
baseCommand: stacks-count-reads-per-sample-per-locus
label: stacks_stacks-count-reads-per-sample-per-locus
doc: "Tally the number of samples and reads present at all loci of the catalog from the matches.bam files, then run stacks-hist2d-loci-samples-coverage.

Tool homepage: https://catchenlab.life.illinois.edu/stacks/"
inputs:
  - id: stacks_denovo_dir
    type: Directory
    doc: "Directory with the de novo Stacks output (catalog and all samples' matches.bam files)"
    inputBinding:
      position: 201
outputs:
  - id: output_dir
    type: Directory
    doc: Stacks directory with reads_per_sample_per_locus.tsv and its PDF
    outputBinding:
      glob: $(inputs.stacks_denovo_dir.basename)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.stacks_denovo_dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stacks:2.68--h077b44d_3
stdout: stacks_stacks-count-reads-per-sample-per-locus.out
