cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fuc
  - vcf-slice
label: fuc_vcf-slice
doc: "Slice a VCF file for specified regions.\n\nTool homepage: https://github.com/sbslee/fuc"
inputs:
  - id: vcf
    type: File
    doc: Input VCF file must be already BGZF compressed (.gz) and indexed (.tbi)
      to allow random access. A VCF file can be compressed with the fuc-bgzip 
      command and indexed with the vcf-index command.
    inputBinding:
      position: 1
  - id: regions
    type:
      type: array
      items: string
    doc: One or more regions to be sliced. Each region must have the format 
      chrom:start-end and be a half-open interval with (start, end]. This means,
      for example, chr1:100-103 will extract positions 101, 102, and 103. 
      Alternatively, you can provide a BED file (compressed or uncompressed) to 
      specify regions. Note that the 'chr' prefix in contig names (e.g. 'chr1' 
      vs. '1') will be automatically added or removed as necessary to match the 
      input VCF's contig names.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
stdout: fuc_vcf-slice.out
