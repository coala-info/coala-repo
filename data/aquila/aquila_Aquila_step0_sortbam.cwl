cwlVersion: v1.2
class: CommandLineTool
baseCommand: Aquila_step0_sortbam
label: aquila_Aquila_step0_sortbam
doc: "sort bam by qname\n\nTool homepage: https://github.com/maiziex/Aquila"
inputs:
  - id: bam_file
    type: File
    doc: Required parameter, BAM file, called by "longranger align"
    inputBinding:
      position: 101
      prefix: --bam_file
  - id: num_threads_for_samtools_sort
    type:
      - 'null'
      - int
    doc: The number of threads you can define for samtools sort, default = 20
    inputBinding:
      position: 101
      prefix: --num_threads_for_samtools_sort
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Directory to store Aquila assembly results, default = 
      ./Assembly_results
    inputBinding:
      position: 101
      prefix: --out_dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aquila:1.0.0--py_0
stdout: aquila_Aquila_step0_sortbam.out
