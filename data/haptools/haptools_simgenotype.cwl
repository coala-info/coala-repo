cwlVersion: v1.2
class: CommandLineTool
baseCommand: haptools simgenotype
label: haptools_simgenotype
doc: "Simulate admixed genomes under a pre-defined model.\n\nTool homepage: https://github.com/cast-genomics/haptools"
inputs:
  - id: chroms
    type:
      - 'null'
      - string
    doc: Sorted and comma delimited list of chromosomes to simulate
    inputBinding:
      position: 101
      prefix: --chroms
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: If requesting a PGEN output file, write genotypes in chunks of X 
      variants; reduces memory
    default: all variants
    inputBinding:
      position: 101
      prefix: --chunk-size
  - id: mapdir
    type: Directory
    doc: Directory containing files with chr{1-22,X} and ending in .map in the 
      file name with genetic map coords.
    inputBinding:
      position: 101
      prefix: --mapdir
  - id: model
    type: string
    doc: Admixture model in .dat format. See File Formats under simgenotype in 
      the docs for complete info.
    inputBinding:
      position: 101
      prefix: --model
  - id: no_replacement
    type:
      - 'null'
      - boolean
    doc: Flag used to determine whether to sample reference haplotypes with or 
      without replacement. (Default = Replacement)
    inputBinding:
      position: 101
      prefix: --no_replacement
  - id: only_breakpoint
    type:
      - 'null'
      - boolean
    doc: Flag used to determine whether to only output breakpoints or continue 
      to simulate a vcf file.
    inputBinding:
      position: 101
      prefix: --only_breakpoint
  - id: pop_field
    type:
      - 'null'
      - boolean
    doc: Flag for outputting the population field in your VCF output. NOTE this 
      flag does not work when your output file is in PGEN format.
    inputBinding:
      position: 101
      prefix: --pop_field
  - id: ref_vcf
    type: File
    doc: VCF or PGEN file used as reference for creation of simulated samples 
      respective genotypes.
    inputBinding:
      position: 101
      prefix: --ref_vcf
  - id: region
    type:
      - 'null'
      - string
    doc: Subset the simulation to a specific region in a chromosome using the 
      form chrom:start-end. Example 2:1000-2000
    inputBinding:
      position: 101
      prefix: --region
  - id: sample_field
    type:
      - 'null'
      - boolean
    doc: Flag for outputting the sample field in your VCF output. NOTE this flag
      does not work when your output file is in PGEN format.
    inputBinding:
      position: 101
      prefix: --sample_field
  - id: sample_info
    type: File
    doc: File that maps samples from the reference VCF (--invcf) to population 
      codes describing the populations in the header of the model file.
    inputBinding:
      position: 101
      prefix: --sample_info
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed. Set to make simulations reproducible
    inputBinding:
      position: 101
      prefix: --seed
  - id: verbosity
    type:
      - 'null'
      - string
    doc: The level of verbosity desired
    default: INFO
    inputBinding:
      position: 101
      prefix: --verbosity
outputs:
  - id: out
    type: File
    doc: Path to desired output file. E.g. /path/to/output.vcf.gz Possible 
      outputs are vcf|bcf|vcf.gz|pgen and there will be an additional 
      breakpoints output with extension bp e.g. /path/to/output.bp.
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haptools:0.6.2--pyhdfd78af_0
