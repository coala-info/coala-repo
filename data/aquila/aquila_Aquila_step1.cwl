cwlVersion: v1.2
class: CommandLineTool
baseCommand: python3 Aquila_step1
label: aquila_Aquila_step1
doc: "Aquila_step1 tool for assembly\n\nTool homepage: https://github.com/maiziex/Aquila"
inputs:
  - id: bam_file
    type: File
    doc: "Required parameter; BAM file, called by longranger\nalign"
    inputBinding:
      position: 101
      prefix: --bam_file
  - id: block_len_use
    type:
      - 'null'
      - int
    doc: phase block len threshold
    inputBinding:
      position: 101
      prefix: --block_len_use
  - id: block_threshold
    type:
      - 'null'
      - int
    doc: phase block threshold
    inputBinding:
      position: 101
      prefix: --block_threshold
  - id: boundary
    type:
      - 'null'
      - int
    doc: boundary for long fragments with the same barcode
    inputBinding:
      position: 101
      prefix: --boundary
  - id: chr_end
    type:
      - 'null'
      - string
    doc: chromosome end by
    inputBinding:
      position: 101
      prefix: --chr_end
  - id: chr_start
    type:
      - 'null'
      - string
    doc: chromosome start from
    inputBinding:
      position: 101
      prefix: --chr_start
  - id: mbq_threshold
    type:
      - 'null'
      - int
    doc: "phred-scaled quality score for the assertion made in\nALT"
    inputBinding:
      position: 101
      prefix: --mbq_threshold
  - id: num_threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: --num_threads
  - id: num_threads_for_extract_reads
    type:
      - 'null'
      - int
    doc: number of threads for extracting raw reads
    inputBinding:
      position: 101
      prefix: --num_threads_for_extract_reads
  - id: num_threads_for_samtools_sort
    type:
      - 'null'
      - int
    doc: number of threads for samtools sort
    inputBinding:
      position: 101
      prefix: --num_threads_for_samtools_sort
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Directory to store assembly results
    inputBinding:
      position: 101
      prefix: --out_dir
  - id: sample_name
    type: string
    doc: "Required parameter; Sample Name you can define by\nyourself, for example:
      S12878"
    inputBinding:
      position: 101
      prefix: --sample_name
  - id: uniq_map_dir
    type: Directory
    doc: Required Parameter; Directory for 100-mer uniqness, run ./install to 
      download "Uniquess_map" for hg38
    inputBinding:
      position: 101
      prefix: --uniq_map_dir
  - id: vcf_file
    type: File
    doc: Required parameter; VCF file, called by FreeBayes
    inputBinding:
      position: 101
      prefix: --vcf_file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aquila:1.0.0--py_0
stdout: aquila_Aquila_step1.out
