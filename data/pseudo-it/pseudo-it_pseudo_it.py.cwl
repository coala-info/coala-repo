cwlVersion: v1.2
class: CommandLineTool
baseCommand: pseudo_it.py
label: pseudo-it_pseudo_it.py
doc: "Pseudo assembly by iterative mapping. Genomes assembly by iterative mapping.\n\
  \nTool homepage: https://github.com/goodest-goodlab/pseudo-it"
inputs:
  - id: bam
    type:
      - 'null'
      - File
    doc: 'OPTIONAL: A BAM file with the provided reads mapped to the reference to
      be used for the first iteration. This BAM file must be pre-indexed with samtools
      index.'
    inputBinding:
      position: 101
      prefix: -bam
  - id: bcftools_path
    type:
      - 'null'
      - string
    doc: The path to the bcftools progam.
    inputBinding:
      position: 101
      prefix: -bcftools
  - id: bed
    type:
      - 'null'
      - File
    doc: A bed file. Only intervals in this file will have variants called.
    inputBinding:
      position: 101
      prefix: -bed
  - id: bed_mode
    type:
      - 'null'
      - string
    doc: When a .bed file is provided, this option specifies how it is used. 
      With 'regions', each entry in the bed file will be run with it's own 
      instance of gatk. With 'file', a single instance of gatk will be run for 
      all regions.
    inputBinding:
      position: 101
      prefix: -bedmode
  - id: bedtools_path
    type:
      - 'null'
      - string
    doc: The path to the bedtools progam.
    inputBinding:
      position: 101
      prefix: -bedtools
  - id: depcheck
    type:
      - 'null'
      - boolean
    doc: Run this to check that all dependencies are installed at the provided 
      path.
    inputBinding:
      position: 101
      prefix: --depcheck
  - id: diploid
    type:
      - 'null'
      - boolean
    doc: Set this use IUPAC ambiguity codes in the final FASTA file.
    inputBinding:
      position: 101
      prefix: --diploid
  - id: dryrun
    type:
      - 'null'
      - boolean
    doc: With all options provided, set this to run through the whole pseudo-it 
      pipeline without executing external commands.
    inputBinding:
      position: 101
      prefix: --dryrun
  - id: filter
    type:
      - 'null'
      - string
    doc: The expression to filter variants. Must conform to VCF INFO field 
      standards.
    inputBinding:
      position: 101
      prefix: -f
  - id: gatk_path
    type:
      - 'null'
      - string
    doc: The path to the GATK progam.
    inputBinding:
      position: 101
      prefix: -gatk
  - id: gatk_threads
    type:
      - 'null'
      - int
    doc: The number of threads for GATK's Haplotype caller to use.
    inputBinding:
      position: 101
      prefix: -gatk-t
  - id: keepall
    type:
      - 'null'
      - boolean
    doc: Set this option to keep all intermediate files.
    inputBinding:
      position: 101
      prefix: --keepall
  - id: keeponlyfinal
    type:
      - 'null'
      - boolean
    doc: Set this option to keep these files ONLY for the final iteration.
    inputBinding:
      position: 101
      prefix: --keeponlyfinal
  - id: map_threads
    type:
      - 'null'
      - int
    doc: The number of threads for the mapper to use for each read type.
    inputBinding:
      position: 101
      prefix: -map-t
  - id: maponly
    type:
      - 'null'
      - boolean
    doc: Only do one iteration and stop after read mapping.
    inputBinding:
      position: 101
      prefix: --maponly
  - id: mapper
    type:
      - 'null'
      - string
    doc: 'The name of the mapping progam. One of: bwa, hisat2.'
    inputBinding:
      position: 101
      prefix: -mapper
  - id: mapper_path
    type:
      - 'null'
      - string
    doc: The path to the mapping program. By default, just the name of the 
      program.
    inputBinding:
      position: 101
      prefix: -mapperpath
  - id: mask_opt
    type:
      - 'null'
      - string
    doc: The type of masking to perform on the final consensus sequence for 
      sites without genotypes called. 'hard', 'soft', or 'none'.
    inputBinding:
      position: 101
      prefix: -mask
  - id: noindels
    type:
      - 'null'
      - boolean
    doc: Set this to not incorporate indels into the final assembly.
    inputBinding:
      position: 101
      prefix: --noindels
  - id: nomkdups
    type:
      - 'null'
      - boolean
    doc: Do not run Picard's MarkDuplicates on mapped reads.
    inputBinding:
      position: 101
      prefix: --nomkdups
  - id: num_iters
    type:
      - 'null'
      - int
    doc: The number of iterations Pseudo-it will run.
    inputBinding:
      position: 101
      prefix: -i
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Set this to overwrite existing files.
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: pe1
    type:
      - 'null'
      - File
    doc: A FASTQ file containing pair 1 of paired-end reads. At least one of 
      -se, -pe1 and pe2, or pem must be provided.
    inputBinding:
      position: 101
      prefix: -pe1
  - id: pe2
    type:
      - 'null'
      - File
    doc: A FASTQ file containing pair 2 of paired-end reads. At least one of 
      -se, -pe1 and pe2, or pem must be provided.
    inputBinding:
      position: 101
      prefix: -pe2
  - id: pem
    type:
      - 'null'
      - File
    doc: A FASTQ file containing merged paired-end reads. At least one of -se, 
      -pe1 and pe2, or pem must be provided.
    inputBinding:
      position: 101
      prefix: -pem
  - id: picard_path
    type:
      - 'null'
      - string
    doc: 'The exact command used to run picard. For a jar file: java -jar <full path
      to jar file>. For an alias or conda install: picard. Include heap size in command,
      i.e. -Xmx6g.'
    inputBinding:
      position: 101
      prefix: -picard
  - id: processes
    type:
      - 'null'
      - int
    doc: The MAX number of processes Pseudo-it can use.
    inputBinding:
      position: 101
      prefix: -p
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Set this flag to prevent psuedo-it from reporting detailed information 
      about each step.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: ref
    type:
      - 'null'
      - File
    doc: The FASTA assembly to use for the initial mapping.
    inputBinding:
      position: 101
      prefix: -ref
  - id: resume
    type:
      - 'null'
      - Directory
    doc: The path to a previous Pseudo-it directory to resume a run. Scans for 
      presence of files and resumes when it can't find an expected file.
    inputBinding:
      position: 101
      prefix: -resume
  - id: samtools_path
    type:
      - 'null'
      - string
    doc: The path to the samtools progam.
    inputBinding:
      position: 101
      prefix: -samtools
  - id: se
    type:
      - 'null'
      - File
    doc: A FASTQ file containing single-end reads. At least one of -se, -pe1 and
      pe2, or pem must be provided.
    inputBinding:
      position: 101
      prefix: -se
  - id: strandness
    type:
      - 'null'
      - string
    doc: For use with hisat2 and stranded RNA-seq data. Either 'RF' or 'FR'.
    inputBinding:
      position: 101
      prefix: -strandness
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Some programs write files to a temporary directory. If your default tmp
      dir is size limited, specify a new one here, or just specifiy 'tmp-pi-out'
      to have a folder called 'tmp' created and used within the main output 
      folder.
    inputBinding:
      position: 101
      prefix: -tmp
  - id: vcf
    type:
      - 'null'
      - File
    doc: A VCF with variants to IGNORE in the called data. Beta mode -- only use
      for small genomes.
    inputBinding:
      position: 101
      prefix: -vcf
outputs:
  - id: out_dest
    type:
      - 'null'
      - Directory
    doc: "Desired output directory. This will be created for you if it doesn't exist.
      Default: pseudoit-[date]-[time]"
    outputBinding:
      glob: $(inputs.out_dest)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pseudo-it:3.1.1--pyhdfd78af_0
