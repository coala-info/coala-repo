cwlVersion: v1.2
class: CommandLineTool
baseCommand: polymutt
label: polymutt
doc: "Polymutt is a tool for genotype likelihood calculation and variant calling.\n\
  \nTool homepage: https://genome.sph.umich.edu/wiki/Polymutt"
inputs:
  - id: MT
    type:
      - 'null'
      - string
    doc: Non-autosome label for mitochondrial DNA
    default: MT
    inputBinding:
      position: 101
      prefix: --MT
  - id: all_sites
    type:
      - 'null'
      - boolean
    doc: Include all sites in output
    inputBinding:
      position: 101
      prefix: --all_sites
  - id: chrX
    type:
      - 'null'
      - string
    doc: Non-autosome label for chromosome X
    default: X
    inputBinding:
      position: 101
      prefix: --chrX
  - id: chrY
    type:
      - 'null'
      - string
    doc: Non-autosome label for chromosome Y
    default: Y
    inputBinding:
      position: 101
      prefix: --chrY
  - id: datfile
    type:
      - 'null'
      - string
    doc: Data file name
    inputBinding:
      position: 101
      prefix: -dname
  - id: denovo
    type:
      - 'null'
      - boolean
    doc: Enable de novo mutation model
    inputBinding:
      position: 101
      prefix: --denovo
  - id: ext
    type:
      - 'null'
      - boolean
    doc: Enable extended output format
    inputBinding:
      position: 101
      prefix: --ext
  - id: gl_off
    type:
      - 'null'
      - boolean
    doc: Turn off genotype likelihoods in output
    inputBinding:
      position: 101
      prefix: --gl_off
  - id: glf_index_file
    type:
      - 'null'
      - string
    doc: GLF index file name
    inputBinding:
      position: 101
      prefix: -gname
  - id: in_vcf
    type:
      - 'null'
      - File
    doc: Alternative input VCF file
    inputBinding:
      position: 101
      prefix: --in_vcf
  - id: indel_theta
    type:
      - 'null'
      - float
    doc: Scaled indel mutation rate
    default: '1.0e-04'
    inputBinding:
      position: 101
      prefix: --indel_theta
  - id: maxDepth
    type:
      - 'null'
      - boolean
    doc: Filter by maximum depth
    inputBinding:
      position: 101
      prefix: --maxDepth
  - id: minDepth
    type:
      - 'null'
      - boolean
    doc: Filter by minimum depth
    inputBinding:
      position: 101
      prefix: --minDepth
  - id: minLLR_denovo
    type:
      - 'null'
      - float
    doc: Minimum LLR for de novo mutation calls
    default: '-3.0e+00'
    inputBinding:
      position: 101
      prefix: --minLLR_denovo
  - id: minMapQuality
    type:
      - 'null'
      - boolean
    doc: Filter by minimum mapping quality
    inputBinding:
      position: 101
      prefix: --minMapQuality
  - id: minPercSampleWithData
    type:
      - 'null'
      - float
    doc: Minimum percentage of samples with data
    default: '0.00'
    inputBinding:
      position: 101
      prefix: --minPercSampleWithData
  - id: mixed_vcf_records
    type:
      - 'null'
      - boolean
    doc: Allow mixed VCF records
    inputBinding:
      position: 101
      prefix: --mixed_vcf_records
  - id: nthreads
    type:
      - 'null'
      - int
    doc: Number of threads for multiple threading
    default: 1
    inputBinding:
      position: 101
      prefix: --nthreads
  - id: pedfile
    type:
      - 'null'
      - string
    doc: Pedigree file name
    inputBinding:
      position: 101
      prefix: -pname
  - id: poly_tstv
    type:
      - 'null'
      - float
    doc: Prior of ts/tv ratio
    default: '2.00'
    inputBinding:
      position: 101
      prefix: --poly_tstv
  - id: posterior_cutoff
    type:
      - 'null'
      - float
    doc: Posterior probability cutoff
    default: 0.5
    inputBinding:
      position: 101
      prefix: -c99.999
  - id: prec
    type:
      - 'null'
      - float
    doc: Optimization precision
    default: '1.0e-04'
    inputBinding:
      position: 101
      prefix: --prec
  - id: quick_call
    type:
      - 'null'
      - boolean
    doc: Perform a quick variant call
    inputBinding:
      position: 101
      prefix: --quick_call
  - id: rate_denovo
    type:
      - 'null'
      - float
    doc: De novo mutation rate
    default: '1.5e-08'
    inputBinding:
      position: 101
      prefix: --rate_denovo
  - id: theta
    type:
      - 'null'
      - float
    doc: Scaled mutation rate
    default: '1.0e-03'
    inputBinding:
      position: 101
      prefix: --theta
  - id: tstv_denovo
    type:
      - 'null'
      - float
    doc: De novo transition/transversion ratio
    default: '2.00'
    inputBinding:
      position: 101
      prefix: --tstv_denovo
outputs:
  - id: out_vcf
    type:
      - 'null'
      - File
    doc: Output VCF file
    outputBinding:
      glob: $(inputs.out_vcf)
  - id: pos
    type:
      - 'null'
      - File
    doc: Output positions file
    outputBinding:
      glob: $(inputs.pos)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/polymutt:0.18--0
