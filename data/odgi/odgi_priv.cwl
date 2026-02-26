cwlVersion: v1.2
class: CommandLineTool
baseCommand: odgi priv
label: odgi_priv
doc: "Differentially private sampling of graph subpaths. Apply the exponential mechanism
  to randomly sample shared sub-haplotypes with a given ε, target coverage, and minimum
  length.\n\nTool homepage: https://github.com/vgteam/odgi"
inputs:
  - id: bp_target
    type:
      - 'null'
      - int
    doc: Target sampled haplotype length. All long haplotypes tend to be rare, 
      so setting this to lengths greater than the typical recombination block 
      size will result in long runtimes and poor sampling of the graph.
    default: 10000
    inputBinding:
      position: 101
      prefix: --bp-target
  - id: epsilon
    type:
      - 'null'
      - float
    doc: Epsilon (ε) for exponential mechanism.
    default: 0.01
    inputBinding:
      position: 101
      prefix: --epsilon
  - id: idx
    type: File
    doc: Load the succinct variation graph in ODGI format from this *FILE* (both
      GFAv1 and .og format accepted).
    inputBinding:
      position: 101
      prefix: --idx
  - id: min_hap_freq
    type:
      - 'null'
      - int
    doc: Minimum frequency (count) of haplotype observation to emit. 
      Singularities occur at -c 1, so we warn against its use.
    default: 2
    inputBinding:
      position: 101
      prefix: --min-hap-freq
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Write the current progress to stderr.
    inputBinding:
      position: 101
      prefix: --progress
  - id: target_depth
    type:
      - 'null'
      - int
    doc: Sample until we have approximately this path depth over the graph.
    default: 1
    inputBinding:
      position: 101
      prefix: --target-depth
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallel operations.
    inputBinding:
      position: 101
      prefix: --threads
  - id: write_haps
    type:
      - 'null'
      - boolean
    doc: Write each sampled haplotype to stdout.
    inputBinding:
      position: 101
      prefix: --write-haps
outputs:
  - id: out
    type: File
    doc: Write the graph with sub-paths sampled under differential privacy to 
      this FILE (.og recommended).
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
