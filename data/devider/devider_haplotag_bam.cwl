cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - haplotag_bam
label: devider_haplotag_bam
doc: "Tag BAM reads based on accessions from a given IDs file. Each read listed
  in the devider ids.txt gets an HP tag (<haplotype>_<range>); the result is
  written as <input_bam>.tagged.bam and indexed with samtools.\n\nTool homepage:
  https://github.com/bluenote-1577/devider"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.input_bam)
inputs:
  - id: input_bam
    type: File
    doc: Input BAM file.
    inputBinding:
      position: 10
  - id: ids_file
    type: File
    doc: 'IDs file with accessions and tags (devider output ids.txt). Default: 
      devider_output/ids.txt'
    inputBinding:
      position: 1
      prefix: --ids_file
outputs:
  - id: tagged_bam
    type: File
    doc: BAM with HP tags on the reads assigned to a haplotype, with its index
    secondaryFiles:
      - .bai
    outputBinding:
      glob: $(inputs.input_bam.basename).tagged.bam
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/devider:0.0.1--ha6fb395_3
