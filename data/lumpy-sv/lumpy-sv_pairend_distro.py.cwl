cwlVersion: v1.2
class: CommandLineTool
baseCommand: pairend_distro.py
label: lumpy-sv_pairend_distro.py
doc: "Estimate the insert size distribution of a paired-end library from SAM records read on standard input; prints mean and stdev and writes the histogram used by LUMPY.\n\nTool homepage: https://github.com/arq5x/lumpy-sv"
inputs:
  - id: sam_file
    type: File
    doc: SAM records (no header needed), for example made with samtools view
  - id: read_length
    type: int
    doc: Read length
    inputBinding:
      position: 1
      prefix: -r
  - id: stdevs_to_extend
    type:
      - 'null'
      - int
    doc: Number of stdevs from mean to extend
    inputBinding:
      position: 1
      prefix: -X
  - id: num_sample
    type:
      - 'null'
      - int
    doc: Number to sample
    inputBinding:
      position: 1
      prefix: -N
  - id: output_file
    type: string
    doc: Output histogram file
    inputBinding:
      position: 1
      prefix: -o
  - id: mads
    type:
      - 'null'
      - float
    doc: Outlier cutoff in number of median absolute deviations (unscaled, upper only)
    inputBinding:
      position: 1
      prefix: -m
outputs:
  - id: histogram
    type: File
    doc: Insert size histogram
    outputBinding:
      glob: $(inputs.output_file)
  - id: insert_stats
    type: stdout
    doc: Mean and standard deviation of the insert size (mean:X stdev:Y)
stdin: $(inputs.sam_file.path)
stdout: insert_stats.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lumpy-sv:0.3.1--3
