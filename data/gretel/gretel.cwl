cwlVersion: v1.2
class: CommandLineTool
baseCommand: gretel
label: gretel
doc: "Gretel: A metagenomic haplotyper.\n\nTool homepage: https://github.com/SamStudio8/gretel"
inputs:
  - id: bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: vcf
    type: File
    doc: Input VCF file
    inputBinding:
      position: 2
  - id: contig
    type: string
    doc: Contig name
    inputBinding:
      position: 3
  - id: debughpos
    type:
      - 'null'
      - string
    doc: A comma delimited list of 1-indexed SNP positions to output debug data 
      when predicting haplotypes
    inputBinding:
      position: 104
      prefix: --debughpos
  - id: debugpos
    type:
      - 'null'
      - string
    doc: A newline delimited list of 1-indexed genomic positions to output debug
      data when parsing the BAM
    inputBinding:
      position: 104
      prefix: --debugpos
  - id: debugreads
    type:
      - 'null'
      - string
    doc: A newline delimited list of read names to output debug data when 
      parsing the BAM
    inputBinding:
      position: 104
      prefix: --debugreads
  - id: delchar
    type:
      - 'null'
      - string
    doc: Character to output in haplotype for deletion (eg. -)
    inputBinding:
      position: 104
      prefix: --delchar
  - id: dumpmatrix
    type:
      - 'null'
      - string
    doc: Location to dump the Hansel matrix to disk
    inputBinding:
      position: 104
      prefix: --dumpmatrix
  - id: dumpsnps
    type:
      - 'null'
      - string
    doc: Location to dump the SNP positions to disk
    inputBinding:
      position: 104
      prefix: --dumpsnps
  - id: end
    type:
      - 'null'
      - int
    doc: 1-indexed inlcuded end base position
    inputBinding:
      position: 104
      prefix: --end
  - id: gapchar
    type:
      - 'null'
      - string
    doc: Character to fill homogeneous gaps in haplotypes if no --master
    default: N
    inputBinding:
      position: 104
      prefix: --gapchar
  - id: master
    type:
      - 'null'
      - string
    doc: Master sequence (will be used to fill in homogeneous gaps in 
      haplotypes, otherwise --gapchar)
    inputBinding:
      position: 104
      prefix: --master
  - id: out
    type:
      - 'null'
      - Directory
    doc: Output directory
    default: .
    inputBinding:
      position: 104
      prefix: --out
  - id: paths
    type:
      - 'null'
      - int
    doc: Maximum number of paths to generate
    default: 100
    inputBinding:
      position: 104
      prefix: --paths
  - id: pepper
    type:
      - 'null'
      - boolean
    doc: enable a more permissive pileup by setting the pysam pileup stepper to 
      'all', instead of 'samtools'. Note that this will allow improper pairs.
    inputBinding:
      position: 104
      prefix: --pepper
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Don't output anything other than a single summary line.
    inputBinding:
      position: 104
      prefix: --quiet
  - id: start
    type:
      - 'null'
      - int
    doc: 1-indexed included start base position
    default: 1
    inputBinding:
      position: 104
      prefix: --start
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of BAM iterators
    default: 1
    inputBinding:
      position: 104
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gretel:0.0.94--pyh864c0ab_1
stdout: gretel.out
