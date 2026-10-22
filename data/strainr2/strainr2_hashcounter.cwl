cwlVersion: v1.2
class: CommandLineTool
baseCommand: hashcounter
label: strainr2_hashcounter
doc: "hashcounter creates a log of how many kmers are unique in each subcontig, with excluded subcontig kmers considered non-unique\n\nTool homepage: https://github.com/BisanzLab/StrainR2"
inputs:
  - id: subcontigs_dir
    type: Directory
    doc: path to the directory for all subcontigs for which a report will be created
    inputBinding:
      position: 101
      prefix: -s
  - id: excluded_subcontigs_dir
    type: Directory
    doc: path to subcontigs whose kmers shall be considered non-unique
    inputBinding:
      position: 102
      prefix: -e
  - id: kmer_size
    type: int
    doc: kmer sizes to use
    inputBinding:
      position: 103
      prefix: -k
  - id: num_subcontigs
    type: int
    doc: number of subcontigs (excluded or not) that will be input
    inputBinding:
      position: 104
      prefix: -n
  - id: outdir
    type: string
    doc: Directory to write output file to
    inputBinding:
      position: 105
      prefix: -o
outputs:
  - id: outdir_dir
    type: Directory
    doc: output directory with KmerContent.report
    outputBinding:
      glob: $(inputs.outdir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.outdir)
        entry: "$({class: 'Directory', basename: inputs.outdir, listing: []})"
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strainr2:2.3.0--r44h577a1d6_0
