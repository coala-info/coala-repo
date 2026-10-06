cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bam
  - splitChromosome
label: bamutil_splitChromosome
doc: "Split BAM by Chromosome\n\nTool homepage: http://genome.sph.umich.edu/wiki/BamUtil"
inputs:
  - id: in
    type: File
    doc: the BAM file to be split
    inputBinding:
      position: 1
      prefix: --in
  - id: out
    type: string
    doc: the base filename for the SAM/BAM files to write into (CHROM.bam or CHROM.sam
      is appended)
    inputBinding:
      position: 1
      prefix: --out
  - id: bamout
    type:
      - 'null'
      - boolean
    doc: write the output files in BAM format (default).
    inputBinding:
      position: 1
      prefix: --bamout
  - id: samout
    type:
      - 'null'
      - boolean
    doc: write the output files in SAM format.
    inputBinding:
      position: 1
      prefix: --samout
  - id: noeof
    type:
      - 'null'
      - boolean
    doc: Do not expect an EOF block on a bam file.
    inputBinding:
      position: 1
      prefix: --noeof
  - id: params
    type:
      - 'null'
      - boolean
    doc: Print the parameter settings
    inputBinding:
      position: 1
      prefix: --params
  - id: no_phone_home
    type:
      - 'null'
      - boolean
    doc: Do not send usage information (phone home)
    inputBinding:
      position: 1
      prefix: --noPhoneHome
  - id: phone_home_thinning
    type:
      - 'null'
      - int
    doc: Phone home thinning percentage [50]
    inputBinding:
      position: 1
      prefix: --phoneHomeThinning
outputs:
  - id: chromosome_files
    type: File[]
    doc: One SAM/BAM file per chromosome
    outputBinding:
      glob: $(inputs.out)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
