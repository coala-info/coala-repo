cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - maq
  - simulate
label: maq_simulate
doc: "Simulate reads by randomly generating sequencing errors\n\nTool homepage: http://maq.sourceforge.net/"
inputs:
  - id: read1_out
    type: string
    doc: Output file for the first reads
    inputBinding:
      position: 1
  - id: read2_out
    type: string
    doc: Output file for the second reads
    inputBinding:
      position: 2
  - id: ref_fasta
    type: File
    doc: Reference FASTA
    inputBinding:
      position: 3
  - id: simupar_dat
    type: File
    doc: Simulation parameter file from maq simutrain
    inputBinding:
      position: 4
  - id: outer_distance
    type:
      - 'null'
      - int
    doc: Outer distance between the two ends
    inputBinding:
      position: 105
      prefix: -d
  - id: std_deviation
    type:
      - 'null'
      - int
    doc: Standard deviation
    inputBinding:
      position: 105
      prefix: -s
  - id: num_read_pairs
    type:
      - 'null'
      - int
    doc: Number of read pairs
    inputBinding:
      position: 105
      prefix: -N
  - id: length_first_read
    type:
      - 'null'
      - int
    doc: Length of the first read
    inputBinding:
      position: 105
      prefix: '-1'
  - id: length_second_read
    type:
      - 'null'
      - int
    doc: Length of the second read
    inputBinding:
      position: 105
      prefix: '-2'
  - id: mutation_rate
    type:
      - 'null'
      - float
    doc: Rate of mutations
    inputBinding:
      position: 105
      prefix: -r
  - id: indel_fraction
    type:
      - 'null'
      - float
    doc: Fraction of 1bp indels
    inputBinding:
      position: 105
      prefix: -R
  - id: haploid
    type:
      - 'null'
      - boolean
    doc: Haploid mode
    inputBinding:
      position: 105
      prefix: -h
outputs:
  - id: output_read1
    type: File
    doc: Simulated first reads
    outputBinding:
      glob: $(inputs.read1_out)
  - id: output_read2
    type: File
    doc: Simulated second reads
    outputBinding:
      glob: $(inputs.read2_out)
  - id: stdout
    type: stdout
    doc: Standard output (true mutations)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maq:v0.7.1-8-deb_cv1
stdout: maq_simulate.out
