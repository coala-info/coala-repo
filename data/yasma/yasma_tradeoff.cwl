cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - yasma
  - tradeoff
label: yasma_tradeoff
doc: "Annotator using focused capturing the most reads in the least genomic space\n\
  \nTool homepage: https://github.com/NateyJay/YASMA"
inputs:
  - id: alignment_file
    type: File
    doc: Alignment file input (bam or cram).
    inputBinding:
      position: 101
      prefix: --alignment_file
  - id: annotation_conditions
    type:
      - 'null'
      - type: array
        items: string
    doc: List of conditions names which will be included in the annotation. 
      Defaults to use all libraries, though this is likely not what you want if 
      you have multiple groups.
    inputBinding:
      position: 101
      prefix: --annotation_conditions
  - id: bigwig
    type:
      - 'null'
      - boolean
    doc: Write coverage and kernel tracks to bigwig files. Increases run-time.
    inputBinding:
      position: 101
      prefix: --bigwig
  - id: conditions
    type:
      - 'null'
      - string
    doc: Values denoting condition groups (sets of replicate libraries) for 
      projects with multiple tissues/treatments/genotypes. Can be entered here 
      as space sparated duplexes, with the library base_name and condition 
      groups delimited by a colon. E.g. SRR1111111:WT SRR1111112:WT 
      SRR1111113:mut SRR1111114:mut
    inputBinding:
      position: 101
      prefix: --conditions
  - id: coverage_window
    type:
      - 'null'
      - int
    doc: This is the bandwidth for accumulating read alignments into coverage, 
      which is used instead of the normal read length. By default, this is very 
      large (250 nt), basically meaning that depth summed across 250 nt windows 
      are used for region annotation.
    default: 250
    inputBinding:
      position: 101
      prefix: --coverage_window
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug flag
    inputBinding:
      position: 101
      prefix: --debug
  - id: dont_revise_regions
    type:
      - 'null'
      - boolean
    doc: Argument to skip revising regions step.
    inputBinding:
      position: 101
      prefix: --dont_revise_regions
  - id: dont_trim_loci
    type:
      - 'null'
      - boolean
    doc: Argument to skip final trim of annotated loci.
    inputBinding:
      position: 101
      prefix: --dont_trim_loci
  - id: filter_abundance
    type:
      - 'null'
      - boolean
    doc: filter low abundance loci. This is meant to remove loci which have not 
      reached an absolute level of abundance.
    default: true
    inputBinding:
      position: 101
      prefix: --filter_abundance
  - id: filter_abundance_density
    type:
      - 'null'
      - boolean
    doc: filter low abundance loci. This is meant to remove loci which have not 
      reached an absolute level of abundance.
    default: true
    inputBinding:
      position: 101
      prefix: --filter_abundance_density
  - id: filter_complexity
    type:
      - 'null'
      - boolean
    doc: filter low complexity loci
    default: true
    inputBinding:
      position: 101
      prefix: --filter_complexity
  - id: filter_skew
    type:
      - 'null'
      - boolean
    doc: filter highly skewed loci
    default: false
    inputBinding:
      position: 101
      prefix: --filter_skew
  - id: genome_scaling_factor
    type:
      - 'null'
      - float
    doc: genome_scaling_factor
    inputBinding:
      position: 101
      prefix: --genome_scaling_factor
  - id: kernel_window
    type:
      - 'null'
      - int
    doc: This is a max filter for the coverage, which extends coverages by a 
      default 250 nt. This is built-in padding for regions, which will then be 
      revised to find boundaries.
    default: 250
    inputBinding:
      position: 101
      prefix: --kernel_window
  - id: max_length
    type:
      - 'null'
      - int
    doc: The same as above, but with a max length.
    inputBinding:
      position: 101
      prefix: --max_length
  - id: max_skew
    type:
      - 'null'
      - float
    doc: Filter value for loci which are skewed toward only one sequence in 
      abundance. By default (0.95), if more than 1 in 20 reads for a locus are a
      single sequence, they are excluded from the annotation.
    default: 0.95
    inputBinding:
      position: 101
      prefix: --max_skew
  - id: merge_dist
    type:
      - 'null'
      - int
    doc: Distance in nucleotides for which sRNA peaks should be considered for 
      'clumping'. Clumped regions must have sufficient similarity in sRNA-size 
      profile and strand-preference. Default 500 nt.
    default: 500
    inputBinding:
      position: 101
      prefix: --merge_dist
  - id: merge_strand_similarity
    type:
      - 'null'
      - float
    doc: Similarity threshold of strand fraction for clumping two peaks. 
      Difference in fraction must be smaller than threshold. Default 0.5.
    default: 0.5
    inputBinding:
      position: 101
      prefix: --merge_strand_similarity
  - id: min_abundance
    type:
      - 'null'
      - int
    doc: Min reads in a locus
    default: 50
    inputBinding:
      position: 101
      prefix: --min_abundance
  - id: min_abundance_density
    type:
      - 'null'
      - int
    doc: Min of (default 100) reads per 1000 nucleotides in a locus.
    default: 100
    inputBinding:
      position: 101
      prefix: --min_abundance_density
  - id: min_complexity
    type:
      - 'null'
      - int
    doc: Filter value for locus complexity. This is defined as the minimum 
      number of unique- reads / 1000 nt
    default: 10
    inputBinding:
      position: 101
      prefix: --min_complexity
  - id: min_length
    type:
      - 'null'
      - int
    doc: An override filter to ignore aligned reads which are smaller than a min
      length in locus calculations.
    inputBinding:
      position: 101
      prefix: --min_length
  - id: name
    type:
      - 'null'
      - string
    doc: Optional name for annotation. Useful if comparing annotations.
    inputBinding:
      position: 101
      prefix: --name
  - id: no_filter_abundance
    type:
      - 'null'
      - boolean
    doc: filter low abundance loci. This is meant to remove loci which have not 
      reached an absolute level of abundance.
    default: true
    inputBinding:
      position: 101
      prefix: --no_filter_abundance
  - id: no_filter_abundance_density
    type:
      - 'null'
      - boolean
    doc: filter low abundance loci. This is meant to remove loci which have not 
      reached an absolute level of abundance.
    default: true
    inputBinding:
      position: 101
      prefix: --no_filter_abundance_density
  - id: no_filter_complexity
    type:
      - 'null'
      - boolean
    doc: filter low complexity loci
    default: true
    inputBinding:
      position: 101
      prefix: --no_filter_complexity
  - id: no_filter_skew
    type:
      - 'null'
      - boolean
    doc: filter highly skewed loci
    default: false
    inputBinding:
      position: 101
      prefix: --no_filter_skew
  - id: output_directory
    type: Directory
    doc: Directory name for annotation output. Defaults to the current 
      directory, with this directory name as the project name.
    inputBinding:
      position: 101
      prefix: --output_directory
  - id: override
    type:
      - 'null'
      - boolean
    doc: Overrides config file changes without prompting.
    inputBinding:
      position: 101
      prefix: --override
  - id: test_mode
    type:
      - 'null'
      - boolean
    doc: test_mode flag
    inputBinding:
      position: 101
      prefix: --test_mode
  - id: time_test
    type:
      - 'null'
      - boolean
    doc: Shows time test statistics for difference parts of the pipeline.
    inputBinding:
      position: 101
      prefix: --time_test
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yasma:1.1.0--pyh7e72e81_0
stdout: yasma_tradeoff.out
