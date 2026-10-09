cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hicberg
  - alignment
label: hicberg_alignment
doc: 'Perform alignment of Hi-C reads.


  Tool homepage: https://github.com/sebgra/hicberg'
inputs:
  - id: genome
    type: File
    doc: Genome FASTA file.
    inputBinding:
      position: 1
  - id: input1
    type: File
    doc: Forward Hi-C reads (FASTQ, may be gzipped).
    inputBinding:
      position: 2
  - id: input2
    type: File
    doc: Reverse Hi-C reads (FASTQ, may be gzipped).
    inputBinding:
      position: 3
  - id: output_folder
    type: Directory
    doc: Result folder created by hicberg create-folder (and filled by the earlier
      stages). It is staged writable; the stage adds its files to it.
    inputBinding:
      position: 100
      prefix: --output
      valueFrom: $(runtime.outdir)/$(inputs.output_folder.basename)
  - id: index
    type:
      - 'null'
      - string
    doc: 'Index of the genome: name of the Bowtie2 index inside the result folder
      (for example the genome file stem). If not set, the index is built.'
    inputBinding:
      position: 104
      prefix: --index
  - id: sensitivity
    type:
      - 'null'
      - string
    doc: Set sensitivity level for Bowtie2 (very-sensitive, sensitive, fast, very-fast).
    inputBinding:
      position: 104
      prefix: --sensitivity
  - id: max_alignment
    type:
      - 'null'
      - int
    doc: Set the number of alignments to report in ambiguous reads case. If set to
      -1, all alignments are reported.
    inputBinding:
      position: 104
      prefix: --max-alignment
  - id: cpus
    type:
      - 'null'
      - int
    doc: Threads to use for analysis.
    inputBinding:
      position: 104
      prefix: --cpus
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Set verbosity level.
    inputBinding:
      position: 104
      prefix: --verbose
outputs:
  - id: output_folder_out
    type: Directory
    doc: The same result folder with the files this stage wrote.
    outputBinding:
      glob: $(inputs.output_folder.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.output_folder)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicberg:1.0.1--py312hcf36b3e_0
