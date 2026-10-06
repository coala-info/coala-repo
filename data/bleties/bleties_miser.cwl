cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bleties
  - miser
label: bleties_miser
doc: "MISER - Method of IES Spurious or Erroneous Reporting (experimental)\n\nTool
  homepage: https://github.com/Swart-lab/bleties"
inputs:
  - id: bam_file
    type:
      - 'null'
      - File
    doc: BAM file containing mapping, must be sorted and indexed
    secondaryFiles:
      - pattern: .bai
        required: false
    inputBinding:
      position: 101
      prefix: --bam
  - id: ref_file
    type:
      - 'null'
      - File
    doc: FASTA file containing genomic contigs used as reference for the mapping
    secondaryFiles:
      - pattern: .fai
        required: false
    inputBinding:
      position: 101
      prefix: --ref
  - id: gff_file
    type:
      - 'null'
      - File
    doc: GFF file containing coordinates for putative IESs
    inputBinding:
      position: 101
      prefix: --gff
  - id: output_file
    type:
      - 'null'
      - string
    doc: Path to write report statistics on possibly spurious IESs due to 
      misassembly or mapped paralogs, defaults to STDOUT
    inputBinding:
      position: 101
      prefix: --out
  - id: split_gff
    type:
      - 'null'
      - boolean
    doc: Split input GFF entries into separate files for each category (ok, 
      misassembly, paralog, ...), using input GFF filename as prefix
    inputBinding:
      position: 101
      prefix: --split_gff
  - id: min_ies_length
    type:
      - 'null'
      - int
    doc: Minimum length of IES insert to allow
    inputBinding:
      position: 101
      prefix: --min_ies_length
  - id: spurious_ies_test
    type:
      - 'null'
      - string
    doc: Test to use to evaluate spurious IESs by mismatch percentage 
      comparisons, either "mann-whitney" (Mann-Whitney's U) or "t" (Ward's 
      t-test)
    inputBinding:
      position: 101
      prefix: --spurious_ies_test
  - id: spurious_ies_pvalue
    type:
      - 'null'
      - float
    doc: P-value cutoff (uncorrected) to use for spurious IES mismatch test; 
      the Bonferroni correction will be applied depending on the number of 
      tests (number of putative IESs) performed
    inputBinding:
      position: 101
      prefix: --spurious_ies_pvalue
outputs:
  - id: stdout
    type: stdout
    doc: Report of possibly spurious IESs, when output_file is not given
  - id: output_report
    type:
      - 'null'
      - File
    doc: Report of possibly spurious IESs written to output_file
    outputBinding:
      glob: "$(inputs.output_file ? inputs.output_file : [])"
  - id: split_gff_files
    type:
      type: array
      items: File
    doc: Input GFF entries split by diagnosis (<gff>.<diagnosis>.gff3), with 
      split_gff
    outputBinding:
      glob: "$(inputs.gff_file ? inputs.gff_file.basename + '.*.gff3' : [])"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.gff_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bleties:0.1.11--pyhdfd78af_0
stdout: bleties_miser.out
