cwlVersion: v1.2
class: CommandLineTool
baseCommand: from_bams_to_unionbed.sh
label: difcover_from_bams_to_unionbed.sh
doc: "Calculates coverage for BAM files using BEDTOOLS and SAMTOOLS. The main output
  reports coverage for input samples in corresponding columns for each bed interval.
  Additional files report coverage for each sample separately.\n\nTool homepage: https://github.com/timnat/DifCover"
inputs:
  - id: sample1_bam
    type: File
    doc: First input coordinate-sorted BAM file.
    inputBinding:
      position: 1
  - id: sample2_bam
    type: File
    doc: Second input coordinate-sorted BAM file.
    inputBinding:
      position: 2
outputs:
  - id: unionbedcv
    type: File
    doc: Coverage of sample1 and sample2 in columns for each bed interval.
    outputBinding:
      glob: sample1_sample2.unionbedcv
  - id: sample_bedcov
    type: File[]
    doc: Sorted coverage bedgraph for each sample.
    outputBinding:
      glob: sample*.bedcov.Vk1s_sorted
  - id: ref_length
    type: File
    doc: Sorted lengths of the reference scaffolds (used by later stages).
    outputBinding:
      glob: ref.length.Vk1s_sorted
  - id: renaming_list
    type: File
    doc: Original BAM file names of sample1 and sample2.
    outputBinding:
      glob: Renaming.list
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.sample1_bam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/difcover:3.0.1--h9948957_2
stdout: difcover_from_bams_to_unionbed.sh.out
