cwlVersion: v1.2
class: CommandLineTool
baseCommand: [rsem-simulate-reads]
label: rsem_rsem-simulate-reads
doc: "Simulate RNA-Seq reads from a learned RSEM model and isoform expression levels.\n\nTool homepage: https://deweylab.github.io/RSEM/"
inputs:
  - id: reference_name
    type: string
    doc: The name of the RSEM reference (made by rsem-prepare-reference).
    inputBinding:
      position: 1
  - id: reference_files
    type:
      type: array
      items: File
    doc: Reference files written by rsem-prepare-reference (all files starting with the reference name). They are staged in the working directory so that reference_name resolves.
  - id: estimated_model_file
    type: File
    doc: Model file learned by rsem-calculate-expression (sample_name.stat/sample_name.model).
    inputBinding:
      position: 2
  - id: estimated_isoform_results
    type: File
    doc: Isoform expression file (sample_name.isoforms.results). Only the TPM column is read.
    inputBinding:
      position: 3
  - id: theta0
    type: float
    doc: Fraction of reads that come from background noise (first value of the third line of sample_name.stat/sample_name.theta).
    inputBinding:
      position: 4
  - id: number_of_reads
    type: long
    doc: Total number of reads to simulate (N).
    inputBinding:
      position: 5
  - id: output_name
    type: string
    doc: Prefix for all output files.
    inputBinding:
      position: 6
  - id: seed
    type: ['null', long]
    doc: Seed for the random number generator (32-bit unsigned integer).
    inputBinding:
      position: 7
      prefix: --seed
  - id: quiet
    type: ['null', boolean]
    doc: Stop outputting intermediate information.
    inputBinding:
      position: 8
      prefix: -q
outputs:
  - id: sim_isoforms_results
    type: File
    doc: Expression levels counted from where each simulated read came from (isoform level).
    outputBinding:
      glob: $(inputs.output_name).sim.isoforms.results
  - id: sim_genes_results
    type: File
    doc: Expression levels counted from where each simulated read came from (gene level).
    outputBinding:
      glob: $(inputs.output_name).sim.genes.results
  - id: sim_alleles_results
    type: ['null', File]
    doc: Allele-specific expression levels (only for allele-aware references).
    outputBinding:
      glob: $(inputs.output_name).sim.alleles.results
  - id: simulated_reads
    type:
      type: array
      items: File
    doc: Simulated reads (output_name.fa/.fq for single-end, output_name_1/_2.fa/.fq for paired-end).
    outputBinding:
      glob:
        - $(inputs.output_name).f[aq]
        - $(inputs.output_name)_[12].f[aq]
requirements:
  - class: InitialWorkDirRequirement
    listing: $(inputs.reference_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
