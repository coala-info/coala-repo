cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwjoin
label: cgpbigwig_bwjoin
doc: "Join per-contig bigWig files (named <contig_name>.bw) into a single bigWig 
  file, in the contig order of a fasta index.\n\nTool homepage: https://github.com/cancerit/cgpBigWig"
inputs:
  - id: input_path
    type: Directory
    doc: Path to the input bigwig files named [path]/<contig_name>.bw
    inputBinding:
      position: 101
      prefix: --input-path
  - id: fasta_index
    type: File
    doc: Fasta index file (.fai)
    inputBinding:
      position: 101
      prefix: --fasta-index
  - id: outfile
    type:
      - 'null'
      - string
    doc: "Path to the output .bw file produced. [default:'concatenated.bw']"
    default: concatenated.bw
    inputBinding:
      position: 101
      prefix: --outfile
  - id: ignore_contigs
    type:
      - 'null'
      - string
    doc: Comma separated list of contigs to ignore.
    inputBinding:
      position: 101
      prefix: --ignore-contigs
outputs:
  - id: output_file
    type: File
    doc: The joined bigWig file.
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cgpbigwig:1.7.0--h523f0d1_0
