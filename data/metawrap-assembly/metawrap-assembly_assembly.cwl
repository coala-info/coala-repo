cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metawrap
  - assembly
label: metawrap-assembly_assembly
doc: "Assemble reads into contigs\n\nTool homepage: https://github.com/bxlab/metaWRAP"
inputs:
  - id: memory
    type:
      - 'null'
      - int
    doc: memory in GB
    inputBinding:
      position: 101
      prefix: -m
  - id: min_contig_length
    type:
      - 'null'
      - int
    doc: minimum length of assembled contigs
    inputBinding:
      position: 101
      prefix: -l
  - id: output_dir
    type: string
    doc: output directory
    inputBinding:
      position: 101
      prefix: -o
  - id: reads_1
    type: File
    doc: forward fastq reads
    inputBinding:
      position: 101
      prefix: '-1'
  - id: reads_2
    type: File
    doc: reverse fastq reads
    inputBinding:
      position: 101
      prefix: '-2'
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: -t
  - id: use_megahit
    type:
      - 'null'
      - boolean
    doc: assemble with megahit (default)
    inputBinding:
      position: 101
      prefix: --megahit
  - id: use_metaspades
    type:
      - 'null'
      - boolean
    doc: assemble with metaspades instead of megahit (better results but slower 
      amd higher memory requirement)
    inputBinding:
      position: 101
      prefix: --metaspades
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_dir_dir
    type:
      - 'null'
      - Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metawrap-assembly:1.3.0--hdfd78af_3
stdout: metawrap-assembly_assembly.out
