cwlVersion: v1.2
class: CommandLineTool
baseCommand: portello
label: portello
doc: "Projects read alignments from personal assembly to reference\n\nTool homepage:
  https://github.com/PacificBiosciences/portello"
inputs:
  - id: assembly_to_ref
    type: File
    doc: "Assembly contig to reference genome alignment file in BAM/CRAM format\n\n\
      \          Alignment file must be sorted and indexed. Minimap2 or pbmm2 alignments
      can be used."
    inputBinding:
      position: 101
      prefix: --assembly-to-ref
  - id: input_assembly_mode
    type: string
    doc: "The input assembly mode changes portello's strategy for phasing annotation
      in the reampped read output\n\n          Possible values:\n          - fully-phased:\
      \     Set this option if input assembly contigs are fully phased (by trio-binning,
      Hi-C, etc..) such that the assembly haplotypes should be trusted when making
      read phasing haplotags\n          - partially-phased: Set this option if input
      assembly assembly contigs are psuedo-phased/dual-assembly output that we assume
      contain many haplotype swich errors. In this case read support will be used
      to segment smaller phase sets for read phasing haplotags"
    inputBinding:
      position: 101
      prefix: --input-assembly-mode
  - id: phased_het_vcf_prefix
    type:
      - 'null'
      - string
    doc: "Specify an output VCF prefix for phased heterozygous small variant calls
      from the input assembly contigs\n\n          This option is only valid for the
      \"partially-phased\" input-assembly-mode, and is only intended for debugging
      and benchmarking the accuracy of the read haplotagging. Per this goal, only
      phase-eligible heterozygous variants are included in the output. It is intended
      to be used with a benchmarking tool such as whatshap compare.\n          \n\
      \          The output files produced by this option will be {PREFIX}.vcf.gz
      and {PREFIX}.vcf.gz.tbi"
    inputBinding:
      position: 101
      prefix: --phased-het-vcf-prefix
  - id: read_to_assembly
    type: File
    doc: "Read to assembly alignment file in BAM/CRAM format\n\n          Alignment
      file must be sorted and indexed. Only pbmm2 alignments are supported for these
      alignments."
    inputBinding:
      position: 101
      prefix: --read-to-assembly
  - id: ref
    type: File
    doc: Genome reference in FASTA format
    inputBinding:
      position: 101
      prefix: --ref
  - id: target_region
    type:
      - 'null'
      - string
    doc: "Specify a target region for conversion\n\n          This option is for debugging
      only, to allow fast test conversion of smaller regions. This will not give the
      same result as a non-targeted run with region selection on the sorted remapped
      read bam."
    inputBinding:
      position: 101
      prefix: --target-region
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use. Defaults to all logical cpus detected
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: remapped_read_output
    type: File
    doc: "Filename to use for remapped read output, our '-' for stdout\n\n       \
      \   This file is written in unsorted BAM format. If written to stdout, this
      output will be uncompressed to optimize piping into samtools sort or similar
      method.\n          \n          Unmapped reads in this file have a good alignment
      to an assembly contig region which is not mappable to the reference, they should
      not be remapped to the reference sequence."
    outputBinding:
      glob: $(inputs.remapped_read_output)
  - id: unassembled_read_output
    type: File
    doc: "Filename to use for unmapped reads which are not (well) mapped to any assembly
      contig\n\n          This file is written in BAM format"
    outputBinding:
      glob: $(inputs.unassembled_read_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/portello:0.7.0--h9ee0642_0
