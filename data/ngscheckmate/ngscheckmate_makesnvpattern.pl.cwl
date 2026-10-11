cwlVersion: v1.2
class: CommandLineTool
baseCommand: makesnvpattern.pl
label: ngscheckmate_makesnvpattern.pl
doc: "Generates a binary SNP flanking pattern file (.pt) for ngscheckmate_fastq
  from a SNP bed file, a genome FASTA and a bowtie index of the genome. Needs bowtie
  on the PATH.\n\nTool homepage: https://github.com/parklab/NGSCheckMate"
inputs:
  - id: bedfile
    type: File
    doc: bed file of SNP sites
    inputBinding:
      position: 1
  - id: genomefasta
    type: File
    doc: genome FASTA file
    inputBinding:
      position: 2
  - id: bowtie_index
    type:
      type: array
      items: File
    doc: The bowtie (v1) index files of the genome (.ebwt files), staged in the
      working directory
  - id: genome_index_prefix
    type: string
    doc: Prefix of the bowtie index files, for example GRCh37_21part
    inputBinding:
      position: 3
  - id: outdir
    type: string
    doc: Output directory
    inputBinding:
      position: 4
  - id: outprefix
    type: string
    doc: Prefix of the output files
    inputBinding:
      position: 5
outputs:
  - id: output_dir
    type: Directory
    doc: Directory with the pattern file (.pt) and intermediate files
    outputBinding:
      glob: $(inputs.outdir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.bowtie_index)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngscheckmate:1.0.1--py312pl5321h577a1d6_4
