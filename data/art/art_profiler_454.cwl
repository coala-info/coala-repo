cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - art_profiler_454
label: art_profiler_454
doc: "Generate empirical 454 read profiles for the ART 454 simulator from 454 read\
  \ data files in fastq format.\n\nTool homepage: https://www.niehs.nih.gov/research/resources/software/biostatistics/art"
inputs:
  - id: input_fastq_files_dir
    type: Directory
    doc: directory of input 454 fastq (or gzipped fastq) files
    inputBinding:
      position: 1
  - id: output_profile_dir
    type: string
    doc: output read profile directory
    inputBinding:
      position: 2
  - id: fastq_filename_extension
    type:
      - 'null'
      - string
    doc: 'fastq filename extension (default: fq)'
    inputBinding:
      position: 3
outputs:
  - id: profile_dir
    type: Directory
    doc: The 454 read profile directory, usable with art_454 -p.
    outputBinding:
      glob: $(inputs.output_profile_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/art:2016.06.05--h0704011_13
