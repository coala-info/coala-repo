cwlVersion: v1.2
class: CommandLineTool
baseCommand: plink2
label: plink2
doc: "A whole-genome association analysis toolset, designed to handle large datasets
  and perform a wide range of genetic analyses including association testing, population
  structure analysis, and data management.\n\nTool homepage: https://www.cog-genomics.org/plink2"
inputs:
  - id: bcf
    type:
      - 'null'
      - File
    doc: Specify full name of BCF2 file to import.
    inputBinding:
      position: 101
      prefix: --bcf
  - id: bfile
    type:
      - 'null'
      - string
    doc: Specify .bed + .bim + .fam prefix.
    inputBinding:
      position: 101
      prefix: --bfile
  - id: bpfile
    type:
      - 'null'
      - string
    doc: Specify .pgen + .bim + .fam prefix.
    inputBinding:
      position: 101
      prefix: --bpfile
  - id: chr
    type:
      - 'null'
      - type: array
        items: string
    doc: Exclude all variants not on the given chromosome(s).
    inputBinding:
      position: 101
      prefix: --chr
  - id: covar
    type:
      - 'null'
      - File
    doc: Specify additional covariate file.
    inputBinding:
      position: 101
      prefix: --covar
  - id: exclude
    type:
      - 'null'
      - type: array
        items: File
    doc: Exclude all variants named in the given file(s).
    inputBinding:
      position: 101
      prefix: --exclude
  - id: export
    type:
      - 'null'
      - type: array
        items: string
    doc: Create a new fileset in a specified format (e.g., vcf, bgen, ped).
    inputBinding:
      position: 101
      prefix: --export
  - id: extract
    type:
      - 'null'
      - type: array
        items: File
    doc: Exclude all variants not named in the given file(s).
    inputBinding:
      position: 101
      prefix: --extract
  - id: fa
    type:
      - 'null'
      - File
    doc: Specify full name of reference FASTA file.
    inputBinding:
      position: 101
      prefix: --fa
  - id: geno
    type:
      - 'null'
      - float
    doc: Exclude variants with missing call frequencies greater than threshold (default
      0.1).
    inputBinding:
      position: 101
      prefix: --geno
  - id: glm
    type:
      - 'null'
      - boolean
    doc: Perform basic association analysis using linear or logistic regression.
    inputBinding:
      position: 101
      prefix: --glm
  - id: hwe
    type:
      - 'null'
      - float
    doc: Exclude variants with Hardy-Weinberg equilibrium exact test p-values less
      than threshold.
    inputBinding:
      position: 101
      prefix: --hwe
  - id: keep
    type:
      - 'null'
      - type: array
        items: File
    doc: Exclude all samples not named in a file.
    inputBinding:
      position: 101
      prefix: --keep
  - id: maf
    type:
      - 'null'
      - float
    doc: Exclude variants with allele frequency lower than threshold (default 0.01).
    inputBinding:
      position: 101
      prefix: --maf
  - id: make_bed
    type:
      - 'null'
      - boolean
    doc: Create a new PLINK 1 binary fileset (.bed + .bim + .fam).
    inputBinding:
      position: 101
      prefix: --make-bed
  - id: make_pgen
    type:
      - 'null'
      - boolean
    doc: Create a new PLINK 2 binary fileset (.pgen + .pvar + .psam).
    inputBinding:
      position: 101
      prefix: --make-pgen
  - id: memory
    type:
      - 'null'
      - int
    doc: Set size, in MiB, of initial workspace malloc attempt.
    inputBinding:
      position: 101
      prefix: --memory
  - id: mind
    type:
      - 'null'
      - float
    doc: Exclude samples with missing call frequencies greater than threshold (default
      0.1).
    inputBinding:
      position: 101
      prefix: --mind
  - id: pca
    type:
      - 'null'
      - int
    doc: Extract top principal components. Optional argument specifies count.
    inputBinding:
      position: 101
      prefix: --pca
  - id: pfile
    type:
      - 'null'
      - string
    doc: Specify .pgen + .pvar + .psam prefix.
    inputBinding:
      position: 101
      prefix: --pfile
  - id: pgen
    type:
      - 'null'
      - File
    doc: Specify full name of .pgen/.bed file.
    inputBinding:
      position: 101
      prefix: --pgen
  - id: pgi
    type:
      - 'null'
      - File
    doc: Specify full name of .pgen.pgi file.
    inputBinding:
      position: 101
      prefix: --pgi
  - id: pheno
    type:
      - 'null'
      - File
    doc: Specify additional phenotype/covariate file.
    inputBinding:
      position: 101
      prefix: --pheno
  - id: psam
    type:
      - 'null'
      - File
    doc: Specify full name of .psam/.fam file.
    inputBinding:
      position: 101
      prefix: --psam
  - id: pvar
    type:
      - 'null'
      - File
    doc: Specify full name of .pvar/.bim file.
    inputBinding:
      position: 101
      prefix: --pvar
  - id: remove
    type:
      - 'null'
      - type: array
        items: File
    doc: Exclude all samples named in a file.
    inputBinding:
      position: 101
      prefix: --remove
  - id: threads
    type:
      - 'null'
      - int
    doc: Set maximum number of compute threads.
    inputBinding:
      position: 101
      prefix: --threads
  - id: vcf
    type:
      - 'null'
      - File
    doc: Specify full name of .vcf or .vcf.gz file to import.
    inputBinding:
      position: 101
      prefix: --vcf
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Specify prefix for output files.
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plink2:2.0.0a.6.9--h9948957_0
