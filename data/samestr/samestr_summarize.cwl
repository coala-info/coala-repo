cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samestr
  - summarize
label: samestr_summarize
doc: "Summarize pairwise alignment comparisons to identify shared strains.\n\nTool
  homepage: https://github.com/danielpodlesny/samestr/"
inputs:
  - id: aln_pair_min_overlap
    type:
      - 'null'
      - int
    doc: Minimum number of overlapping positions which have to be covered in 
      both alignments in order to evaluate alignment similarity.
    inputBinding:
      position: 101
      prefix: --aln-pair-min-overlap
  - id: aln_pair_min_similarity
    type:
      - 'null'
      - float
    doc: Minimum pairwise alignment similarity to call shared strains.
    inputBinding:
      position: 101
      prefix: --aln-pair-min-similarity
  - id: input_dir
    type: Directory
    doc: Path to `samestr compare` output directory. Must contain pairwise 
      comparison of alignment files (.fraction.txt, .overlap.txt)
    inputBinding:
      position: 101
      prefix: --input-dir
  - id: marker_dir
    type: Directory
    doc: Path to MetaPhlAn or mOTUs clade marker database.
    inputBinding:
      position: 101
      prefix: --marker-dir
  - id: tax_profiles_dir
    type: Directory
    doc: 'Path to directory with taxonomic profiles (MetaPhlAn or mOTUs, default extension:
      .profile.txt).'
    inputBinding:
      position: 101
      prefix: --tax-profiles-dir
  - id: tax_profiles_extension
    type:
      - 'null'
      - string
    doc: File extension of taxonomic profiles.
    inputBinding:
      position: 101
      prefix: --tax-profiles-extension
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Path to output directory.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samestr:1.2025.111--pyhdfd78af_0
