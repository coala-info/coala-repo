cwlVersion: v1.2
class: CommandLineTool
baseCommand: Yleaf
label: yleaf_Yleaf
doc: "software tool for human Y-chromosomal phylogenetic analysis and haplogroup inference
  v3.2.1\n\nTool homepage: https://github.com/genid/Yleaf"
inputs:
  - id: ancient_dna
    type:
      - 'null'
      - boolean
    doc: Add this flag if the sample is ancient DNA. This will ignore all G > A 
      and C > T mutations.
    inputBinding:
      position: 101
      prefix: --ancient_DNA
  - id: bam_path
    type:
      - 'null'
      - File
    doc: input BAM file
    inputBinding:
      position: 101
      prefix: --bamfile
  - id: base_majority
    type:
      - 'null'
      - int
    doc: The minimum percentage of a base result for acceptance, integer between
      50 and 99. [50-99]
    inputBinding:
      position: 101
      prefix: --base_majority
  - id: collapsed_draw_mode
    type:
      - 'null'
      - boolean
    doc: Add this flag to compress the haplogroup tree image and remove all 
      uninformative haplogroups from it.
    inputBinding:
      position: 101
      prefix: --collapsed_draw_mode
  - id: cram_path
    type:
      - 'null'
      - File
    doc: input CRAM file
    inputBinding:
      position: 101
      prefix: --cramfile
  - id: cram_reference_path
    type:
      - 'null'
      - File
    doc: Reference genome for the CRAM file. Required when using CRAM files.
    inputBinding:
      position: 101
      prefix: --cram_reference
  - id: draw_haplogroups
    type:
      - 'null'
      - boolean
    doc: Draw the predicted haplogroups in the haplogroup tree.
    inputBinding:
      position: 101
      prefix: --draw_haplogroups
  - id: fastq_path
    type:
      - 'null'
      - File
    doc: Use raw FastQ files
    inputBinding:
      position: 101
      prefix: --fastq
  - id: force
    type:
      - 'null'
      - boolean
    doc: Delete files without asking
    inputBinding:
      position: 101
      prefix: --force
  - id: minor_allele_frequency
    type:
      - 'null'
      - float
    doc: Maximum rate of minor allele for it to be considered as a private 
      mutation.
    inputBinding:
      position: 101
      prefix: --minor_allele_frequency
  - id: output
    type: string
    doc: Folder name containing outputs
    inputBinding:
      position: 101
      prefix: --output
  - id: prediction_quality
    type:
      - 'null'
      - float
    doc: The minimum quality of the prediction (QC-scores) for it to be 
      accepted. [0-1]
    inputBinding:
      position: 101
      prefix: --prediction_quality
  - id: private_mutations
    type:
      - 'null'
      - boolean
    doc: Add this flag to search for private mutations. These are variations 
      that are not considered in the phylogenetic tree and thus not used for 
      haplogroup prediction, however can be informative and differentiate 
      individuals within the same haplogroup prediction.
    inputBinding:
      position: 101
      prefix: --private_mutations
  - id: quality_thresh
    type:
      - 'null'
      - int
    doc: Minimum quality for each read, integer between 10 and 40. [10-40]
    inputBinding:
      position: 101
      prefix: --quality_thresh
  - id: reads_treshold
    type:
      - 'null'
      - int
    doc: The minimum number of reads for each base.
    inputBinding:
      position: 101
      prefix: --reads_treshold
  - id: reanalyze
    type:
      - 'null'
      - boolean
    doc: reanalyze (skip filtering and splitting) the vcf file
    inputBinding:
      position: 101
      prefix: --reanalyze
  - id: reference_genome
    type:
      - 'null'
      - string
    doc: The reference genome build to be used. If no reference is available 
      they will be downloaded. If you added references in your config.txt file 
      these will be used instead as reference or the location will be used to 
      download the reference if those files are missing or empty.
    inputBinding:
      position: 101
      prefix: --reference_genome
  - id: threads
    type:
      - 'null'
      - int
    doc: The number of processes to use when running Yleaf.
    inputBinding:
      position: 101
      prefix: --threads
  - id: use_old
    type:
      - 'null'
      - boolean
    doc: Add this value if you want to use the old prediction method of Yleaf 
      (version 2.3). This version only uses the ISOGG tree and slightly 
      different prediction criteria.
    inputBinding:
      position: 101
      prefix: --use_old
  - id: vcf_path
    type:
      - 'null'
      - File
    doc: input VCF file (.vcf.gz)
    inputBinding:
      position: 101
      prefix: --vcffile
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yleaf:3.2.1--pyh1286868_0
stdout: yleaf_Yleaf.out
