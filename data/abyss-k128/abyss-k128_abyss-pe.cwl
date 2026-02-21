cwlVersion: v1.2
class: CommandLineTool
baseCommand: abyss-pe
label: abyss-k128_abyss-pe
doc: "ABySS is a de novo, parallel, paired-end sequence assembler. abyss-pe is the
  driver script for the assembly pipeline.\n\nTool homepage: http://www.bcgsc.ca/platform/bioinfo/software/abyss"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files (e.g., in='reads1.fa reads2.fa').
    inputBinding:
      position: 101
      prefix: in
  - id: kmer_size
    type: int
    doc: The size of a k-mer (the length of individual overlapping units).
    inputBinding:
      position: 101
      prefix: k
  - id: lib
    type:
      - 'null'
      - string
    doc: A space-separated list of paired-end library names.
    inputBinding:
      position: 101
      prefix: lib
  - id: mp
    type:
      - 'null'
      - string
    doc: A space-separated list of mate-pair library names.
    inputBinding:
      position: 101
      prefix: mp
  - id: name
    type: string
    doc: The name of this assembly. The resulting scaffolds will be stored in ${name}-scaffolds.fa.
    inputBinding:
      position: 101
      prefix: name
  - id: np
    type:
      - 'null'
      - int
    doc: Number of processes for MPI.
    inputBinding:
      position: 101
      prefix: np
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 101
      prefix: j
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/abyss-k128:2.0.2--boost1.64_2
stdout: abyss-k128_abyss-pe.out
