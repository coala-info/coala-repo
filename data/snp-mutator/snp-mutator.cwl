cwlVersion: v1.2
class: CommandLineTool
baseCommand: snpmutator
label: snp-mutator
doc: "Generate mutated sequence files from a reference genome. Takes a fasta file and
  creates a specified number of randomly generated base substitutions, insertions,
  and deletions. Outputs the mutated genomes, and optionally, a summary file listing
  the mutations by position.\n\nTool homepage: https://github.com/CFSAN-Biostatistics/snp-mutator"
inputs:
  - id: input_fasta_file
    type: File
    doc: Input fasta file.
    inputBinding:
      position: 2
  - id: num_simulations
    type:
      - 'null'
      - int
    doc: Number of mutated sequences to generate. (default 100)
    inputBinding:
      position: 1
      prefix: --num-simulations
  - id: num_substitutions
    type:
      - 'null'
      - int
    doc: Number of substitutions. (default 500)
    inputBinding:
      position: 1
      prefix: --num-substitutions
  - id: num_insertions
    type:
      - 'null'
      - int
    doc: Number of insertions. (default 20)
    inputBinding:
      position: 1
      prefix: --num-insertions
  - id: num_deletions
    type:
      - 'null'
      - int
    doc: Number of deletions. (default 20)
    inputBinding:
      position: 1
      prefix: --num-deletions
  - id: random_seed
    type:
      - 'null'
      - int
    doc: Random number seed; if not set, the results are not reproducible.
    inputBinding:
      position: 1
      prefix: --random-seed
  - id: pool
    type:
      - 'null'
      - int
    doc: Choose variants from a pool of eligible positions of the specified size. (default 0)
    inputBinding:
      position: 1
      prefix: --pool
  - id: group
    type:
      - 'null'
      - int
    doc: Group size. When greater than zero, this parameter chooses a new pool of positions for each group of replicates.
    inputBinding:
      position: 1
      prefix: --group
  - id: mono
    type:
      - 'null'
      - boolean
    doc: Create monomorphic alleles.
    inputBinding:
      position: 1
      prefix: --mono
  - id: seqid
    type:
      - 'null'
      - string
    doc: Output fasta description line sequence ID. Each mutated output file has only one sequence. If not specified, the defline id will be the id of the first sequence in the input fasta file. The defline is always suffixed with an annotation in this format (mutated s=900 i=50 d=50). The seq id is also written to the CHROM column of the output VCF file.
    inputBinding:
      position: 1
      prefix: --seqid
  - id: ref
    type:
      - 'null'
      - string
    doc: Output concatenated reference file with no mutations, but all sequences concatenated together. All the replicates will be mutations of this file.
    inputBinding:
      position: 1
      prefix: --ref
  - id: fasta_dir
    type:
      - 'null'
      - string
    doc: Output directory for generated fasta files. (default .)
    inputBinding:
      position: 1
      prefix: --fasta-dir
  - id: summary
    type:
      - 'null'
      - string
    doc: Output positional summary file.
    inputBinding:
      position: 1
      prefix: --summary
  - id: vcf
    type:
      - 'null'
      - string
    doc: Output VCF file.
    inputBinding:
      position: 1
      prefix: --vcf
  - id: metrics
    type:
      - 'null'
      - string
    doc: Output metrics file.
    inputBinding:
      position: 1
      prefix: --metrics
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: mutated_fasta
    type:
      type: array
      items: File
    doc: Mutated genomes written to the fasta directory (all files in it, or in the working
      directory when no directory is given)
    outputBinding:
      glob: "$(inputs.fasta_dir ? inputs.fasta_dir + '/*' : '*.fasta')"
  - id: ref_out
    type:
      - 'null'
      - File
    doc: Concatenated reference without mutations
    outputBinding:
      glob: $(inputs.ref)
  - id: summary_out
    type:
      - 'null'
      - File
    doc: Positional summary file
    outputBinding:
      glob: $(inputs.summary)
  - id: vcf_out
    type:
      - 'null'
      - File
    doc: VCF file listing the mutations
    outputBinding:
      glob: $(inputs.vcf)
  - id: metrics_out
    type:
      - 'null'
      - File
    doc: Metrics file
    outputBinding:
      glob: $(inputs.metrics)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snp-mutator:1.2.0--pyh24bf2e0_0
stdout: snp-mutator.out
