cwlVersion: v1.2
class: CommandLineTool
baseCommand: mimseq
label: mimseq
doc: "Modification-induced misincorporation analysis of tRNA sequencing data\n\nTool
  homepage: https://github.com/nedialkova-lab/mim-tRNAseq"
inputs:
  - id: sample_data
    type: string
    doc: 'Sample data sheet in text format, tab-separated. Column 1: full path to
      fastq (or fastq.gz). Column 2: condition/group.'
    inputBinding:
      position: 1
  - id: cluster_id
    type:
      - 'null'
      - float
    doc: Identity cutoff for usearch clustering between 0 and 1. Default is 
      0.97.
    default: 0.97
    inputBinding:
      position: 102
  - id: control_condition
    type: string
    doc: Name of control/wild-type condition as per user defined group specified
      in sample data input. This must exactly match the group name specified in 
      sample data. This is used for differential expression analysis so that 
      results are always in the form mutant/treatment vs WT/control. REQUIRED
    inputBinding:
      position: 102
  - id: crosstalks
    type:
      - 'null'
      - boolean
    doc: 'Enable analysis of crosstalks between pairs of modifications and modification-charging.
      Full details of this method in: https://doi.org/10.1093/nar/gkac1185'
    inputBinding:
      position: 102
  - id: deconv_cov_ratio
    type:
      - 'null'
      - float
    doc: Threshold for ratio between coverage at 3' end and mismatch used for 
      deconvolution. Coverage reductions greater than the threshold will result 
      in non-deconvoluted sequences. Default is 0.5 (i.e. less than 50% 
      reduction required for deconvolution).
    default: 0.5
    inputBinding:
      position: 102
  - id: double_cca
    type:
      - 'null'
      - boolean
    doc: Enable analysis of 3'-CCACCA tagging for tRNA degradation pathway. Note
      that this will alter the output of the CCA analysis pipeline.
    inputBinding:
      position: 102
  - id: keep_temp
    type:
      - 'null'
      - boolean
    doc: Keeps multi-mapping and unmapped bam files from GSNAP alignments. 
      Default is false.
    default: false
    inputBinding:
      position: 102
      prefix: --keep-temp
  - id: local_modomics
    type:
      - 'null'
      - boolean
    doc: Disable retrieval of Modomics data from online. Instead use older 
      locally stored data. Warning - this leads to usage of older Modomics data!
    inputBinding:
      position: 102
  - id: max_mismatches
    type:
      - 'null'
      - float
    doc: Maximum mismatches allowed. If specified between 0.0 and 1.0, then 
      treated as a fraction of read length. Otherwise, treated as integer number
      of mismatches. Default is an automatic ultrafast value calculated by 
      GSNAP; see GSNAP help for more info.
    inputBinding:
      position: 102
  - id: max_multi
    type:
      - 'null'
      - int
    doc: Maximum number of bam files to run bedtools coverage on simultaneously.
      Increasing this number reduces processing time by increasing number of 
      files processed simultaneously. However, depending on the size of the bam 
      files to process and available memory, too many files processed at once 
      can cause termination of mim-tRNAseq due to insufficient memory. If 
      mim-tRNAseq fails during coverage calculation, lower this number. Increase
      at your own discretion. Default is 3.
    default: 3
    inputBinding:
      position: 102
      prefix: --max-multi
  - id: min_cov
    type:
      - 'null'
      - float
    doc: Minimum coverage per cluster required to include this cluster in 
      coverage plots, modification analysis, and 3'-CCA analysis. Can be a 
      fraction of total mapped reads between 0 and 1, or an integer of absolute 
      coverage. Any cluster not meeting the threshold in 1 or more sample will 
      be excluded. Note that all clusters are included for differential 
      expression analysis with DESeq2. Default = 0.0005 (0.05% mapped reads).
    default: 0.0005 (0.05% mapped reads)
    inputBinding:
      position: 102
      prefix: --min-cov
  - id: misinc_thresh
    type:
      - 'null'
      - float
    doc: Threshold of total misincorporation rate at a position in a cluster 
      used to call unannotated modifications. Value between 0 and 1, default is 
      0.1 (10% misincorporation).
    default: 0.1
    inputBinding:
      position: 102
      prefix: --misinc-thresh
  - id: mito_trnas
    type:
      - 'null'
      - File
    doc: Mitochondrial tRNA fasta file(s). Should be downloaded from mitotRNAdb 
      for species of interest. Already available in data folder for a few model 
      organisms.
    inputBinding:
      position: 102
      prefix: --mito-trnas
  - id: name
    type: string
    doc: Name of experiment. Note, output files and indices will have this as a 
      prefix. REQUIRED
    inputBinding:
      position: 102
      prefix: --name
  - id: no_cca_analysis
    type:
      - 'null'
      - boolean
    doc: Disable analysis of 3'-CCA ends. When enabled, this calculates 
      proportions of CC vs CCA ending reads per cluster and performs DESeq2 
      analysis. Useful for comparing functional to non-functional mature tRNAs. 
      Default is enabled.
    inputBinding:
      position: 102
  - id: no_cluster
    type:
      - 'null'
      - boolean
    doc: Disable usearch sequence clustering of tRNAs by isodecoder which 
      drastically reduces the rate of multi-mapping reads. Default is enabled.
    inputBinding:
      position: 102
  - id: no_snp_tolerance
    type:
      - 'null'
      - boolean
    doc: Disable GSNAP SNP-tolerant read alignment, where known modifications 
      from Modomics are mapped as SNPs. Default is enabled.
    inputBinding:
      position: 102
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Output directory. Default is current directory. Cannot be an existing 
      directory.
    default: current directory
    inputBinding:
      position: 102
      prefix: --out-dir
  - id: p_adj
    type:
      - 'null'
      - float
    doc: Adjusted p-value threshold for DESeq2 pairwise condition differential 
      epxression dot plots. tRNAs with DESeq2 adjusted p-values equal to or 
      below this value will be displayed as green or orange triangles for up- or
      down-regulated tRNAs, respectively. Default p-adj <= 0.05
    default: 0.05
    inputBinding:
      position: 102
  - id: plastid_trnas
    type:
      - 'null'
      - File
    doc: Plastid tRNA fasta file(s). Should be downloaded from PtRNAdb for 
      species of interest. Already available in data folder for a few model 
      organisms.
    inputBinding:
      position: 102
      prefix: --plastid-trnas
  - id: posttrans_mod_off
    type:
      - 'null'
      - boolean
    doc: Disable post-transcriptional modification of tRNAs, i.e. addition of 
      3'-CCA and 5'-G (His) to mature sequences. Disable for certain prokaryotes
      (e.g. E. coli) where this is genomically encoded. Leave enabled (default) 
      for all eukaryotes.
    inputBinding:
      position: 102
  - id: pretRNAs
    type:
      - 'null'
      - boolean
    doc: Input reference sequences are pretRNAs. Enabling this option will 
      disable the removal of intron sequences and addition of 3'-CCA to generate
      mature tRNA sequences. Useful for mapping and discovering pretRNA sequence
      reads.
    inputBinding:
      position: 102
  - id: remap
    type:
      - 'null'
      - boolean
    doc: Enable detection of unannotated (potential) modifications from 
      misincorporation data. These are defined as having a total 
      misincorporation rate higher than the threshold set with --misinc-thresh. 
      These modifications are then appended to already known ones, and read 
      alignment is reperformed. Very useful for poorly annotated species in 
      Modomics. Due to realignment and misincorporation parsing, enabling this 
      option slows the analysis down considerably.
    inputBinding:
      position: 102
      prefix: --remap
  - id: remap_mismatches
    type:
      - 'null'
      - float
    doc: Maximum number of mismatches allowed during remapping of all reads. 
      Treated similarly to --max-mismatches. This is important to control 
      misalignment of reads to similar clusters/tRNAs Note that the SNP index 
      will be updated with new SNPs from the first round of alignment and so 
      this should be relatively small to prohibit misalignment.
    inputBinding:
      position: 102
  - id: species
    type:
      - 'null'
      - string
    doc: 'Species being analyzed for which to load pre-packaged data files (prioritized
      over -t, -o and -m). Options are: Hsap, Hsap19, Mmus, Rnor, Scer, Spom, Dmel,
      Drer, Cele, Ecol, Atha'
    inputBinding:
      position: 102
      prefix: --species
  - id: threads
    type:
      - 'null'
      - int
    doc: Set processor threads to use during read alignment and read counting.
    inputBinding:
      position: 102
  - id: trnaout
    type:
      - 'null'
      - File
    doc: tRNA.out file generated by tRNAscan-SE (also may be available on 
      gtRNAdb). Contains information about tRNA features, including introns.
    inputBinding:
      position: 102
      prefix: --trnaout
  - id: trnas
    type:
      - 'null'
      - File
    doc: Genomic tRNA fasta file, e.g. from gtRNAdb or tRNAscan-SE. Already 
      avalable in data folder for a few model organisms.
    inputBinding:
      position: 102
      prefix: --trnas
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimseq:1.3.11--pyhdfd78af_0
stdout: mimseq.out
