cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - python3
  - PStrain.py
label: pstrain
doc: "PStrain: profile strains in shotgun metagenomic sequencing reads.\n\nTool homepage:
  https://github.com/wshuai294/PStrain"
inputs:
  - id: bowtie2
    type:
      - 'null'
      - File
    doc: Path to bowtie2 binary.
    inputBinding:
      position: 101
      prefix: --bowtie2
  - id: bowtie2_build
    type:
      - 'null'
      - File
    doc: Path to bowtie2 binary.
    inputBinding:
      position: 101
      prefix: --bowtie2-build
  - id: bowtie2db
    type: Directory
    doc: Path to metaphlan bowtie2db.
    inputBinding:
      position: 101
      prefix: --bowtie2db
  - id: conf
    type: File
    doc: The configuration file of the input samples.
    inputBinding:
      position: 101
      prefix: --conf
  - id: elbow
    type:
      - 'null'
      - float
    doc: The cutoff of elbow method while identifying strains number.
    inputBinding:
      position: 101
      prefix: --elbow
  - id: gatk
    type:
      - 'null'
      - File
    doc: Path to gatk binary.
    inputBinding:
      position: 101
      prefix: --gatk
  - id: lambda1
    type:
      - 'null'
      - float
    doc: The weight of prior knowledge while rectifying genotype frequencies. 
      The value is between 0~1.
    inputBinding:
      position: 101
      prefix: --lambda1
  - id: lambda2
    type:
      - 'null'
      - float
    doc: The weight of prior estimation while rectifying second order genotype 
      frequencies. The value is between 0~1.
    inputBinding:
      position: 101
      prefix: --lambda2
  - id: metaphlan
    type:
      - 'null'
      - File
    doc: Path to metaphlan.
    inputBinding:
      position: 101
      prefix: --metaphlan
  - id: metaphlan_index
    type: string
    doc: metaphlan bowtie2db index.
    inputBinding:
      position: 101
      prefix: --metaphlan_index
  - id: metaphlan_output_files
    type:
      - 'null'
      - type: array
        items: File
    doc: If you have run metaphlan already, give metaphlan result file in each 
      line, the order should be the same with config file.
    inputBinding:
      position: 101
      prefix: --metaphlan_output_files
  - id: metaphlan_version
    type:
      - 'null'
      - int
    doc: Metaphlan version [3 or 4]. Used to download the corresponding 
      database.
    inputBinding:
      position: 101
      prefix: --metaphlan_version
  - id: nproc
    type:
      - 'null'
      - int
    doc: The number of CPUs to use for parallelizing the mapping with bowtie2.
    inputBinding:
      position: 101
      prefix: --nproc
  - id: picard
    type:
      - 'null'
      - File
    doc: Path to picard binary.
    inputBinding:
      position: 101
      prefix: --picard
  - id: prior
    type:
      - 'null'
      - File
    doc: The file of prior knowledge of genotype frequencies in the population.
    inputBinding:
      position: 101
      prefix: --prior
  - id: proc
    type:
      - 'null'
      - int
    doc: The number of process to use for parallelizing the whole pipeline, run 
      a sample in each process.
    inputBinding:
      position: 101
      prefix: --proc
  - id: qual
    type:
      - 'null'
      - int
    doc: The minimum quality score of SNVs to be considered in strain profiling 
      step.
    inputBinding:
      position: 101
      prefix: --qual
  - id: samtools
    type:
      - 'null'
      - File
    doc: Path to samtools binary.
    inputBinding:
      position: 101
      prefix: --samtools
  - id: similarity
    type:
      - 'null'
      - float
    doc: The similarity cutoff of hierachical clustering in merge step.
    inputBinding:
      position: 101
      prefix: --similarity
  - id: snp_ratio
    type:
      - 'null'
      - float
    doc: The SNVs of which the depth are less than the specific ratio of the 
      species's mean depth would be removed.
    inputBinding:
      position: 101
      prefix: --snp_ratio
  - id: species_dp
    type:
      - 'null'
      - int
    doc: The minimum depth of species to be considered in strain profiling step.
    inputBinding:
      position: 101
      prefix: --species_dp
  - id: weight
    type:
      - 'null'
      - float
    doc: The weight of genotype frequencies while computing loss, then the 
      weight of linked read type frequencies is 1-w. The value is between 0~1.
    inputBinding:
      position: 101
      prefix: --weight
outputs:
  - id: outdir
    type: Directory
    doc: The output directory.
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pstrain:1.0.3--h9ee0642_0
