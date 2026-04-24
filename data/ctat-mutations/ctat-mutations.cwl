cwlVersion: v1.2
class: CommandLineTool
baseCommand: ctat_mutations
label: ctat-mutations
doc: "The CTAT Mutations pipeline identifies mutations in RNA-Seq data, including
  SNVs and indels, and provides functional annotations.\n\nTool homepage: https://github.com/NCIP/ctat-mutations"
inputs:
  - id: fusions
    type:
      - 'null'
      - File
    doc: CTAT-Fusion output file (optional)
    inputBinding:
      position: 101
      prefix: --fusions
  - id: genome_lib_dir
    type: Directory
    doc: CTAT genome library directory
    inputBinding:
      position: 101
      prefix: --genome_lib_dir
  - id: left
    type: File
    doc: Left (R1) fastq file
    inputBinding:
      position: 101
      prefix: --left
  - id: right
    type:
      - 'null'
      - File
    doc: Right (R2) fastq file (optional for single-end)
    inputBinding:
      position: 101
      prefix: --right
  - id: sample_id
    type: string
    doc: Sample identifier
    inputBinding:
      position: 101
      prefix: --sample_id
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ctat-mutations:2.0.1--py27_1
