cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rtg
  - pedsamplesim
label: rtg-tools_rtg_pedsamplesim
doc: 'Generates simulated genotypes for all members of a pedigree. Tool homepage: https://github.com/RealTimeGenomics/rtg-tools'
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input
    type: File
    doc: 'input VCF containing parent variants'
    secondaryFiles:
      - pattern: .tbi
        required: false
    inputBinding:
      position: 101
      prefix: --input
  - id: output
    type: string
    doc: 'directory for output'
    inputBinding:
      position: 101
      prefix: --output
  - id: output_sdf
    type:
      - 'null'
      - boolean
    doc: 'if set, output an SDF for the genome of each simulated sample'
    inputBinding:
      position: 101
      prefix: --output-sdf
  - id: pedigree
    type: File
    doc: 'genome relationships PED file'
    inputBinding:
      position: 101
      prefix: --pedigree
  - id: reference
    type: Directory
    doc: 'SDF containing the reference genome'
    inputBinding:
      position: 101
      prefix: --reference
  - id: extra_crossovers
    type:
      - 'null'
      - float
    doc: 'probability of extra crossovers per chromosome (Default is 0.01)'
    inputBinding:
      position: 101
      prefix: --extra-crossovers
  - id: genetic_map_dir
    type:
      - 'null'
      - Directory
    doc: 'if set, load genetic maps from this directory for recombination point selection'
    inputBinding:
      position: 101
      prefix: --genetic-map-dir
  - id: no_gzip
    type:
      - 'null'
      - boolean
    doc: 'do not gzip the output'
    inputBinding:
      position: 101
      prefix: --no-gzip
  - id: num_mutations
    type:
      - 'null'
      - int
    doc: 'expected number of mutations per genome (Default is 70)'
    inputBinding:
      position: 101
      prefix: --num-mutations
  - id: ploidy
    type:
      - 'null'
      - string
    doc: 'ploidy to use. Allowed values are [auto, diploid, haploid] (Default is auto)'
    inputBinding:
      position: 101
      prefix: --ploidy
  - id: remove_unused
    type:
      - 'null'
      - boolean
    doc: 'if set, output only variants used by at least one sample'
    inputBinding:
      position: 101
      prefix: --remove-unused
  - id: seed
    type:
      - 'null'
      - int
    doc: 'seed for the random number generator'
    inputBinding:
      position: 101
      prefix: --seed
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: outdir
    type: Directory
    doc: Output directory with the simulated sample VCF (and SDFs)
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
stdout: rtg-tools_rtg_pedsamplesim.out
