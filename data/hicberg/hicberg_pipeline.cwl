cwlVersion: v1.2
class: CommandLineTool
baseCommand: hicberg pipeline
label: hicberg_pipeline
doc: "Hi-C pipeline to generate enhanced contact matrix from fastq files.\n\nTool
  homepage: https://github.com/sebgra/hicberg"
inputs:
  - id: genome
    type: string
    doc: Index of the genome.
    inputBinding:
      position: 1
  - id: input1
    type: File
    doc: Input fastq file 1
    inputBinding:
      position: 2
  - id: input2
    type: File
    doc: Input fastq file 2
    inputBinding:
      position: 3
  - id: analysis_name
    type:
      - 'null'
      - string
    doc: Name of the analysis.
    inputBinding:
      position: 104
      prefix: --name
  - id: blacklist
    type:
      - 'null'
      - string
    doc: Blacklisted coordintaes to exclude reads for statistical learning. 
      Provide either a bed file or a list of coordinates coma separated using 
      UCSC format.
    inputBinding:
      position: 104
      prefix: --blacklist
  - id: bowtie2_sensitivity
    type:
      - 'null'
      - string
    doc: Set sensitivity level for Bowtie2.
    inputBinding:
      position: 104
      prefix: --sensitivity
  - id: circular_chromosome
    type:
      - 'null'
      - string
    doc: Name of the chromosome to consider as circular.
    inputBinding:
      position: 104
      prefix: --circular
  - id: cpus
    type:
      - 'null'
      - int
    doc: Threads to use for analysis.
    inputBinding:
      position: 104
      prefix: --cpus
  - id: deviation
    type:
      - 'null'
      - float
    doc: Standard deviation for contact density estimation.
    inputBinding:
      position: 104
      prefix: --deviation
  - id: enzymes
    type:
      - 'null'
      - string
    doc: Enzymes to use for genome digestion.
    inputBinding:
      position: 104
      prefix: --enzyme
  - id: exit_stage
    type:
      - 'null'
      - string
    doc: Stage to exit the pipeline.
    inputBinding:
      position: 104
      prefix: --exit-stage
  - id: force_delete
    type:
      - 'null'
      - boolean
    doc: Set if previous analysis files are deleted.
    inputBinding:
      position: 104
      prefix: --force
  - id: genomic_resolution
    type:
      - 'null'
      - int
    doc: Genomic resolution.
    inputBinding:
      position: 104
      prefix: --bins
  - id: kernel_size
    type:
      - 'null'
      - int
    doc: Size of the gaussian kernel for contact density estimation.
    inputBinding:
      position: 104
      prefix: --kernel-size
  - id: max_alignments
    type:
      - 'null'
      - int
    doc: Set the number of alignments to report in ambiguous reads case. Value 
      of -1 reports all alignments.
    inputBinding:
      position: 104
      prefix: --max-alignment
  - id: max_distance
    type:
      - 'null'
      - int
    doc: Maximum distance beyond which pairs are discarded in omics mode.
    inputBinding:
      position: 104
      prefix: --distance
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Minimum mapping quality to consider a read as valid.
    inputBinding:
      position: 104
      prefix: --mapq
  - id: start_stage
    type:
      - 'null'
      - string
    doc: Stage to start the pipeline.
    inputBinding:
      position: 104
      prefix: --start-stage
  - id: statistical_model
    type:
      - 'null'
      - string
    doc: Statistical model to use for ambiguous reads assignment.
    inputBinding:
      position: 104
      prefix: --mode
  - id: subsampling_rate
    type:
      - 'null'
      - float
    doc: Rate to use for sub-sampling restriction map.
    inputBinding:
      position: 104
      prefix: --rate
outputs:
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: Output folder to save results.
    outputBinding:
      glob: $(inputs.output_folder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicberg:1.0.1--py312hcf36b3e_0
