cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - methurator
  - downsample
label: methurator_downsample
doc: "Downsample BAM files and estimate sequencing saturation.\n\nTool homepage: https://github.com/VIBTOBIlab/methurator"
inputs:
  - id: bams
    type:
      type: array
      items: File
    doc: Path to a single .bam file or to multiple ones (e.g. files/*.bam).
    inputBinding:
      position: 1
  - id: downsampling_percentages
    type:
      - 'null'
      - string
    doc: Percentages used to downsample the .bam file.
    default: 0.1,0.25,0.5,0.75
    inputBinding:
      position: 102
      prefix: --downsampling-percentages
  - id: fasta
    type:
      - 'null'
      - File
    doc: Fasta file of the reference genome used to align the samples. If not 
      provided, it will download it according to the specified genome.
    inputBinding:
      position: 102
      prefix: --fasta
  - id: genome
    type:
      - 'null'
      - string
    doc: Genome used to align the samples (hg19|hg38|GRCh37|GRCh38|mm10|mm39).
    inputBinding:
      position: 102
      prefix: --genome
  - id: keep_temporary_files
    type:
      - 'null'
      - boolean
    doc: If set to True, temporary files will be kept after the analysis.
    default: false
    inputBinding:
      position: 102
      prefix: --keep-temporary-files
  - id: minimum_coverage
    type:
      - 'null'
      - string
    doc: Minimum CpG coverage to estimate sequencing saturation. It can be 
      either a single integer or a list of integers (e.g 1,3,5).
    default: '3'
    inputBinding:
      position: 102
      prefix: --minimum-coverage
  - id: no_rrbs
    type:
      - 'null'
      - boolean
    doc: Disable RRBS mode.
    inputBinding:
      position: 102
      prefix: --no-rrbs
  - id: rrbs
    type:
      - 'null'
      - boolean
    doc: If set to True, MethylDackel extract will consider the RRBS nature of 
      the data adding the --keepDupes flag.
    default: true
    inputBinding:
      position: 102
      prefix: --rrbs
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use. Default: all available threads - 2.'
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose logging.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Default ./output directory.
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methurator:2.1.1--pyhdfd78af_0
