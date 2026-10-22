cwlVersion: v1.2
class: CommandLineTool
baseCommand: combineKmers
label: seer_combine_kmers
doc: "combineKmers: basic algorithm to combine kmer counts across samples\n\nTool homepage: https://github.com/johnlees/seer"
requirements:
  - class: InitialWorkDirRequirement
    listing: $(inputs.kmer_files)
inputs:
  - id: samples
    type: File
    doc: "File with tab separated sample name and kmer file"
    inputBinding:
      position: 1
      prefix: --samples
  - id: kmer_files
    type: File[]
    doc: "Kmer count files named in the samples file, staged in the working directory"
  - id: output
    type: string
    doc: "Output file prefix"
    inputBinding:
      position: 1
      prefix: --output
  - id: min_samples
    type: ['null', int]
    doc: "Minimum number of samples kmer must occur in to be printed (default 1)"
    inputBinding:
      position: 1
      prefix: --min_samples
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Files written with the output prefix
    outputBinding:
      glob: $(inputs.output)*
  - id: output
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/seer:v1.1.4-2b2-deb_cv1
stdout: seer_combine_kmers.out
