cwlVersion: v1.2
class: CommandLineTool
baseCommand: preprocessor.py
label: mace_preprocessor.py
doc: "Model based Analysis of ChIP Exo\n\nTool homepage: http://chipexo.sourceforge.net"
inputs:
  - id: bin_size
    type:
      - 'null'
      - int
    doc: Chromosome chunk size. Each chomosome will be cut into small chunks of 
      this size. Decrease chunk size will save more RAM.
    default: 100000
    inputBinding:
      position: 101
      prefix: --bin
  - id: chrom_size
    type: File
    doc: 'Chromosome size file. Tab or space separated text file with 2 columns: first
      column is chromosome name, second column is size of the chromosome.'
    inputBinding:
      position: 101
      prefix: --chromSize
  - id: input_file
    type:
      type: array
      items: File
    doc: Input file in BAM format. BAM file must be sorted and indexed using 
      samTools. Replicates separated by comma(',') e.g. "-i 
      rep1.bam,rep2.bam,rep3.bam"
    inputBinding:
      position: 101
      prefix: --inputFile
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: Kmer size [6,12] to correct nucleotide composition bias. kmerSize < 
      0.5*read_lenght. larger KmerSize might make program slower. Set kmerSize =
      0 to turn off nucleotide compsition bias correction.
    default: 6
    inputBinding:
      position: 101
      prefix: --kmerSize
  - id: normalization_method
    type:
      - 'null'
      - string
    doc: methods ("EM", "AM", "GM", or "SNR") used to consolidate replicates and
      reduce noise. "EM" = Entropy weighted mean, "AM"=Arithmetic mean, 
      "GM"=Geometric mean, "SNR"=Signal-to-noise ratio.
    default: EM
    inputBinding:
      position: 101
      prefix: --method
  - id: output_prefix
    type: string
    doc: Prefix of output wig files(s). "Prefix_Forward.wig" and 
      "Prefix_Reverse.wig" will be generated
    inputBinding:
      position: 101
      prefix: --outPrefix
  - id: quality_threshold
    type:
      - 'null'
      - int
    doc: phred scaled mapping quality threshhold to determine "uniqueness" of 
      alignments.
    default: 30
    inputBinding:
      position: 101
      prefix: --qCut
  - id: reference_depth
    type:
      - 'null'
      - int
    doc: Reference reads count (default = 10 million). Sequencing depth will be 
      normailzed to this number, so that wig files are comparable between 
      replicates.
    default: 10000000
    inputBinding:
      position: 101
      prefix: --depth
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mace:1.2--py27h99da42f_0
stdout: mace_preprocessor.py.out
