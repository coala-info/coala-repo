cwlVersion: v1.2
class: CommandLineTool
baseCommand: SNPsplit
label: snpsplit
doc: "SNPsplit is a tool to sort alignments (SAM/BAM files) into specific alleles
  based on SNP information.\n\nTool homepage: https://www.bioinformatics.babraham.ac.uk/projects/SNPsplit/"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input SAM/BAM file(s) to be split.
    inputBinding:
      position: 1
  - id: bisulfite
    type:
      - 'null'
      - boolean
    doc: Bisulfite-seq mode. This will assume that the input files are 
      Bismark-aligned files.
    inputBinding:
      position: 102
      prefix: --bisulfite
  - id: conflicting
    type:
      - 'null'
      - boolean
    doc: Write reads or read pairs classified as conflicting (XX:Z:CF) to an
      extra file (.conflicting.bam) instead of skipping them.
    inputBinding:
      position: 102
      prefix: --conflicting
  - id: paired
    type:
      - 'null'
      - boolean
    doc: Paired-end mode (default is auto-detection).
    inputBinding:
      position: 102
      prefix: --paired
  - id: sam
    type:
      - 'null'
      - boolean
    doc: Write the allele-sorted output in SAM format instead of BAM.
    inputBinding:
      position: 102
      prefix: --sam
  - id: single_end
    type:
      - 'null'
      - boolean
    doc: Manually sets data to single-end. Skips auto-detection.
    inputBinding:
      position: 102
      prefix: --single_end
  - id: hic
    type:
      - 'null'
      - boolean
    doc: Assumes Hi-C data processed with HiCUP as input (sets --paired and
      --no_sort).
    inputBinding:
      position: 102
      prefix: --hic
  - id: no_sort
    type:
      - 'null'
      - boolean
    doc: Skip the sorting step when BAM files are already sorted by read name.
    inputBinding:
      position: 102
      prefix: --no_sort
  - id: outdir
    type:
      - 'null'
      - string
    default: snpsplit_out
    doc: Write all output files into this directory. The folder is created if it
      does not exist.
    inputBinding:
      position: 102
      prefix: -o
  - id: samtools_path
    type:
      - 'null'
      - string
    doc: The path to the Samtools installation. Not needed if Samtools is in the
      PATH.
    inputBinding:
      position: 102
      prefix: --samtools_path
  - id: singletons
    type:
      - 'null'
      - boolean
    doc: Write singleton alignments of allele-tagged paired-end files to extra
      files (ending in _st.bam).
    inputBinding:
      position: 102
      prefix: --singletons
  - id: skip_tag2sort
    type:
      - 'null'
      - boolean
    doc: Carry out the allele-tagging process and exit afterwards.
    inputBinding:
      position: 102
      prefix: --skip_tag2sort
  - id: snp_file
    type: File
    doc: Mandatory SNP file containing the positions of all SNPs to be 
      considered.
    inputBinding:
      position: 102
      prefix: --snp_file
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output for debugging.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_files
    type:
      type: array
      items: File
    doc: Allele-tagged and allele-specific alignment files and reports written
      to the output directory.
    outputBinding:
      glob: $(inputs.outdir)/*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_files)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snpsplit:0.6.0--hdfd78af_0
stdout: snpsplit.out
