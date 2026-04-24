cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - psass
  - pileup
label: psass_pileup
doc: "Alignment files to include in pileup, in bam or cram format and indexed\n\n\
  Tool homepage: https://github.com/RomainFeron/PSASS"
inputs:
  - id: alignment_files
    type:
      type: array
      items: File
    doc: Alignment files to include in pileup, in bam or cram format and indexed
    inputBinding:
      position: 1
  - id: min_map_quality
    type:
      - 'null'
      - int
    doc: Minimum mapping quality to include a read in pileup
    inputBinding:
      position: 102
      prefix: --min-map-quality
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference file in fasta format, required with CRAM input files
    inputBinding:
      position: 102
      prefix: --reference
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Write to an output file instead of stdout
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psass:3.1.0--hf5e1c6e_4
