cwlVersion: v1.2
class: CommandLineTool
baseCommand: DCC
label: dcc_DCC
doc: "Contact: tobias.jakobi@med.uni-heidelberg.de || s6juncheng@gmail.com\n\nTool
  homepage: https://github.com/dieterich-lab/DCC"
inputs:
  - id: input
    type:
      type: array
      items: string
    doc: "Input of the Chimeric.out.junction file from STAR.\n                   \
      \     Alternatively, a sample sheet specifying where your\n                \
      \        chimeric.out.junction files are, each sample per line,\n          \
      \              provide with @ prefix (e.g. @samplesheet)"
    inputBinding:
      position: 1
  - id: annotation
    type:
      - 'null'
      - File
    doc: Gene annotation file in GTF/GFF3 format, to annotate circRNAs by their 
      host gene name/identifier
    inputBinding:
      position: 102
      prefix: --annotation
  - id: bam
    type:
      - 'null'
      - type: array
        items: File
    doc: A file specifying the mapped BAM files from which host gene expression 
      is computed; must have the same order as input chimeric junction files
    inputBinding:
      position: 102
      prefix: --bam
  - id: chrM
    type:
      - 'null'
      - boolean
    doc: If specified, circRNA candidates located on the mitochondrial 
      chromosome will be removed
    inputBinding:
      position: 102
      prefix: --chrM
  - id: circ
    type:
      - 'null'
      - File
    doc: 'User specified circRNA coordinates, any tab delimited file with first three
      columns as circRNA coordinates: chr start end, which DCC will use to count host
      gene expression'
    inputBinding:
      position: 102
      prefix: --circ
  - id: countthreshold_replicatethreshold
    type:
      - 'null'
      - string
    doc: countthreshold replicatethreshold
    inputBinding:
      position: 102
      prefix: -Nr
  - id: cpu_threads
    type:
      - 'null'
      - int
    doc: Number of CPU threads used for computation
    inputBinding:
      position: 102
      prefix: --threads
  - id: detect
    type:
      - 'null'
      - boolean
    doc: Enable circRNA detection from Chimeric.out.junction files
    inputBinding:
      position: 102
      prefix: --detect
  - id: end_tol
    type:
      - 'null'
      - int
    doc: Maximum base pair tolerance of reads extending over junction sites
    inputBinding:
      position: 102
      prefix: --endTol
  - id: filter
    type:
      - 'null'
      - boolean
    doc: If specified, the program will perform a recommended filter step on the
      detection results
    inputBinding:
      position: 102
      prefix: --filter
  - id: filter_only
    type:
      - 'null'
      - type: array
        items: string
    doc: 'If specified, the program will only filter based on two files provided:
      1) a coordinates file [BED6 format] and 2) a count file. E.g.: -f example.bed
      counts.txt'
    inputBinding:
      position: 102
      prefix: --filter-only
  - id: filterbygene
    type:
      - 'null'
      - boolean
    doc: If specified, filter also by gene annotation (candidates are not 
      allowed to span more than one gene)
    inputBinding:
      position: 102
      prefix: --filterbygene
  - id: gene
    type:
      - 'null'
      - boolean
    doc: If specified, the program will count host gene expression given circRNA
      coordinates
    inputBinding:
      position: 102
      prefix: --gene
  - id: keep_temp
    type:
      - 'null'
      - boolean
    doc: Temporary files will not be deleted
    inputBinding:
      position: 102
      prefix: --keep-temp
  - id: length
    type:
      - 'null'
      - int
    doc: Minimum length in base pairs to check for repetitive regions
    inputBinding:
      position: 102
      prefix: --Ln
  - id: mate1
    type:
      - 'null'
      - type: array
        items: File
    doc: For paired end data, Chimeric.out.junction files from mate1 independent
      mapping result
    inputBinding:
      position: 102
      prefix: --mate1
  - id: mate2
    type:
      - 'null'
      - type: array
        items: File
    doc: For paired end data, Chimeric.out.junction files from mate2 independent
      mapping result
    inputBinding:
      position: 102
      prefix: --mate2
  - id: maximum
    type:
      - 'null'
      - int
    doc: The maximum length of candidate circRNAs (including introns)
    inputBinding:
      position: 102
      prefix: --maximum
  - id: minimum
    type:
      - 'null'
      - int
    doc: The minimum length of candidate circRNAs (including introns)
    inputBinding:
      position: 102
      prefix: --minimum
  - id: nonstrand
    type:
      - 'null'
      - boolean
    doc: The library is non-stranded
    inputBinding:
      position: 102
      prefix: --nonstrand
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: DCC output directory
    inputBinding:
      position: 102
      prefix: --output
  - id: pe_independent
    type:
      - 'null'
      - boolean
    doc: Has to be specified if the paired end mates have also been mapped 
      separately.If specified, -mt1 and -mt2 must also be provided
    inputBinding:
      position: 102
      prefix: --PE-independent
  - id: refseq
    type:
      - 'null'
      - File
    doc: Reference sequence FASTA file
    inputBinding:
      position: 102
      prefix: --refseq
  - id: rep_file
    type:
      - 'null'
      - File
    doc: Custom repetitive region file in GTF format to filter out circRNA 
      candidates in repetitive regions
    inputBinding:
      position: 102
      prefix: --rep_file
  - id: stranded_second_strand
    type:
      - 'null'
      - boolean
    doc: Must be enabled for stranded libraries, aka 'fr-secondstrand'
    inputBinding:
      position: 102
      prefix: -ss
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: DCC temporary directory
    inputBinding:
      position: 102
      prefix: --temp
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dcc:0.5.0--pyhca03a8a_0
stdout: dcc_DCC.out
