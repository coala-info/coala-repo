cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - whatshap
  - split
label: whatshap_split
doc: "Split reads by haplotype\n\nTool homepage: https://whatshap.readthedocs.io"
inputs:
  - id: reads
    type: File
    doc: Input FASTQ/BAM file with reads (FASTQ can be gzipped)
    inputBinding:
      position: 1
  - id: list
    type: File
    doc: Tab-separated list with (at least) two columns <readname> and 
      <haplotype> (can be gzipped). Currently, the haplotypes have to be named 
      H1, H2, etc. (or none). Alternatively, the output of the "haplotag" 
      command can be used (4 columns), and this is required for using the 
      "--only-largest-block" option (need phaseset and chromosome info).
    inputBinding:
      position: 2
  - id: add_untagged
    type:
      - 'null'
      - boolean
    doc: Add reads without tag to all (H1, H2, ...) outputs.
    inputBinding:
      position: 103
      prefix: --add-untagged
  - id: discard_unknown_reads
    type:
      - 'null'
      - boolean
    doc: Only check the haplotype of reads listed in the haplotag list file. 
      Reads (read names) not contained in this file will be discarded. In the 
      default case (= keep unknown reads), those reads would be considered 
      untagged and end up in the respective output file. Please be sure that the
      read names match between the input FASTQ/BAM and the haplotag list file.
    inputBinding:
      position: 103
      prefix: --discard-unknown-reads
  - id: only_largest_block
    type:
      - 'null'
      - boolean
    doc: Only consider reads to be tagged if they belong to the largest phased 
      block (in terms of read count) on their respective chromosome
    inputBinding:
      position: 103
      prefix: --only-largest-block
  - id: output_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 104
      prefix: --output
  - id: output_h1_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_h1_path`
    inputBinding:
      position: 105
      prefix: --output-h1
  - id: output_h2_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_h2_path`
    inputBinding:
      position: 106
      prefix: --output-h2
  - id: output_untagged_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_untagged_path`
    inputBinding:
      position: 107
      prefix: --output-untagged
  - id: read_lengths_histogram_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `read_lengths_histogram_path`
    inputBinding:
      position: 108
      prefix: --read-lengths-histogram
outputs:
  - id: output_h1
    type:
      - 'null'
      - File
    doc: Output haplotype 1 reads to FILE (.gz supported)
    outputBinding:
      glob: $(inputs.output_h1_path)
  - id: output_h2
    type:
      - 'null'
      - File
    doc: Output haplotype 2 reads to FILE (.gz supported)
    outputBinding:
      glob: $(inputs.output_h2_path)
  - id: output
    type:
      - 'null'
      - File
    doc: Output haplotype reads to FILE. Use this option as many times as there 
      are haplotypes in the input. The first -o is used for H1, second for H2 
      etc.
    outputBinding:
      glob: $(inputs.output_path)
  - id: output_untagged
    type:
      - 'null'
      - File
    doc: Output file to write untagged reads to (.gz supported)
    outputBinding:
      glob: $(inputs.output_untagged_path)
  - id: read_lengths_histogram
    type:
      - 'null'
      - File
    doc: Output file to write read lengths histogram to in tab-separated format.
    outputBinding:
      glob: $(inputs.read_lengths_histogram_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/whatshap:2.8--py39h2de1943_0
