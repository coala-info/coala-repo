cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_clair3.py
label: clair3_run_clair3.py
doc: "Clair3 is a germline small variant caller for long-reads. It utilizes deep learning
  to call variants from BAM/CRAM files.\n\nTool homepage: https://github.com/HKU-BAL/Clair3"
inputs:
  - id: bam_fn
    type: File
    doc: BAM file input, with .bai index in the same directory.
    inputBinding:
      position: 101
      prefix: --bam_fn
  - id: bed_fn
    type:
      - 'null'
      - File
    doc: Call variants only in the regions provided in the BED file.
    inputBinding:
      position: 101
      prefix: --bed_fn
  - id: ctg_name
    type:
      - 'null'
      - string
    doc: The name of the contig to be processed.
    inputBinding:
      position: 101
      prefix: --ctg_name
  - id: enable_phasing
    type:
      - 'null'
      - boolean
    doc: Enable phasing for the called variants.
    inputBinding:
      position: 101
      prefix: --enable_phasing
  - id: include_all_ctgs
    type:
      - 'null'
      - boolean
    doc: Call variants on all contigs in the reference FASTA.
    inputBinding:
      position: 101
      prefix: --include_all_ctgs
  - id: model_path
    type: Directory
    doc: The path to the Clair3 model.
    inputBinding:
      position: 101
      prefix: --model_path
  - id: platform
    type: string
    doc: Sequencing platform of the input data (e.g., 'ont', 'hifi', 'ilmn').
    inputBinding:
      position: 101
      prefix: --platform
  - id: qual
    type:
      - 'null'
      - int
    doc: Minimum variant quality to be reported.
    inputBinding:
      position: 101
      prefix: --qual
  - id: ref_fn
    type: File
    doc: Reference FASTA file input, with .fai index in the same directory.
    inputBinding:
      position: 101
      prefix: --ref_fn
  - id: sample_name
    type:
      - 'null'
      - string
    doc: Sample name to be shown in the output VCF file.
    inputBinding:
      position: 101
      prefix: --sample_name
  - id: threads
    type: int
    doc: Max threads to be used.
    inputBinding:
      position: 101
      prefix: --threads
  - id: vcf_fn
    type:
      - 'null'
      - File
    doc: Candidate VCF file input, if provided, Clair3 will only call variants at
      these positions.
    inputBinding:
      position: 101
      prefix: --vcf_fn
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory for the variant calling results.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clair3:1.2.0--py310h779eee5_0
