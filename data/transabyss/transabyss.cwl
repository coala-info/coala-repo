cwlVersion: v1.2
class: CommandLineTool
baseCommand: transabyss
label: transabyss
doc: "De novo assembly of RNA-Seq data using ABySS at multiple k-mer sizes.\n\nTool
  homepage: http://www.bcgsc.ca/platform/bioinfo/software/trans-abyss"
inputs:
  - id: cleanup
    type:
      - 'null'
      - int
    doc: Cleanup level (0-3)
    inputBinding:
      position: 101
      prefix: --cleanup
  - id: kmer
    type: int
    doc: K-mer size
    inputBinding:
      position: 101
      prefix: --kmer
  - id: mpi
    type:
      - 'null'
      - int
    doc: Number of MPI processes
    inputBinding:
      position: 101
      prefix: --mpi
  - id: name
    type:
      - 'null'
      - string
    doc: Name of the assembly
    inputBinding:
      position: 101
      prefix: --name
  - id: pe
    type:
      - 'null'
      - type: array
        items: File
    doc: Paired-end library files
    inputBinding:
      position: 101
      prefix: --pe
  - id: se
    type:
      - 'null'
      - type: array
        items: File
    doc: Single-end library files
    inputBinding:
      position: 101
      prefix: --se
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transabyss:2.0.1--py27_4
