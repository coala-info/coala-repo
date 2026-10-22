cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sequenza-utils
  - bam2seqz
label: sequenza-utils_bam2seqz
doc: 'Process a paired set of BAM/pileup files (tumor and matching normal), and GC-content genome-wide information, to extract the common positions with A and B alleles frequencies.


  Tool homepage: http://sequenza-utils.readthedocs.org'
inputs:
  - id: pileup
    type:
      - 'null'
      - boolean
    doc: Use pileups as input files instead of BAMs.
    inputBinding:
      position: 1
      prefix: --pileup
  - id: normal
    type: File
    doc: The BAM/pileup file from the reference/normal sample.
    inputBinding:
      position: 2
      prefix: --normal
    secondaryFiles:
      - .bai?
  - id: tumor
    type: File
    doc: The BAM/pileup file from the tumor sample.
    inputBinding:
      position: 3
      prefix: --tumor
    secondaryFiles:
      - .bai?
  - id: gc
    type: File
    doc: The GC-content wiggle file.
    inputBinding:
      position: 4
      prefix: -gc
  - id: fasta
    type:
      - 'null'
      - File
    doc: The reference FASTA file used to generate the intermediate pileup. Required when input are BAM.
    inputBinding:
      position: 5
      prefix: --fasta
    secondaryFiles:
      - .fai?
  - id: output_name
    type: string
    doc: Name of the output file. To use gzip compression name the file ending in .gz. Default STDOUT.
    inputBinding:
      position: 6
      prefix: --output
  - id: normal2
    type:
      - 'null'
      - File
    doc: Optional BAM/pileup file used to compute the depth.normal and depth-ratio, instead of using the normal BAM.
    inputBinding:
      position: 7
      prefix: --normal2
    secondaryFiles:
      - .bai?
  - id: chromosome
    type:
      - 'null'
      - string[]
    doc: Restrict the input/output to chromosomes or regions (Name:pos.start-pos.end).
    inputBinding:
      position: 8
      prefix: --chromosome
  - id: parallel
    type:
      - 'null'
      - int
    doc: Number of chromosomes to run in parallel. Default 1.
    inputBinding:
      position: 9
      prefix: --parallel
  - id: samtools
    type:
      - 'null'
      - string
    doc: Path of samtools exec file. Default "samtools".
    inputBinding:
      position: 10
      prefix: --samtools
  - id: tabix
    type:
      - 'null'
      - string
    doc: Path of the tabix binary. Default "tabix".
    inputBinding:
      position: 11
      prefix: --tabix
  - id: qlimit
    type:
      - 'null'
      - int
    doc: Minimum nucleotide quality score for inclusion in the counts. Default 20.
    inputBinding:
      position: 12
      prefix: --qlimit
  - id: qformat
    type:
      - 'null'
      - string
    doc: Quality format, "sanger" or "illumina". Default "sanger".
    inputBinding:
      position: 13
      prefix: --qformat
  - id: min_total_depth
    type:
      - 'null'
      - int
    doc: Threshold to filter positions by the sum of read depth of the two samples. Default 20.
    inputBinding:
      position: 14
      prefix: -N
  - id: hom
    type:
      - 'null'
      - float
    doc: Threshold to select homozygous positions. Default 0.9.
    inputBinding:
      position: 15
      prefix: --hom
  - id: het
    type:
      - 'null'
      - float
    doc: Threshold to select heterozygous positions. Default 0.25.
    inputBinding:
      position: 16
      prefix: --het
  - id: het_f
    type:
      - 'null'
      - float
    doc: Threshold of frequency in the forward strand to trust heterozygous calls. Default -0.2 (disabled).
    inputBinding:
      position: 17
      prefix: --het_f
outputs:
  - id: output_seqz
    type: File
    doc: Output seqz file.
    outputBinding:
      glob: $(inputs.output_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequenza-utils:3.0.0--py311h8ddd9a4_8
