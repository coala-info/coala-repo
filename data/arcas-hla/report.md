# arcas-hla CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| arcas-hla_convert | Not completed | needs the IMGT/HLA reference, which arcasHLA builds (git clone of IMGT/HLA) only inside its own install folder; the image does not ship it, so on a real merged genotype table it stopped with dat/ref/hla.convert.json not found. |
| arcas-hla_customize | Failed | image problem: the command crashes on import with 'Bio.Alphabet has been removed from Biopython' (also needs the IMGT/HLA reference). |
| arcas-hla_extract | PASS |  |
| arcas-hla_genotype | Not completed | needs the IMGT/HLA reference, which arcasHLA builds (git clone of IMGT/HLA) only inside its own install folder; the image does not ship it, so on real extracted reads of the tool's test.bam it tried to clone the database and stopped. |
| arcas-hla_merge | PASS |  |
| arcas-hla_partial | Not completed | needs the IMGT/HLA reference, which arcasHLA builds (git clone of IMGT/HLA) only inside its own install folder; the image does not ship it, and it also needs a genotype.json from a genotype run that could not be done. |
| arcas-hla_quant | Not completed | needs a custom HLA index from arcasHLA customize, which cannot run in this image. |

## arcas-hla_extract

### Tool Description
Extracts chromosome 6 reads from bam

### Metadata
- **Docker Image**: quay.io/biocontainers/arcas-hla:0.6.0--hdfd78af_2
- **Homepage**: https://github.com/RabadanLab/arcasHLA
- **Package**: https://anaconda.org/channels/bioconda/packages/arcas-hla/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/arcas-hla/overview
- **Total Downloads**: 23.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/RabadanLab/arcasHLA
- **Stars**: N/A
### Original Help Text
```text
usage: arcasHLA extract [options] BAM file

positional arguments:
  bam                   /path/to/sample.bam

options:
  -h, --help            show this help message and exit
                        
  --log                 log file for run summary
                          default: sample.extract.log
                        
  --single              single-end reads
                          default: False
                        
  --unmapped            include unmapped reads
                          default: False
                        
  --allreads            output all reads to fastq
                          default: False
                        
  -o , --outdir         out directory
                        
  --temp                temp directory
                        
  --keep_files          keep intermediate files
                        
  -t THREADS, --threads THREADS
  -v, --verbose
```

## arcas-hla_genotype

### Tool Description
Types HLA genes from extracted reads

### Metadata
- **Docker Image**: quay.io/biocontainers/arcas-hla:0.6.0--hdfd78af_2
- **Homepage**: https://github.com/RabadanLab/arcasHLA
- **Package**: https://anaconda.org/channels/bioconda/packages/arcas-hla/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/arcas-hla/overview
- **Total Downloads**: 23.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/RabadanLab/arcasHLA
- **Stars**: N/A
### Original Help Text
```text
usage: arcasHLA genotype [options] FASTQs or alignment.p file

positional arguments:
  file                  list of fastq files (e.g. sample.extracted.fq.gz) or alignment file (sample.alignment.p)

options:
  -h, --help            show this help message and exit
                        
  --log                 log file for run summary
                        default: sample.genotype.log
                        
  -g , --genes          comma separated list of HLA genes
                        default: all
                        options: A, B, C, DMA, DMB, DOA, DOB, DPA1, DPB1, DQA1,
                        DQB1, DRA, DRB1, DRB3, DRB5, E, F, G, H, J, K, L
                        
  -p , --population     sample population
                        default: prior
                        options: asian_pacific_islander, black, caucasian, hispanic,
                        native_american, prior
                        
  --tolerance           convergence tolerance
                          default: 10e-7
                        
  --max_iterations      maximum # of iterations
                          default: 1000
                        
  --drop_iterations     EM iteration to start dropping low-support alleles
                          default: 20
                          recommended paired:20
                          recommended single: 4
                        
  --drop_threshold      proportion of max abundance allele needs to not be dropped
                          default: 0.1
                        
  --zygosity_threshold 
                        proportion of major allele abundance needed to be considered heterozygous
                          default: 0.1
                        
  --min_count           minimum gene read count required for genotyping 
                          default: 75
                        
  -o , --outdir         out directory
                        
  --temp                temp directory
                        
  --keep_files          keep intermediate files
                        
  -t , --threads 
  -v, --verbose
  -l AVG, --avg AVG     Estimated average fragment length for single-end reads
                          default: 200
                        
  -s STD, --std STD     Estimated standard deviation of fragment length for single-end reads
                          default: 20
                        
  --single              Include flag if single-end reads. Default is paired-end.
```

## arcas-hla_partial

### Tool Description
Types partial HLA genes from extracted reads

### Metadata
- **Docker Image**: quay.io/biocontainers/arcas-hla:0.6.0--hdfd78af_2
- **Homepage**: https://github.com/RabadanLab/arcasHLA
- **Package**: https://anaconda.org/channels/bioconda/packages/arcas-hla/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/arcas-hla/overview
- **Total Downloads**: 23.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/RabadanLab/arcasHLA
- **Stars**: N/A
### Original Help Text
```text
usage: arcasHLA partial [options] -G genotype.json FASTQ

positional arguments:
  file                  list of fastq files or ".partial.json" file

options:
  -h, --help            show this help message and exit
                        
  -G , --genotype       "genotype.json" file from arcasHLA genotype
  --log                 log file for run summary
                        default: sample.genotype.log
                        
  -g , --genes          comma separated list of HLA genes
                        default: all
                        options: A, B, C, DMA, DMB, DOA, DOB, DPA1, DPB1, DQA1,
                        DQB1, DRA, DRB1, DRB3, DRB5, E, F, G, H, J, K, L
                        
  -p , --population     sample population
                          default: prior
                          options: asian_pacific_islander, black, caucasian,
                          hispanic, native_american, prior
                        
  --tolerance           convergence tolerance
                          default: 10e-7
                        
  --max_iterations      maximum # of iterations
                          default: 1000
                        
  --drop_iterations     EM iteration to start dropping low-support alleles
                          default: 4
                        
  --drop_threshold      proportion of max abundance allele needs to not be dropped
                          default: 0.1
                        
  --zygosity_threshold 
                        proportion of major allele abundance needed to be considered heterozygous
                          default: 0.1
                        
  -o , --outdir         out directory
                        
  --temp                temp directory
                        
  --keep_files          keep intermediate files
                        
  -t THREADS, --threads THREADS
  -v, --verbose
  -l AVG, --avg AVG     Estimated average fragment length for single-end reads
                          default: 200
                        
  -s STD, --std STD     Estimated standard deviation of fragment length for single-end reads
                          default: 20
                        
  --single              Include flag if single-end reads. Default is paired-end.
```

