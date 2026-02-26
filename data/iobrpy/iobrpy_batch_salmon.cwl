cwlVersion: v1.2
class: CommandLineTool
baseCommand: iobrpy batch_salmon
label: iobrpy_batch_salmon
doc: "Run Salmon in batch mode on multiple samples.\n\nTool homepage: https://github.com/IOBR/IOBRpy"
inputs:
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Number of concurrent samples (processes)
    inputBinding:
      position: 101
      prefix: --batch_size
  - id: gtf
    type:
      - 'null'
      - File
    doc: Optional GTF file path for Salmon (-g)
    inputBinding:
      position: 101
      prefix: --gtf
  - id: index
    type: Directory
    doc: Path to Salmon index
    inputBinding:
      position: 101
      prefix: --index
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Threads per Salmon process
    inputBinding:
      position: 101
      prefix: --num_threads
  - id: path_fq
    type: Directory
    doc: Directory containing FASTQ files
    inputBinding:
      position: 101
      prefix: --path_fq
  - id: suffix1
    type:
      - 'null'
      - string
    doc: R1 suffix; R2 inferred by replacing '1' with '2'
    inputBinding:
      position: 101
      prefix: --suffix1
outputs:
  - id: path_out
    type: Directory
    doc: Output directory for per-sample results
    outputBinding:
      glob: $(inputs.path_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
