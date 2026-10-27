cwlVersion: v1.2
class: CommandLineTool
baseCommand: chromosome_assignment
label: vgp-processcuration_chromosome_assignment
doc: "Modify scaffold names to reflect chromosomal assignment.\n\nTool homepage: https://github.com/vgl-hub/vgl-curation"
inputs:
  - id: agp
    type: File
    doc: Path to the haplotype AGP without haplotig duplications
    inputBinding:
      position: 101
      prefix: --agp
  - id: fasta
    type: File
    doc: Path to the sorted fasta file
    inputBinding:
      position: 101
      prefix: --fasta
  - id: output_dir
    type: string
    doc: Output directory (created before the run; the tool writes into it)
    inputBinding:
      position: 102
      prefix: --output_dir
outputs:
  - id: out_directory
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir)
  - id: inter_chr_tsv
    type: File
    doc: Table mapping the scaffolds to their chromosomal assignment.
    outputBinding:
      glob: $(inputs.output_dir)/inter_chr.tsv
  - id: hap_chr_level_fa
    type: File
    doc: Fasta file with chromosomal level sequences.
    outputBinding:
      glob: $(inputs.output_dir)/hap.chr_level.fa
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: "$({class: 'Directory', basename: inputs.output_dir, listing: []})"
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vgp-processcuration:1.1--pyhdfd78af_0
