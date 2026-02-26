cwlVersion: v1.2
class: CommandLineTool
baseCommand: filter_mashmap_with_tagged_pairs
label: vgp-processcuration_sak_generation
doc: "Filter Mashmap output to keep only Scaffolds paired with the tags Hap_1 and
  Hap_2\n\nTool homepage: https://github.com/vgl-hub/vgl-curation"
inputs:
  - id: agp_file
    type: File
    doc: Path to the curated AGP file (with the tags Hap_1 and Hap_2)
    inputBinding:
      position: 101
      prefix: --agp
  - id: hap1_file
    type: File
    doc: Path to the chromosome assignment file for  Haplotype 1 (inter_chr.tsv)
    inputBinding:
      position: 101
      prefix: --hap1
  - id: hap2_file
    type: File
    doc: Path to the chromosome assignment file for Haplotype 2 (inter_chr.tsv)
    inputBinding:
      position: 101
      prefix: --hap2
  - id: mashmap_file
    type: File
    doc: Path to the curated Mashmap output
    inputBinding:
      position: 101
      prefix: --mashmap
  - id: out_dir
    type: Directory
    doc: Path to output Prefix
    inputBinding:
      position: 101
      prefix: --out_dir
  - id: query_haplotype
    type:
      - 'null'
      - string
    doc: 'Haplotype use as Query for MashMap: Hap_1 or Hap_2 (Default Hap_2)'
    default: Hap_2
    inputBinding:
      position: 101
      prefix: --query
  - id: reference_haplotype
    type:
      - 'null'
      - string
    doc: 'Haplotype use as reference for MashMap: Hap_1 or Hap_2 (Default Hap_1)'
    default: Hap_1
    inputBinding:
      position: 101
      prefix: --reference
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vgp-processcuration:1.1--pyhdfd78af_0
stdout: vgp-processcuration_sak_generation.out
