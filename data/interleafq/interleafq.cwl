cwlVersion: v1.2
class: CommandLineTool
baseCommand: interleafq
label: interleafq
doc: "Interleave and deinterleave FASTQ paired reads. With two input files it interleaves them (result on standard output); with one input file it deinterleaves it into two files.\n\nTool homepage: https://github.com/quadram-institute-bioscience/interleafq/"
inputs:
  - id: fastq_files
    type:
      type: array
      items: File
    doc: Two FASTQ files (first and second pair) to interleave, or one interleaved FASTQ file to deinterleave. Files can be gzipped.
    inputBinding:
      position: 200
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Basename for the output files when deinterleaving. Produces "{prefix}_R1.fastq" and "{prefix}_R2.fastq" (the help calls it --output-prefix, but the program only accepts --output-basename or -o).
    inputBinding:
      position: 101
      prefix: --output-basename
  - id: first_pair
    type:
      - 'null'
      - string
    doc: Filename for the first pair produced when deinterleaving. Alternative to --output-prefix; if it ends with '.gz' a compressed file is written.
    inputBinding:
      position: 101
      prefix: --first-pair
  - id: second_pair
    type:
      - 'null'
      - string
    doc: Filename for the second pair produced when deinterleaving. Alternative to --output-prefix; if it ends with '.gz' a compressed file is written.
    inputBinding:
      position: 101
      prefix: --second-pair
  - id: gzip_output
    type:
      - 'null'
      - boolean
    doc: Compress the deinterleaved output files (adds .gz to the names produced with the output prefix). Option -z of the program; it is not listed in the help.
    inputBinding:
      position: 101
      prefix: --gzip-output
  - id: strip_comments
    type:
      - 'null'
      - boolean
    doc: Remove comments from the sequence headers (any string after the first space character in the read name line).
    inputBinding:
      position: 101
      prefix: --strip-comments
  - id: relaxed
    type:
      - 'null'
      - boolean
    doc: Do not check for inconsistencies in read names and sequence/quality length. The read names should be equal until the first '/'.
    inputBinding:
      position: 101
      prefix: --relaxed
  - id: force_interleave
    type:
      - 'null'
      - boolean
    doc: When supplying only the first pair-end file, set interleave mode and look for a second pair-end file (replacing _R1 with _R2).
    inputBinding:
      position: 101
      prefix: --force-interleave
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Display additional information (total printed sequences at the end, useful for truncated files).
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: interleaved
    type: stdout
    doc: Interleaved FASTQ (standard output; empty when deinterleaving)
  - id: deinterleaved
    type: File[]
    doc: Deinterleaved FASTQ files written when deinterleaving
    outputBinding:
      glob: |
        ${
          var g = [];
          if (inputs.output_prefix) {
            var x = inputs.gzip_output ? ".gz" : "";
            g.push(inputs.output_prefix + "_R1.fastq" + x, inputs.output_prefix + "_R2.fastq" + x);
          }
          if (inputs.first_pair) { g.push(inputs.first_pair); }
          if (inputs.second_pair) { g.push(inputs.second_pair); }
          return g;
        }
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/interleafq:1.1.0--pl5321hdfd78af_2
stdout: interleafq.out.fastq