## arcas-hla_customize

### Tool Description
Create custom HLA reference

### Metadata
- **Docker Image**: quay.io/biocontainers/arcas-hla:0.6.0--hdfd78af_2
- **Homepage**: https://github.com/RabadanLab/arcasHLA
- **Package**: https://anaconda.org/channels/bioconda/packages/arcas-hla/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/arcas-hla/overview
- **Total Downloads**: 23.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/RabadanLab/arcasHLA
- **Stars**: N/A
### Original Help Text
```text
usage: arcasHLA customize [options]

(Help could not be printed: the command crashes on import with 'ImportError: Bio.Alphabet has been removed from Biopython'. The options below are taken from the argparse definition in scripts/customize.py of the image.)

options:
  -h, --help          show this help message and exit
  -G , --genotype     comma-separated list of HLA alleles (e.g. A*01:01,A*11:01,...), arcasHLA output genotype.json or genotypes.json, or tsv with format specified in README.md
  -s , --subject      subject name, only required for list of alleles
  -g , --genes        comma separated list of HLA genes (default: all)
  --transcriptome     transcripts to include besides input HLAs; options: full, chr6, none (default: full)
  --resolution        genotype resolution, only use >2 when typing performed with assay or Sanger sequencing (default: 2)
  --grouping          type/number of transcripts to include per allele: single, g-group, protein-group (default: protein-group)
  -o , --outdir       out directory
  --temp              temp directory
  --keep_files        keep intermediate files
  -t , --threads
  -v, --verbose
```

## arcas-hla_quant

### Tool Description
Allele specific HLA quantification

### Metadata
- **Docker Image**: quay.io/biocontainers/arcas-hla:0.6.0--hdfd78af_2
- **Homepage**: https://github.com/RabadanLab/arcasHLA
- **Package**: https://anaconda.org/channels/bioconda/packages/arcas-hla/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/arcas-hla/overview
- **Total Downloads**: 23.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/RabadanLab/arcasHLA
- **Stars**: N/A
### Original Help Text
```text
usage: arcasHLA quant [options] FASTQs

positional arguments:
  file               list of fastq files

options:
  -h, --help         show this help message and exit
                     
  --sample SAMPLE    sample name
  --ref              arcasHLA quant_ref path (e.g. "/path/to/ref/sample")
                       
  -o , --outdir      out directory
                     
  --temp             temp directory
                     
  --keep_files       keep intermediate files
                     
  --single           Include flag if single-end reads. Default is paired-end.
                     
  -l AVG, --avg AVG  Estimated average fragment length for single-end reads
                       default: 200
                     
  -s STD, --std STD  Estimated standard deviation of fragment length for single-end reads
                       default: 20
                     
  --LOH              Include flag for estimated loss of heterozygosity. Must provide purity and ploidy estimates.
                     
  --purity PURITY    Estimated purity of sample
                       default: 1.0
                     
  --ploidy PLOIDY    Estimated ploidy of sample
                       default: 2.0
                     
  -t , --threads 
  -v, --verbose
```

## arcas-hla_merge

### Tool Description
Processes results into a tab-separated table

### Metadata
- **Docker Image**: quay.io/biocontainers/arcas-hla:0.6.0--hdfd78af_2
- **Homepage**: https://github.com/RabadanLab/arcasHLA
- **Package**: https://anaconda.org/channels/bioconda/packages/arcas-hla/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/arcas-hla/overview
- **Total Downloads**: 23.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/RabadanLab/arcasHLA
- **Stars**: N/A
### Original Help Text
```text
usage: arcasHLA merge [options]

options:
  -h, --help      show this help message and exit
                  
  -i , --indir    directory containing arcasHLA files
                  
  -o , --outdir   out directory
                  
  --run           run name
                  
  -v, --verbose
```

## arcas-hla_convert

### Tool Description
Converts HLA nomenclature/resolution

### Metadata
- **Docker Image**: quay.io/biocontainers/arcas-hla:0.6.0--hdfd78af_2
- **Homepage**: https://github.com/RabadanLab/arcasHLA
- **Package**: https://anaconda.org/channels/bioconda/packages/arcas-hla/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/arcas-hla/overview
- **Total Downloads**: 23.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/RabadanLab/arcasHLA
- **Stars**: N/A
### Original Help Text
```text
usage: arcasHLA convert [options]

positional arguments:
  file                tsv containing HLA genotypes, see github for example file structure.
                      

options:
  -h, --help          show this help message and exit
                      
  -r , --resolution   output resolution (1,2,3) or grouping (g-group, p-group)
                      
  -o , --outfile      output file
                        default: ./file_basename.resolution.tsv
                      
  -f, --force         force conversion for grouped alleles even if it results in loss of resolution
  -v, --verbose
```

## Metadata
- **Skill**: generated
