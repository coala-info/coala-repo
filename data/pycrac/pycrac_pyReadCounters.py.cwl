cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyReadCounters.py
label: pycrac_pyReadCounters.py
doc: "Analyze novo, SAM/BAM or gtf data\n\nTool homepage: http://sandergranneman.bio.ed.ac.uk/Granneman_Lab/pyCRAC_software.html"
inputs:
  - id: align_quality
    type:
      - 'null'
      - int
    doc: with these options you can set the alignment quality (Novoalign) or 
      mapping quality (SAM) threshold. Reads with qualities lower than the 
      threshold will be ignored. Default = 0
    inputBinding:
      position: 101
      prefix: --align_quality
  - id: align_score
    type:
      - 'null'
      - int
    doc: with this option you can set the alignment score threshold. Reads with 
      alignment scores lower than the threshold will be ignored. Default = 0
    inputBinding:
      position: 101
      prefix: --align_score
  - id: annotation
    type:
      - 'null'
      - string
    doc: select which annotation (i.e. protein_coding, ncRNA, sRNA, rRNA, tRNA, 
      snoRNA) you would like to focus your search on. Default = all.
    inputBinding:
      position: 101
      prefix: --annotation
  - id: anti_sense
    type:
      - 'null'
      - boolean
    doc: this option instructs pyReadCounters to only consider reads overlapping
      anti-sense with genomic features. Default is False
    inputBinding:
      position: 101
      prefix: --anti_sense
  - id: blocks
    type:
      - 'null'
      - boolean
    doc: with this option reads with the same start and end coordinates on a 
      chromosome will be counted as one cDNA. Default = Off
    inputBinding:
      position: 101
      prefix: --blocks
  - id: distance
    type:
      - 'null'
      - int
    doc: this option allows you to set the maximum number of base-pairs allowed 
      between two non-overlapping paired reads. Default = 1000
    inputBinding:
      position: 101
      prefix: --distance
  - id: file_type
    type:
      - 'null'
      - string
    doc: use this option to specify the file type (i.e. 'novo','sam' or 'gtf'). 
      This will tell the program which parsers to use for processing the files.
    inputBinding:
      position: 101
      prefix: --file_type
  - id: force_single_end
    type:
      - 'null'
      - boolean
    doc: To consider all reads unpaired, even if it is paired end data.Default 
      is False.
    inputBinding:
      position: 101
      prefix: --force_single_end
  - id: gtf
    type:
      - 'null'
      - File
    doc: type the path to the gtf annotation file that you want to use
    inputBinding:
      position: 101
      prefix: --gtf
  - id: gtffile
    type:
      - 'null'
      - boolean
    doc: use this flag if you only want to print the pyReadCounters gtf file for
      your data
    inputBinding:
      position: 101
      prefix: --gtffile
  - id: hittable
    type:
      - 'null'
      - boolean
    doc: use this flag if you only want to print a hit table for your data
    inputBinding:
      position: 101
      prefix: --hittable
  - id: ignorestrand
    type:
      - 'null'
      - boolean
    doc: To ignore strand information and all reads overlapping with genomic 
      features will be considered sense reads. Useful for analysing ChIP or RIP 
      data
    inputBinding:
      position: 101
      prefix: --ignorestrand
  - id: input_file
    type: File
    doc: provide the path to your novo, SAM/BAM or gtf data file. Default is 
      standard input. Make sure to specify the file type of the file you want to
      have analyzed using the --file_type option!
    inputBinding:
      position: 101
      prefix: --input_file
  - id: length
    type:
      - 'null'
      - int
    doc: to set read length threshold. Default = 1000
    inputBinding:
      position: 101
      prefix: --length
  - id: mapping_quality
    type:
      - 'null'
      - int
    doc: with these options you can set the alignment quality (Novoalign) or 
      mapping quality (SAM) threshold. Reads with qualities lower than the 
      threshold will be ignored. Default = 0
    inputBinding:
      position: 101
      prefix: --mapping_quality
  - id: max
    type:
      - 'null'
      - int
    doc: maximum number of mapped reads that will be analyzed. Default = All
    inputBinding:
      position: 101
      prefix: --max
  - id: mutations
    type:
      - 'null'
      - string
    doc: "Use this option to only track mutations that are of interest. For CRAC data
      this is usually deletions (--mutations=delsonly). For PAR-CLIP data this is
      usually T-C mutations (--mutations=TC). Other options are: do not report any
      mutations: --mutations=nomuts. Only report specific base mutations, for example
      only in T's, C's and G's :--mutations=[TCG]. The brackets are essential. Other
      nucleotide combinations are also possible"
    inputBinding:
      position: 101
      prefix: --mutations
  - id: nucdensities
    type:
      - 'null'
      - boolean
    doc: With this flag nucleotide densities are calculated (i.e. the total 
      number of nucleotides overlapping with a feature). Default is False.
    inputBinding:
      position: 101
      prefix: --nucdensities
  - id: overlap
    type:
      - 'null'
      - int
    doc: sets the number of nucleotides a read has to overlap with a gene before
      it is considered a hit. Default = 1 nucleotide
    inputBinding:
      position: 101
      prefix: --overlap
  - id: properpairs
    type:
      - 'null'
      - boolean
    doc: In case you have paired-end data, you can use this flag to analyze only
      properly paired reads. Default is False
    inputBinding:
      position: 101
      prefix: --properpairs
  - id: range
    type:
      - 'null'
      - int
    doc: allows you to add regions flanking the genomic feature. If you set '-r 
      50' or '--range=50', then the program will add 50 nucleotides to each 
      feature on each side regardless of whether the GTF file has genes with 
      annotated UTRs.
    inputBinding:
      position: 101
      prefix: --range
  - id: rpkm
    type:
      - 'null'
      - boolean
    doc: to include a column showing reads per kilobase per 1 million mapped 
      reads for each gene. Default is False.
    inputBinding:
      position: 101
      prefix: --rpkm
  - id: sense
    type:
      - 'null'
      - boolean
    doc: this option instructs pyReadCounters to only consider reads overlapping
      sense with genomic features. Default is False
    inputBinding:
      position: 101
      prefix: --sense
  - id: sequence
    type:
      - 'null'
      - string
    doc: with this option you can select whether you want to count reads 
      overlapping coding or genomic sequence or intron, exon, CDS, 5UTR or 3UTR 
      coordinates. Default = genomic.
    inputBinding:
      position: 101
      prefix: --sequence
  - id: stats
    type:
      - 'null'
      - boolean
    doc: use this flag if you only want to print a the statistics showing the 
      complexity of your data
    inputBinding:
      position: 101
      prefix: --stats
  - id: unique
    type:
      - 'null'
      - boolean
    doc: with this option reads with multiple alignment locations will be 
      removed. Default = Off
    inputBinding:
      position: 101
      prefix: --unique
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: prints all the status messages to a file rather than the standard 
      output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Use this flag to override the standard file names. Do NOT add an 
      extension.
    outputBinding:
      glob: $(inputs.output_file)
  - id: discarded
    type:
      - 'null'
      - File
    doc: prints the lines from the alignments file that were discarded by the 
      parsers. This file contains reads that were unmapped (NM), of poor quality
      (i.e. QC) or paired reads that were mapped to different chromosomal 
      locations or were too far apart on the same chromosome. Useful for 
      debugging purposes
    outputBinding:
      glob: $(inputs.discarded)
  - id: zip
    type:
      - 'null'
      - File
    doc: use this option to compress all the output files in a single zip file
    outputBinding:
      glob: $(inputs.zip)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pycrac:1.5.2--pyh7cba7a3_0
