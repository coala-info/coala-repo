cwlVersion: v1.2
class: CommandLineTool
baseCommand: RiboCode_onestep
label: ribocode_RiboCode_onestep
doc: "The function contains the steps to prepare a reference genome, to determinate\n\
  the P-site locations and to detect ORFs. It automatically creates some of the\n\
  output files.\n\nTool homepage: https://github.com/xryanglab/RiboCode"
inputs:
  - id: gtf_file
    type: File
    doc: Default, suitable for GENCODE and ENSEMBL GTF file
    inputBinding:
      position: 101
      prefix: --gtf
  - id: genome_fasta
    type: File
    doc: The genome sequences file in fasta format.
    inputBinding:
      position: 101
      prefix: --fasta
      valueFrom: $(self.basename)
  - id: rpf_mapping_file
    type:
      - 'null'
      - File
    doc: ribo-seq BAM/SAM file aligned to the transcriptome.
    inputBinding:
      position: 101
      prefix: --rpf_mapping_file
  - id: input_file
    type:
      - 'null'
      - File
    doc: the file list the ribo-seq BAM/SAM files aligned to the transcriptome.
    inputBinding:
      position: 101
      prefix: --input_file
  - id: stranded
    type:
      - 'null'
      - string
    doc: whether the data is strand-specific (yes, reverse or no), reverse means 
      reversed strand interpretation.(default yes)
    inputBinding:
      position: 101
      prefix: --stranded
  - id: minimum_length
    type:
      - 'null'
      - int
    doc: minimum read length for metaplots analysis, default 24
    inputBinding:
      position: 101
      prefix: --minimum-length
  - id: maximum_length
    type:
      - 'null'
      - int
    doc: maximum read length for metaplots analysis, default 36
    inputBinding:
      position: 101
      prefix: --maximum-length
  - id: frame0_percent
    type:
      - 'null'
      - float
    doc: proportion threshold of reads in frame0. For automatically predicting 
      P-site location, default 0.65
    inputBinding:
      position: 101
      prefix: --frame0_percent
  - id: longest_orf
    type:
      - 'null'
      - string
    doc: Default yes, the region from most distal AUG to stop was defined as an 
      ORF. If set to no, the position of start codon will be automatically 
      determined by program.
    inputBinding:
      position: 101
      prefix: --longest-orf
  - id: pval_cutoff
    type:
      - 'null'
      - float
    doc: P-value cutoff for ORF filtering, default 0.05
    inputBinding:
      position: 101
      prefix: --pval-cutoff
  - id: start_codon
    type:
      - 'null'
      - string
    doc: The canonical start codon. default ATG
    inputBinding:
      position: 101
      prefix: --start_codon
  - id: alt_start_codons
    type:
      - 'null'
      - string
    doc: The alternative start codon, such as CTG,GTG, default None. Multiple 
      codons should be separated by comma.
    inputBinding:
      position: 101
      prefix: --alt_start_codons
  - id: stop_codon
    type:
      - 'null'
      - string
    doc: Stop codon, default TAA,TAG,TGA
    inputBinding:
      position: 101
      prefix: --stop_codon
  - id: transl_table
    type:
      - 'null'
      - int
    doc: ORF translation table (default 1).
    inputBinding:
      position: 101
      prefix: --transl_table
  - id: min_aa_length
    type:
      - 'null'
      - int
    doc: The minimal length of predicted peptides, default 20
    inputBinding:
      position: 101
      prefix: --min-AA-length
  - id: dependence_test
    type:
      - 'null'
      - string
    doc: the method for measuring the dependence between frame1 and frame2 
      (none, mic or pcc)
    inputBinding:
      position: 101
      prefix: --dependence_test
  - id: stouffer_adj
    type:
      - 'null'
      - string
    doc: the method for adjustment the combined p-values (none, nyholt, liji, 
      gao or galwey)
    inputBinding:
      position: 101
      prefix: --stouffer_adj
  - id: pval_adj
    type:
      - 'null'
      - string
    doc: the method used to correct p-values for multiple testing. default 
      fdr_bh (Benjamini/Hochberg)
    inputBinding:
      position: 101
      prefix: --pval_adj
  - id: output_name
    type:
      - 'null'
      - string
    doc: 'output file name, default: final_result'
    inputBinding:
      position: 101
      prefix: --output-name
  - id: output_gtf
    type:
      - 'null'
      - boolean
    doc: output the gtf file of predicted ORFs
    inputBinding:
      position: 101
      prefix: --output-gtf
  - id: output_bed
    type:
      - 'null'
      - boolean
    doc: output the bed file of predicted ORFs
    inputBinding:
      position: 101
      prefix: --output-bed
outputs:
  - id: orf_results
    type:
      type: array
      items: File
    doc: Predicted ORF tables, GTF and BED files (name prefix from --output-name, default final_result)
    outputBinding:
      glob: "$(inputs.output_name ? inputs.output_name : 'final_result')*"
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.genome_fasta)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribocode:1.2.15--pyhdc42f0e_1
stdout: ribocode_RiboCode_onestep.out
