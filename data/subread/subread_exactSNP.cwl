cwlVersion: v1.2
class: CommandLineTool
baseCommand: exactSNP
label: subread_exactSNP
doc: "Call SNPs from read mapping results (SAM or BAM) with the exactSNP caller.\n\nTool homepage: http://subread.sourceforge.net/"
inputs:
  - id: input_file
    type: File
    doc: "Input file including read mapping results, SAM or BAM (use -b for BAM)."
    inputBinding:
      position: 1
      prefix: -i
  - id: reference_genome
    type: File
    doc: "File including all reference sequences, a single FASTA file."
    inputBinding:
      position: 1
      prefix: -g
  - id: output_file
    type: string
    doc: Name of the output file (VCF format) that includes discovered SNPs.
    inputBinding:
      position: 1
      prefix: -o
  - id: known_snps
    type:
      - 'null'
      - File
    doc: A set of annotated SNPs (e.g. from dbSNP) in VCF format (gzipped file is accepted).
    inputBinding:
      position: 1
      prefix: -a
  - id: bam_input
    type:
      - 'null'
      - boolean
    doc: The input file provided via -i is in BAM format.
    inputBinding:
      position: 1
      prefix: -b
  - id: q_value_cutoff
    type:
      - 'null'
      - int
    doc: The q-value cutoff for SNP calling at sequencing depth of 50X. 12 by default.
    inputBinding:
      position: 1
      prefix: -Q
  - id: min_fraction
    type:
      - 'null'
      - float
    doc: Minimum fraction of mis-matched bases a SNP-containing location must have (0 to 1). 0 by default.
    inputBinding:
      position: 1
      prefix: -f
  - id: min_mismatched_bases
    type:
      - 'null'
      - int
    doc: Minimum number of mis-matched bases a SNP-containing location must have. 1 by default.
    inputBinding:
      position: 1
      prefix: -n
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: Minimum number of mapped reads a SNP-containing location must have. 1 by default.
    inputBinding:
      position: 1
      prefix: -r
  - id: max_depth
    type:
      - 'null'
      - int
    doc: "Maximum depth a SNP location is allowed to have. 1,000,000 reads by default."
    inputBinding:
      position: 1
      prefix: -x
  - id: min_base_quality
    type:
      - 'null'
      - int
    doc: Minimum base quality score (Phred) read bases must satisfy to be used for SNP calling. 13 by default.
    inputBinding:
      position: 1
      prefix: -s
  - id: trim_bases
    type:
      - 'null'
      - int
    doc: Number of bases trimmed off from each end of the read. 3 by default.
    inputBinding:
      position: 1
      prefix: -t
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads. 1 by default.
    inputBinding:
      position: 1
      prefix: -T
  - id: temp_dir
    type:
      - 'null'
      - string
    doc: Path to save the temporary files.
    inputBinding:
      position: 1
      prefix: -C
outputs:
  - id: snps
    type: File
    doc: Discovered SNPs in VCF format
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/subread:2.1.1--h577a1d6_0
