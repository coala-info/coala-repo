cwlVersion: v1.2
class: CommandLineTool
baseCommand: readmutselomega
label: bayescode_readmutselomega
doc: "Computes posterior probabilities of ω and ω₀, and related statistics.\n\nTool
  homepage: https://github.com/ThibaultLatrille/bayescode"
inputs:
  - id: chain_name
    type: string
    doc: Chain name (output file prefix).
    inputBinding:
      position: 1
  - id: burnin
    type:
      - 'null'
      - int
    doc: Number of MCMC iterations for the burn-in.
    inputBinding:
      position: 102
      prefix: --burnin
  - id: chain_omega
    type:
      - 'null'
      - string
    doc: A second chain ran with the option --freeomega and --flatfitness to 
      obtain the classical ω-based codon model (Muse & Gaut). These two chains 
      allow to compute posterior of ω, ω₀, ωᴬ=ω-ω₀ and p(ωᴬ>0) for each site and
      at the gene level. Results are written in {chain_name}.omegaA.tsv by 
      default (optionally use the --output argument to specify a different 
      output path).
    inputBinding:
      position: 102
      prefix: --chain_omega
  - id: confidence_interval
    type:
      - 'null'
      - string
    doc: Boundary for posterior credible interval of ω and ω₀ (per site and at 
      the gene level). Default value is 0.025 at each side, meaning computing 
      the 1-2*0.025=95% CI.
    default: 0.025 at each side
    inputBinding:
      position: 102
      prefix: --confidence_interval
  - id: every
    type:
      - 'null'
      - int
    doc: Number of MCMC iterations between two saved point in the trace.
    inputBinding:
      position: 102
      prefix: --every
  - id: ignore_rest
    type:
      - 'null'
      - boolean
    doc: Ignores the rest of the labeled arguments following this flag.
    inputBinding:
      position: 102
      prefix: --
  - id: nuc
    type:
      - 'null'
      - boolean
    doc: Mean posterior 4x4 nucleotide matrix.Results are written in 
      {chain_name}.nucmatrix.tsv by default (optionally use the --output 
      argument to specify a different output path).
    inputBinding:
      position: 102
      prefix: --nuc
  - id: omega
    type:
      - 'null'
      - boolean
    doc: Compute posterior credible interval for ω for each site and at the gene
      level. Can be combined with the option `confidence_interval` to change the
      default value (0.025 at each side of the distribution). Results are 
      written in {chain_name}.ci{confidence_interval}.tsv by default (optionally
      use the --output argument to specify a different output path).
    inputBinding:
      position: 102
      prefix: --omega
  - id: omega_0
    type:
      - 'null'
      - boolean
    doc: Compute posterior credible interval for ω₀ predicted at the 
      mutation-selection equilibrium from the fitness profiles, for each site 
      and at the gene level. Can be combined with the option 
      `confidence_interval` to change the default value (0.025 at each side of 
      the distribution). Results are written in 
      {chain_name}.ci{confidence_interval}.tsv by default (optionally use the 
      --output argument to specify a different output path).
    inputBinding:
      position: 102
      prefix: --omega_0
  - id: omega_threshold
    type:
      - 'null'
      - string
    doc: Threshold to compute the mean posterior probability that ω⁎ (or ω if 
      option `flatfitness` is used in `mutselomega`) is greater than a given 
      value (1.0 to test for adaptation). Results are written in 
      {chain_name}.omegappgt{omega_pp}.tsv by default (optionally use the 
      --output argument to specify a different output path).
    inputBinding:
      position: 102
      prefix: --omega_threshold
  - id: ppred
    type:
      - 'null'
      - boolean
    doc: For each point of the chain (after burn-in), produces a data replicate 
      simulated from the posterior predictive distribution
    inputBinding:
      position: 102
      prefix: --ppred
  - id: ss
    type:
      - 'null'
      - boolean
    doc: Computes the mean posterior site-specific amino-acid equilibrium 
      frequencies(amino-acid fitness profiles). Results are written in 
      {chain_name}.siteprofiles by default (optionally use the --output argument
      to specify a different output path).
    inputBinding:
      position: 102
      prefix: --ss
  - id: trace
    type:
      - 'null'
      - boolean
    doc: Recompute the trace.Trace is written in {chain_name}.trace.tsv by 
      default (optionally use the --output argument to specify a different 
      output path).
    inputBinding:
      position: 102
      prefix: --trace
  - id: until
    type:
      - 'null'
      - int
    doc: Maximum number of (saved) iterations (-1 means unlimited).
    default: -1
    inputBinding:
      position: 102
      prefix: --until
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file path (optional)
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bayescode:1.3.4--h9948957_0
