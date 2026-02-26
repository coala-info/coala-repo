cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyReadAligner.py
label: pycrac_pyReadAligner.py
doc: "Aligns reads to genomic or coding sequences, with options for various input
  file types and analysis parameters.\n\nTool homepage: http://sandergranneman.bio.ed.ac.uk/Granneman_Lab/pyCRAC_software.html"
inputs:
  - id: align_quality
    type:
      - 'null'
      - int
    doc: with these options you can set the alignment quality (Novoalign) or 
      mapping quality (SAM) threshold. Reads with qualities lower than the 
      threshold will be ignored.
    default: 100
    inputBinding:
      position: 101
      prefix: --align_quality
  - id: align_score
    type:
      - 'null'
      - int
    doc: with this option you can set the alignment score threshold. Reads with 
      alignment scores lower than the threshold will be ignored.
    default: 0
    inputBinding:
      position: 101
      prefix: --align_score
  - id: blocks
    type:
      - 'null'
      - boolean
    doc: with this option reads with the same start and end coordinates on a 
      chromosome will only be counted once. Default = Off
    inputBinding:
      position: 101
      prefix: --blocks
  - id: chr_file
    type:
      - 'null'
      - File
    doc: if you simply would like to align reads against a genomic sequence you 
      should generate a tab delimited file containing an identifyer, chromosome 
      name, start position, end position and strand ('-' or '+')
    inputBinding:
      position: 101
      prefix: --chr
  - id: discarded_file
    type:
      - 'null'
      - File
    doc: prints the lines from the alignments file that were discarded by the 
      parsers. This file contains reads that were unmapped (NM), of poor quality
      (i.e. QC) or paired reads that were mapped to different chromosomal 
      locations or were too far apart on the same chromosome. Useful for 
      debugging purposes
    inputBinding:
      position: 101
      prefix: --discarded
  - id: distance
    type:
      - 'null'
      - int
    doc: this option allows you to set the maximum number of base-pairs allowed 
      between two non-overlapping paired reads.
    default: 1000
    inputBinding:
      position: 101
      prefix: --distance
  - id: file_type
    type:
      - 'null'
      - string
    doc: use this option to specify the file type (i.e. 'novo', 'sam', 'gtf'). 
      This will tell the program which parsers to use for processing the files.
    default: "'novo'"
    inputBinding:
      position: 101
      prefix: --file_type
  - id: genes_file
    type: File
    doc: here you need to type in the name of your gene list file (1 column) or 
      the hittable file
    inputBinding:
      position: 101
      prefix: --genes_file
  - id: gtf_annotation_file
    type:
      - 'null'
      - File
    doc: type the path to the gtf annotation file that you want to use
    inputBinding:
      position: 101
      prefix: --gtf
  - id: ignorestrand
    type:
      - 'null'
      - boolean
    doc: this flag tells the program to ignore strand information and all 
      overlapping reads will considered sense reads. Useful for analysing ChIP 
      or RIP data
    inputBinding:
      position: 101
      prefix: --ignorestrand
  - id: input_file
    type: File
    doc: As input files you can use Novoalign native output or SAM files as 
      input file. By default it expects data from the standard input. Make sure 
      to specify the file type of the file you want to have analyzed using the 
      --file_type option!
    inputBinding:
      position: 101
      prefix: --input_file
  - id: length
    type:
      - 'null'
      - int
    doc: to set read length threshold.
    default: 100
    inputBinding:
      position: 101
      prefix: --length
  - id: limit
    type:
      - 'null'
      - int
    doc: with this option you can select how many reads mapped to a particular 
      gene/ORF/region you want to count.
    default: 500
    inputBinding:
      position: 101
      prefix: --limit
  - id: mapping_quality
    type:
      - 'null'
      - int
    doc: with these options you can set the alignment quality (Novoalign) or 
      mapping quality (SAM) threshold. Reads with qualities lower than the 
      threshold will be ignored.
    default: 100
    inputBinding:
      position: 101
      prefix: --mapping_quality
  - id: max_mapped_reads
    type:
      - 'null'
      - int
    doc: maximum number of mapped reads that will be analyzed.
    default: 100000
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
  - id: overlap
    type:
      - 'null'
      - int
    doc: sets the number of nucleotides a read has to overlap with a gene before
      it is considered a hit.
    default: 1
    inputBinding:
      position: 101
      prefix: --overlap
  - id: range
    type:
      - 'null'
      - int
    doc: allows you to set the length of the UTR regions. If you set '-r 50' or 
      '--range=50', then the program will set a fixed length (50 bp) regardless 
      of whether the GTF file has genes with annotated UTRs.
    default: 100
    inputBinding:
      position: 101
      prefix: --range
  - id: sequence
    type:
      - 'null'
      - string
    doc: with this option you can select whether you want the reads aligned to 
      the genomic or the coding sequence.
    default: genomic
    inputBinding:
      position: 101
      prefix: --sequence
  - id: tab_file
    type:
      - 'null'
      - File
    doc: type the path to the tab file that contains the genomic reference 
      sequence
    inputBinding:
      position: 101
      prefix: --tab
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
  - id: zip_file
    type:
      - 'null'
      - File
    doc: use this option to compress all the output files in a single zip file
    inputBinding:
      position: 101
      prefix: --zip
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Use this flag to override the standard output file names. All 
      alignments will be written to one output file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pycrac:1.5.2--pyh7cba7a3_0
