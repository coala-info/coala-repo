cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtftools
label: gtftools
doc: "GTF file: only ENSEMBL or GENCODE GTF file accepted\n\nTool homepage: https://github.com/RacconC/gtftools"
inputs:
  - id: gtf_file
    type: File
    doc: 'GTF file: only ENSEMBL or GENCODE GTF file accepted'
    inputBinding:
      position: 1
  - id: chromosomes
    type:
      - 'null'
      - string
    doc: chromosome list to analyze. Chromosomes can be separated by comma(,) or
      dash(-). For example, '-c 1-5,X,Y' means chromosomes 1 to 5 plus X and Y.
    inputBinding:
      position: 102
      prefix: --chroms
  - id: cis
    type:
      - 'null'
      - string
    doc: -f specifies the upstream and downstream distance used to calculate 
      cis-range of a gene. -f is specified in the format of 'distup-distdown', 
      where distup represent the upstream distance from TSS and distdown means 
      the downstream distance from the end of the gene. Note that this parameter
      takes effect only when the '-g' option is used. For example, using 'python
      gtftools.py -g gene.bed -f 2000-1000 demo.gtf' means that 2000 bases 
      upstream and 1000 bases downstream of the gene will be clculated as the 
      cis-range and the cis-range will be output to the gene.bed file. By 
      default, -f is set to 0-0, indicating that cis-range will not be 
      calculated when using -g to calculate gene information.
    inputBinding:
      position: 102
      prefix: --cis
  - id: snp
    type:
      - 'null'
      - File
    doc: An input file containing a list of SNPs with at least three columns, 
      with the first being chromosome and the second being coordinate and the 
      third being SNP names such as rs ID number. With this option, GTFtools 
      will search for and output cis-SNPs for each gene annotated in the 
      provided GTF file.
    inputBinding:
      position: 102
      prefix: --snp
  - id: window_size
    type:
      - 'null'
      - string
    doc: "w specifies the upstream and downstream distance from TSS as described in
      '-t'. w is specified in the format of 'wup-wdown', where wup and wdown represent
      the upstream and downstream distance of TSS. Default w = 1000-300 (that is,
      1000 bases upstream of TSS and 300 bases downstream of TSS). This range is based
      on promoter regions used in the dbSNP database based on ref: Genome-wide promoter
      extraction and analysis in human, mouse, and rat, Genome Biology, 2005."
    inputBinding:
      position: 102
      prefix: --window
outputs:
  - id: merged_exon
    type:
      - 'null'
      - File
    doc: output file name for outputing merged exons from all isoforms of a gene
      in bed format
    outputBinding:
      glob: $(inputs.merged_exon)
  - id: exon
    type:
      - 'null'
      - File
    doc: output file name for exon coordination of splice isoforms in bed format
    outputBinding:
      glob: $(inputs.exon)
  - id: intron
    type:
      - 'null'
      - File
    doc: output file name for outputing intron coordination of splice isoforms 
      in bed format
    outputBinding:
      glob: $(inputs.intron)
  - id: independent_intron
    type:
      - 'null'
      - File
    doc: output file name for outputing independent intron coordination of 
      genes. Independent introns refer to those introns that do not overlap with
      any exon of isoforms. It is calcualted by merging all exons of a 
      chromosome followed by substracting them from gene regions.
    outputBinding:
      glob: $(inputs.independent_intron)
  - id: intergenic_region
    type:
      - 'null'
      - File
    doc: output file name for coordinates of intergenic regions, which is 
      calculated by subtracting gene regions from each chromosome.
    outputBinding:
      glob: $(inputs.intergenic_region)
  - id: gene_length
    type:
      - 'null'
      - File
    doc: output file name for gene length. Four types of gene lengths are 
      calculated. The first three are the mean, median, and max length of the 
      isoforms of a gene. The fourth is the length of the non-overlapping exons 
      of all isoforms.
    outputBinding:
      glob: $(inputs.gene_length)
  - id: isoform_length
    type:
      - 'null'
      - File
    doc: output file name for isoform length file. Isoform length is calculated 
      as the summed length of its exons
    outputBinding:
      glob: $(inputs.isoform_length)
  - id: masked_intron
    type:
      - 'null'
      - File
    doc: output file name for the intron that overlaps with exons of other 
      isoforms/genes
    outputBinding:
      glob: $(inputs.masked_intron)
  - id: utr
    type:
      - 'null'
      - File
    doc: output file name for UTR regions
    outputBinding:
      glob: $(inputs.utr)
  - id: isoform
    type:
      - 'null'
      - File
    doc: output file name for isoform coordinates and names.
    outputBinding:
      glob: $(inputs.isoform)
  - id: splice_site
    type:
      - 'null'
      - File
    doc: "output file name for 5' or 3' splice site in bed format. The region is based
      on MaxEntScan: the 5' donor site is 9 bases long with 3 bases in exon and 6
      bases in intron, and the 3' acceptor site is 23 bases long with 20 bases in
      the intron and 3 bases in the exon."
    outputBinding:
      glob: $(inputs.splice_site)
  - id: gene
    type:
      - 'null'
      - File
    doc: output file name for gene coordinates and names. If cis-range of the 
      gene needs to be calculated, users can include the -f option to sepcify 
      cis-range.
    outputBinding:
      glob: $(inputs.gene)
  - id: tss
    type:
      - 'null'
      - File
    doc: output file name for a region flanking transcription start site (TSS). 
      It is calculated as (TSS- wup,TSS+wdown) where wup is a user-specified 
      distance, say 1000bp, upstream of TSS, wdown is the distance downstream of
      TSS. wup and wdown is defined by the w parameter specified by '-w'.
    outputBinding:
      glob: $(inputs.tss)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtftools:0.9.0--pyh5e36f6f_0
