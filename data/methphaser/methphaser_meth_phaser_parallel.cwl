cwlVersion: v1.2
class: CommandLineTool
baseCommand: meth_phaser_parallel
label: methphaser_meth_phaser_parallel
doc: "methphaser: phase reads based on methlytion informaiton\n\nTool homepage: https://github.com/treangenlab/methphaser"
inputs:
  - id: assignment_min
    type:
      - 'null'
      - int
    doc: minimum assigned read number for ranksum test
    inputBinding:
      position: 101
      prefix: --assignment_min
  - id: bam_file
    type: File
    doc: input methylation annotated bam file
    inputBinding:
      position: 101
      prefix: --bam_file
  - id: cut_off
    type:
      - 'null'
      - float
    doc: the minimum percentage of vote to determine a read's haplotype
    inputBinding:
      position: 101
      prefix: --cut_off
  - id: gtf
    type: File
    doc: gtf file from whatshap visualization
    inputBinding:
      position: 101
      prefix: --gtf
  - id: k_iterations
    type:
      - 'null'
      - int
    doc: use at most k iterations, use -1 for unlimited iterations.
    inputBinding:
      position: 101
      prefix: --k_iterations
  - id: max_len
    type:
      - 'null'
      - int
    doc: 'maximum homozygous region length for phasing, default: -1 (ignore the largest
      homozygous region, centromere), input -2 for not skipping anything'
    inputBinding:
      position: 101
      prefix: --max_len
  - id: reference
    type: File
    doc: reference genome
    inputBinding:
      position: 101
      prefix: --reference
  - id: threads
    type:
      - 'null'
      - int
    doc: threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: vcf_called
    type: File
    doc: called vcf file from HapCUT2
    inputBinding:
      position: 101
      prefix: --vcf_called
  - id: vcf_truth
    type:
      - 'null'
      - File
    doc: Truth vcf file for benchmarking
    inputBinding:
      position: 101
      prefix: --vcf_truth
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: output_directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methphaser:0.0.3--hdfd78af_0
