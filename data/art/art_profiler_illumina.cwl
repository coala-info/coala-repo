cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - art_profiler_illumina
label: art_profiler_illumina
doc: "Create an Illumina read quality profile from multiple fastq or gzipped fastq\
  \ files.\n\nTool homepage: https://www.niehs.nih.gov/research/resources/software/biostatistics/art"
inputs:
  - id: output_profile_name
    type: string
    doc: the name of read quality profile to be generated
    inputBinding:
      position: 1
  - id: input_fastq_dir
    type: Directory
    doc: the directory of input fastq or zipped fastq files (paired files named *_1/*_2
      or *.1/*.2)
    inputBinding:
      position: 2
  - id: fastq_filename_extension
    type: string
    doc: fastq or gzipped fastq filename extension (e.g. fq, fq.gz)
    inputBinding:
      position: 3
  - id: max_number_threads
    type:
      - 'null'
      - int
    doc: 'maximum number of threads/cores to be used for the run (default: all cores)'
    inputBinding:
      position: 4
outputs:
  - id: profiles
    type: File[]
    doc: Read quality profile files (<name>.txt for single-end; <name>R1.txt and <name>R2.txt
      for paired-end).
    outputBinding:
      glob: $(inputs.output_profile_name)*.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/art:2016.06.05--h0704011_13
