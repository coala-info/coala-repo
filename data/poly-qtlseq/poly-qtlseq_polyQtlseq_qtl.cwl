cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - polyQtlseq
  - qtl
label: poly-qtlseq_polyQtlseq_qtl
doc: "QTL-Seq analysis from a VCF file (samples in the order Parent1, Parent2, Bulk1, Bulk2; GT and AD values required).\n\nTool homepage: https://github.com/TatsumiMizubayashi/PolyploidQtlSeq"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_vcf
    type: File
    doc: Input VCF file.
    inputBinding:
      position: 101
      prefix: --inputVcf
  - id: output_dir
    type: string
    doc: Output Directory.
    inputBinding:
      position: 101
      prefix: --outputDir
  - id: p1_most_allele_rate
    type:
      - 'null'
      - float
    doc: 'Most allele frequency for Parent1. Variants exceeding this threshold is considered homozygous. Default value is: 0.99.'
    inputBinding:
      position: 101
      prefix: --p1MostAlleleRate
  - id: p2_snp_index_range
    type:
      - 'null'
      - string
    doc: 'SNP-index range for parent2. Default value is: 0.15-0.375.'
    inputBinding:
      position: 101
      prefix: --p2SnpIndexRange
  - id: min_depth
    type:
      - 'null'
      - int
    doc: 'Minimum Depth threshold. The variants with even one sample below this threshold are excluded for QTL analysis. Default value is: 40.'
    inputBinding:
      position: 101
      prefix: --minDepth
  - id: max_bulk_snp_index
    type:
      - 'null'
      - float
    doc: 'Maximum threshold for SNP-index for the Bulk samples. Variants with a SNP-index exceeding this value are excluded. Default value is: 1.'
    inputBinding:
      position: 101
      prefix: --maxBulkSnpIndex
  - id: ploidy
    type:
      - 'null'
      - int
    doc: 'Ploidy. Default value is: 4.'
    inputBinding:
      position: 101
      prefix: --ploidy
  - id: n_plex
    type:
      - 'null'
      - int
    doc: 'Specify the plexity of Parent2 used for QTL analysis. Default value is: 1.'
    inputBinding:
      position: 101
      prefix: --NPlex
  - id: n_bulk1
    type:
      - 'null'
      - int
    doc: 'Number of Individuals in bulk1. Default value is: 20.'
    inputBinding:
      position: 101
      prefix: --NBulk1
  - id: n_bulk2
    type:
      - 'null'
      - int
    doc: 'Number of Individuals in bulk2. Default value is: 20.'
    inputBinding:
      position: 101
      prefix: --NBulk2
  - id: n_rep
    type:
      - 'null'
      - int
    doc: 'Number of simulation replicates to generate a null distribution which is free from QTLs. Default value is: 5000.'
    inputBinding:
      position: 101
      prefix: --NRep
  - id: window
    type:
      - 'null'
      - int
    doc: 'Window size (kbp) of the sliding window analysis. Default value is: 100.'
    inputBinding:
      position: 101
      prefix: --window
  - id: step
    type:
      - 'null'
      - int
    doc: 'Step size (kbp) of the sliding window analysis. Default value is: 20.'
    inputBinding:
      position: 101
      prefix: --step
  - id: fig_width
    type:
      - 'null'
      - int
    doc: 'Width (pixel) of the graph images. Default value is: 1200.'
    inputBinding:
      position: 101
      prefix: --figWidth
  - id: fig_height
    type:
      - 'null'
      - int
    doc: 'Height (pixel) of the graph images. Default value is: 300.'
    inputBinding:
      position: 101
      prefix: --figHeight
  - id: x_step
    type:
      - 'null'
      - int
    doc: 'X-axis scale interval (Mbp) of the graphs. Default value is: 5.'
    inputBinding:
      position: 101
      prefix: --xStep
  - id: display_impacts
    type:
      - 'null'
      - string
    doc: 'Annotation Impact to be included in the SNP-index file. Separate multiple items with commas. Default value is: HIGH,MODERATE.'
    inputBinding:
      position: 101
      prefix: --displayImpacts
  - id: thread
    type:
      - 'null'
      - int
    doc: 'Number of threads to use. Default value is: 20.'
    inputBinding:
      position: 101
      prefix: --thread
  - id: params_file
    type:
      - 'null'
      - File
    doc: 'Parameter file.'
    inputBinding:
      position: 101
      prefix: --paramsFile
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_directory
    type: Directory
    doc: Directory with the QTL-seq results (tables and graphs)
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poly-qtlseq:1.2.6--hdfd78af_0
stdout: poly-qtlseq_polyQtlseq_qtl.out
