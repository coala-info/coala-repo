cwlVersion: v1.2
class: CommandLineTool
baseCommand: sak_generation
label: vgp-processcuration_sak_generation
doc: "Filter Mashmap output to keep only Scaffolds paired with the tags Hap_1 and Hap_2\n\nTool homepage: https://github.com/vgl-hub/vgl-curation"
inputs:
  - id: agp_file
    type: File
    doc: Path to the curated AGP file (with the tags Hap_1 and Hap_2)
    inputBinding:
      position: 101
      prefix: --agp
  - id: hap1_file
    type: File
    doc: Path to the chromosome assignment file for Haplotype 1 (inter_chr.tsv)
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
    type: string
    doc: Output directory; it must contain a slash, for example results/
    inputBinding:
      position: 101
      prefix: --out_dir
  - id: query_haplotype
    type:
      - 'null'
      - string
    doc: 'Haplotype use as Query for MashMap: Hap_1 or Hap_2 (Default Hap_2)'
    inputBinding:
      position: 101
      prefix: --query
  - id: reference_haplotype
    type:
      - 'null'
      - string
    doc: 'Haplotype use as reference for MashMap: Hap_1 or Hap_2 (Default Hap_1)'
    inputBinding:
      position: 101
      prefix: --reference
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: out_directory
    type: Directory
    doc: Output directory
    outputBinding:
      glob: "${ return inputs.out_dir.replace(/\\/+$/, ''); }"
  - id: orientation_tsv
    type: File
    doc: Table with the orientation of Hap1 vs Hap2 scaffolds
    outputBinding:
      glob: "${ return inputs.out_dir.replace(/\\/+$/, '') + '/orientation.tsv'; }"
  - id: reversing_renaming_sak
    type: File
    doc: SAK file for gfastats reversing and renaming of hap2 sequences
    outputBinding:
      glob: "${ return inputs.out_dir.replace(/\\/+$/, '') + '/reversing_renaming.sak'; }"
  - id: missing_tsv
    type:
      - 'null'
      - File
    doc: Pairs of scaffolds found by curation but not in the Mashmap output
    outputBinding:
      glob: "${ return inputs.out_dir.replace(/\\/+$/, '') + '/missing.tsv'; }"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vgp-processcuration:1.1--pyhdfd78af_0
stdout: vgp-processcuration_sak_generation.out
