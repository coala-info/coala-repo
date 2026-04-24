cwlVersion: v1.2
class: CommandLineTool
baseCommand: PolyploidQtlSeq
label: poly-qtlseq_polyQtlseq
doc: "Run the Polyploid QTL-seq pipeline.\n\nTool homepage: https://github.com/TatsumiMizubayashi/PolyploidQtlSeq"
inputs:
  - id: adjust_mapping_quality
    type:
      - 'null'
      - int
    doc: Value for adjust mapping quality at variant detection in bcftools 
      mpileup. Specify 0, to disable this function.
    inputBinding:
      position: 101
      prefix: --adjustMQ
  - id: bulk1_directory
    type:
      - 'null'
      - Directory
    doc: Bulk1 Directory.
    inputBinding:
      position: 101
      prefix: --bulk1
  - id: bulk2_directory
    type:
      - 'null'
      - Directory
    doc: Bulk2 Directory.
    inputBinding:
      position: 101
      prefix: --bulk2
  - id: chromosome_names
    type:
      - 'null'
      - string
    doc: Specify the chromosome name to be analyzed. If there are more than one,
      separate them with commas.
    inputBinding:
      position: 101
      prefix: --chrNames
  - id: chromosome_size_threshold
    type:
      - 'null'
      - int
    doc: Threshold for length of chromosomes to be analyzed. Chromosomes with a 
      length more than this value are analyzed.
    inputBinding:
      position: 101
      prefix: --chrSize
  - id: display_impacts
    type:
      - 'null'
      - string
    doc: Annotation Impact to be included in the SNP-index file. Separate 
      multiple items with commas.
    inputBinding:
      position: 101
      prefix: --displayImpacts
  - id: figure_height
    type:
      - 'null'
      - int
    doc: Height (pixel) of the graph images.
    inputBinding:
      position: 101
      prefix: --figHeight
  - id: figure_width
    type:
      - 'null'
      - int
    doc: Width (pixel) of the graph images.
    inputBinding:
      position: 101
      prefix: --figWidth
  - id: max_bulk_snp_index
    type:
      - 'null'
      - float
    doc: Maximum threshold for SNP-index for the Bulk samples. Variants with a 
      SNP-index exceeding this value are excluded.
    inputBinding:
      position: 101
      prefix: --maxBulkSnpIndex
  - id: min_base_quality
    type:
      - 'null'
      - int
    doc: Minimum base quality at variant detection in bcftools mpileup.
    inputBinding:
      position: 101
      prefix: --minBQ
  - id: min_depth
    type:
      - 'null'
      - int
    doc: Minimum Depth threshold. The variants with even one sample below this 
      threshold are excluded for QTL analysis.
    inputBinding:
      position: 101
      prefix: --minDepth
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: Minimum mapping quality at variant detection in bcftools mpileup.
    inputBinding:
      position: 101
      prefix: --minMQ
  - id: n_bulk1
    type:
      - 'null'
      - int
    doc: Number of Individuals in bulk1.
    inputBinding:
      position: 101
      prefix: --NBulk1
  - id: n_bulk2
    type:
      - 'null'
      - int
    doc: Number of Individuals in bulk2.
    inputBinding:
      position: 101
      prefix: --NBulk2
  - id: n_rep
    type:
      - 'null'
      - int
    doc: Number of simulation replicates to generate a null distribution which 
      is free from QTLs.
    inputBinding:
      position: 101
      prefix: --NRep
  - id: np_lex
    type:
      - 'null'
      - int
    doc: Specify the plexity of Parent2 used for QTL analysis.
    inputBinding:
      position: 101
      prefix: --NPlex
  - id: p1_most_allele_rate
    type:
      - 'null'
      - float
    doc: Most allele frequency for Parent1. Variants exceeding this threshold is
      considered homozygous.
    inputBinding:
      position: 101
      prefix: --p1MostAlleleRate
  - id: p2_snp_index_range
    type:
      - 'null'
      - string
    doc: SNP-index range for parent2.
    inputBinding:
      position: 101
      prefix: --p2SnpIndexRange
  - id: parameters_file
    type:
      - 'null'
      - File
    doc: Parameter file.
    inputBinding:
      position: 101
      prefix: --paramsFile
  - id: parent1_directory
    type:
      - 'null'
      - Directory
    doc: Parent1 Directory.
    inputBinding:
      position: 101
      prefix: --parent1
  - id: parent2_directory
    type:
      - 'null'
      - Directory
    doc: Parent2 Directory.
    inputBinding:
      position: 101
      prefix: --parent2
  - id: ploidy
    type:
      - 'null'
      - int
    doc: Ploidy.
    inputBinding:
      position: 101
      prefix: --ploidy
  - id: reference_sequence
    type:
      - 'null'
      - File
    doc: Reference sequence file.
    inputBinding:
      position: 101
      prefix: --refSeq
  - id: snp_eff_config
    type:
      - 'null'
      - File
    doc: snpEff.config file. Not required if snpEff default config file is used.
    inputBinding:
      position: 101
      prefix: --snpEffConfig
  - id: snp_eff_database
    type:
      - 'null'
      - string
    doc: SnpEff database name.
    inputBinding:
      position: 101
      prefix: --snpEffDatabase
  - id: snp_eff_max_heap
    type:
      - 'null'
      - string
    doc: SnpEff maximum heap size (GB).
    inputBinding:
      position: 101
      prefix: --snpEffMaxHeap
  - id: step_size
    type:
      - 'null'
      - int
    doc: Step size (kbp) of the sliding window analysis.
    inputBinding:
      position: 101
      prefix: --step
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 101
      prefix: --thread
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size (kbp) of the sliding window analysis.
    inputBinding:
      position: 101
      prefix: --window
  - id: x_axis_step
    type:
      - 'null'
      - int
    doc: X-axis scale interval (Mbp) of the graphs.
    inputBinding:
      position: 101
      prefix: --xStep
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output Directory.
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poly-qtlseq:1.2.6--hdfd78af_0
