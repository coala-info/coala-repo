cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - coconet
  - preprocess
label: coconet-binning_preprocess
doc: "Preprocess data: filter the assembly by length, flag complete contigs and convert BAM coverage to h5 format\n\nTool homepage: https://github.com/Puumanamana/CoCoNet"
inputs:
  - id: output
    type: string
    doc: "Path to output directory (default: output)"
    inputBinding:
      position: 101
      prefix: --output
  - id: fasta
    type: File
    doc: "Path to your assembly file (fasta formatted)"
    inputBinding:
      position: 101
      prefix: --fasta
  - id: h5
    type:
      - 'null'
      - File
    doc: "Experimental: coverage in hdf5 format (keys are contigs, values are (sample, contig_len) ndarrays"
    inputBinding:
      position: 101
      prefix: --h5
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads (default: 5)"
    inputBinding:
      position: 101
      prefix: --threads
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "Print debugging statements"
    inputBinding:
      position: 101
      prefix: --debug
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Less verbose"
    inputBinding:
      position: 101
      prefix: --quiet
  - id: silent
    type:
      - 'null'
      - boolean
    doc: "Only error messages"
    inputBinding:
      position: 101
      prefix: --silent
  - id: continue_run
    type:
      - 'null'
      - boolean
    doc: "Start from last checkpoint. The output directory needs to be the same."
    inputBinding:
      position: 101
      prefix: --continue
  - id: bam
    type:
      - 'null'
      - type: array
        items: File
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
    doc: "List of paths to your coverage files (bam formatted)"
    inputBinding:
      position: 101
      prefix: --bam
  - id: min_ctg_len
    type:
      - 'null'
      - int
    doc: "Minimum contig length (default: 2048)"
    inputBinding:
      position: 101
      prefix: --min-ctg-len
  - id: min_prevalence
    type:
      - 'null'
      - int
    doc: "Minimum contig prevalence for binning. Contig with less that value are filtered out. (default: 2)"
    inputBinding:
      position: 101
      prefix: --min-prevalence
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: "Minimum alignment quality (default: 30)"
    inputBinding:
      position: 101
      prefix: --min-mapping-quality
  - id: min_aln_coverage
    type:
      - 'null'
      - int
    doc: "Discard alignments with less than 50% aligned nucleotides"
    inputBinding:
      position: 101
      prefix: --min-aln-coverage
  - id: flag
    type:
      - 'null'
      - int
    doc: "SAM flag for filtering (same as samtools \"-F\" option) (default: 3596)"
    inputBinding:
      position: 101
      prefix: --flag
  - id: tlen_range
    type:
      - 'null'
      - type: array
        items: int
    doc: "Only allow for paired alignments with spacing within this range (two values)"
    inputBinding:
      position: 101
      prefix: --tlen-range
  - id: min_dtr_size
    type:
      - 'null'
      - int
    doc: "Minimum size of DTR to flag complete contigs (default: 10)"
    inputBinding:
      position: 101
      prefix: --min-dtr-size
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coconet-binning:1.1.0--py_0
