# chewbbaca CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| chewbbaca_AlleleCall | PASS |  |
| chewbbaca_AlleleCallEvaluator | PASS |  |
| chewbbaca_ComputeMSA | PASS |  |
| chewbbaca_CreateSchema | PASS |  |
| chewbbaca_DownloadSchema | PASS |  |
| chewbbaca_ExtractCgMLST | PASS |  |
| chewbbaca_GetAlleles | PASS |  |
| chewbbaca_JoinProfiles | PASS |  |
| chewbbaca_LoadSchema | Not completed | Uploading a schema needs a Chewie-NS account with upload rights, so it was not run. |
| chewbbaca_NSStats | PASS |  |
| chewbbaca_PrepExternalSchema | PASS |  |
| chewbbaca_RemoveGenes | PASS |  |
| chewbbaca_SchemaEvaluator | PASS |  |
| chewbbaca_SyncSchema | Not completed | The only downloadable test schema has no remote updates, so the tool stops with exit 1 and 'Local schema is up-to-date'; nothing to sync. |
| chewbbaca_UniprotFinder | PASS |  |

## chewbbaca_CreateSchema

### Tool Description
Create a schema seed.

### Metadata
- **Docker Image**: quay.io/biocontainers/chewbbaca:3.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/B-UMMI/chewBBACA
- **Package**: https://anaconda.org/channels/bioconda/packages/chewbbaca/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chewbbaca/overview
- **Total Downloads**: 97.0K
- **Last updated**: 2026-01-11
- **GitHub**: https://github.com/B-UMMI/chewBBACA
- **Stars**: N/A
### Original Help Text
```text
chewBBACA version: 3.5.1
Authors: Rafael Mamede, Pedro Cerqueira, Mickael Silva, João Carriço, Mário Ramirez
Github: https://github.com/B-UMMI/chewBBACA
Documentation: https://chewbbaca.readthedocs.io/en/latest/index.html
Contacts: imm-bioinfo@medicina.ulisboa.pt

============================
  chewBBACA - CreateSchema
============================
usage: chewBBACA.py CreateSchema --input-files <path> --output-directory <dir> [options]

Create a schema seed.

options:
 -h, --help                  show this help message and exit
                             
 -i, --input-files           Path to the directory that contains the input FASTA files or to a file
                             with a list of full paths to FASTA files, one per line. (default: None)
                             
 -o, --output-directory      Output directory where the process will store intermediate files and
                             create the schema's directory. (default: None)
                             
 --n, --schema-name          Name given to the schema folder. (default: schema_seed)
                             
 --ptf, --training-file      Path to the Prodigal training file used by Pyrodigal to predict genes.
                             The translation table used to create this file overrides any value
                             passed to `--t`, `--translation-table`. This file is copied to the
                             schema folder to be used for allele calling. (default: None)
                             
 --bsr, --blast-score-ratio  BLAST Score Ratio (BSR) value. The BSR is computed for each BLASTp
                             alignment and aligned sequences with a BSR >= than the defined value
                             are considered to be alleles of the same gene. (default: 0.6)
                             
 --l, --minimum-length       Minimum sequence length value. Predicted coding sequences (CDSs)
                             shorter than this value are excluded. (default: 201)
                             
 --t, --translation-table    Genetic code used to predict genes and to translate coding DNA
                             sequences (CDSs). This value is ignored if a valid training file is
                             passed to `--ptf`, `--training-file`. (default: None)
                             
 --st, --size-threshold      Coding sequence (CDS) size variation threshold. Added to the schema's
                             config file to identify alleles with a size that deviates from the
                             locus length mode during the allele calling process. (default: 0.2)
                             
 --cpu, --cpu-cores          Number of CPU cores that will be used to run the process (chewie resets
                             to a lower value if it is equal to or exceeds the total number of
                             available CPU cores). (default: 1)
                             
 --b, --blast-path           Path to the directory that contains the BLAST executables. (default: )
                             
 --pm, --prodigal-mode       Prodigal running mode ("single" for finished genomes, reasonable
                             quality draft genomes and big viruses. "meta" for metagenomes, low
                             quality draft genomes, small viruses, and small plasmids). (default:
                             single)
                             
 --cds, --cds-input          If provided, chewBBACA skips the gene prediction step and assumes the
                             input FASTA files contain coding sequences. (default: False)
                             
 --no-cleanup                If provided, intermediate files generated during process execution are
                             not deleted at the end. (default: False)
                             

It is strongly advised to provide a training file to create a schema. Module documentation available
at https://chewbbaca.readthedocs.io/en/latest/user/modules/CreateSchema.html
```

## chewbbaca_AlleleCall

### Tool Description
Determine the allelic profiles of a set of genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/chewbbaca:3.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/B-UMMI/chewBBACA
- **Package**: https://anaconda.org/channels/bioconda/packages/chewbbaca/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chewbbaca/overview
- **Total Downloads**: 97.0K
- **Last updated**: 2026-01-11
- **GitHub**: https://github.com/B-UMMI/chewBBACA
- **Stars**: N/A
### Original Help Text
```text
chewBBACA version: 3.5.1
Authors: Rafael Mamede, Pedro Cerqueira, Mickael Silva, João Carriço, Mário Ramirez
Github: https://github.com/B-UMMI/chewBBACA
Documentation: https://chewbbaca.readthedocs.io/en/latest/index.html
Contacts: imm-bioinfo@medicina.ulisboa.pt

==========================
  chewBBACA - AlleleCall
==========================
usage: chewBBACA.py AlleleCall --input-files <path> --schema-directory <dir> --output-directory <dir> [options]

Determine the allelic profiles of a set of genomes.

options:
 -h, --help                  show this help message and exit
                             
 -i, --input-files           Path to the directory that contains the input FASTA files or to a file
                             with a list of full paths to FASTA files, one per line. (default: None)
                             
 -g, --schema-directory      Path to the schema directory. The schema directory contains the loci
                             FASTA files and a folder named "short" that contains the FASTA files
                             with the loci representative alleles. (default: None)
                             
 -o, --output-directory      Output directory where the process will store intermediate files and
                             allele calling results (will create a subdirectory named
                             "results_<TIMESTAMP>" if the path passed by the user already exists).
                             (default: None)
                             
 --ptf, --training-file      Path to the Prodigal training file used by Pyrodigal to predict genes.
                             Default is to use the training file included in the schema's directory.
                             The translation table used to create this file overrides any value
                             passed to `--t`, `--translation-table`. (default: None)
                             
 --gl, --genes-list          Path to a file with the list of genes/loci to perform allele calling.
                             The file must include the full paths to the loci FASTA files or the
                             loci IDs, one per line. The process will perform allele calling only
                             for the subset of genes provided in the file. (default: False)
                             
 --bsr, --blast-score-ratio  BLAST Score Ratio (BSR) value. The BSR is computed for each BLASTp
                             alignment and aligned sequences with a BSR >= than the defined value
                             are considered to be alleles of the same gene. (default: None)
                             
 --l, --minimum-length       Minimum sequence length value. Predicted coding sequences (CDSs)
                             shorter than this value are excluded. (default: None)
                             
 --t, --translation-table    Genetic code used to predict genes and to translate coding DNA
                             sequences (CDSs). This value will be ignored if a training file is
                             used. (default: None)
                             
 --st, --size-threshold      Coding sequence (CDS) size variation threshold. At the default value of
                             0.2, CDSs with a size that deviates +-20 percent from the locus length
                             mode are classified as ASM/ALM. (default: None)
                             
 --cpu, --cpu-cores          Number of CPU cores that will be used to run the process (chewie resets
                             to a lower value if it is equal to or exceeds the total number of
                             available CPU cores). (default: 1)
                             
 --b, --blast-path           Path to the directory that contains the BLAST executables. (default: )
                             
 --pm, --prodigal-mode       Prodigal running mode ("single" for finished genomes, reasonable
                             quality draft genomes and big viruses. "meta" for metagenomes, low
                             quality draft genomes, small viruses, and small plasmids). (default:
                             single)
                             
 --cds, --cds-input          If provided, chewBBACA skips the gene prediction step and assumes the
                             input FASTA files contain coding sequences (one FASTA file per strain).
                             (default: False)
                             
 --no-inferred               If provided, the process will not add the sequences of inferred alleles
                             (INF) to the schema. Allelic profiles will still include the allele
                             identifiers attributed to the inferred alleles. Use this parameter if
                             the schema is being accessed by multiple processes/users
                             simultaneously. (default: False)
                             
 --output-unclassified       Create a Fasta file with the coding sequences (CDSs) that were not
                             classified. (default: False)
                             
 --output-missing            Create a Fasta file with coding sequences (CDSs) classified as NIPH,
                             NIPHEM, ASM, ALM, PLOT3, PLOT5 and LOTSC. (default: False)
                             
 --output-novel              Create a Fasta file with the novel alleles inferred during allele
                             calling. The sequence headers include the locus and allele identifiers
                             attributed by chewBBACA based on the allele calling results. (default:
                             False)
                             
 --output-masked             Create a TSV file with the masked allelic profiles. The masking process
                             removes the `INF-` prefix from inferred alleles and substitutes all
                             special classes (NIPH, NIPHEM, ASM, ALM, PLOT3, PLOT5, LOTSC, PAMA)
                             with `0`. (default: False)
                             
 --no-cleanup                If provided, intermediate files generated during process execution are
                             not removed at the end. (default: False)
                             
 --hash-profiles             Create a TSV file with hashed allelic profiles. Profiles can be hashed
                             with any of the hashing algorithms implemented in the hashlib and zlib
                             Python libraries. (default: None)
                             
 --force-continue            If provided, chewie will not warn users and ask for permission to
                             continue if any of the provided argument values does not match the
                             values in the config file. (default: False)
                             
 --mode                      Execution mode (1: only exact matches at DNA level; 2: exact matches at
                             DNA and Protein level; 3: exact matches and minimizer-based clustering
                             to find similar alleles based on BSR+0.1; 4: run the full process to
                             find exact matches and similar matches based on BSR value, including
                             the determination of new representative alleles to add to the schema).
                             (default: 4)
                             

It is strongly advised to perform allele calling with the default schema parameters to ensure more
consistent results. Module documentation available at
https://chewbbaca.readthedocs.io/en/latest/user/modules/AlleleCall.html
```

## chewbbaca_SchemaEvaluator

### Tool Description
Build an interactive report for schema evaluation.

### Metadata
- **Docker Image**: quay.io/biocontainers/chewbbaca:3.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/B-UMMI/chewBBACA
- **Package**: https://anaconda.org/channels/bioconda/packages/chewbbaca/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chewbbaca/overview
- **Total Downloads**: 97.0K
- **Last updated**: 2026-01-11
- **GitHub**: https://github.com/B-UMMI/chewBBACA
- **Stars**: N/A
### Original Help Text
```text
chewBBACA version: 3.5.1
Authors: Rafael Mamede, Pedro Cerqueira, Mickael Silva, João Carriço, Mário Ramirez
Github: https://github.com/B-UMMI/chewBBACA
Documentation: https://chewbbaca.readthedocs.io/en/latest/index.html
Contacts: imm-bioinfo@medicina.ulisboa.pt

===============================
  chewBBACA - SchemaEvaluator
===============================
usage: chewBBACA.py SchemaEvaluator --schema-directory <dir> --output-directory <dir> [options]

Build an interactive report for schema evaluation.

options:
 -h, --help                 show this help message and exit
                            
 -g, --schema-directory     Path to the schema's directory. (default: None)
                            
 -o, --output-directory     Path to the output directory where the report HTML files will be
                            created. (default: None)
                            
 --gl, --genes-list         Path to a file with the list of loci in the schema that the process
                            should analyse (one per line, full paths or loci IDs). (default: False)
                            
 -a, --annotations          Path to the TSV file created by the UniprotFinder module. The annotation
                            data is included in a table component. (default: None)
                            
 --ta, --translation-table  Genetic code used to translate coding sequences (CDSs). (default: None)
                            
 --st, --size-threshold     Coding sequence (CDS) size variation threshold. The module identifies
                            the alleles with size that deviates from the locus length mode +- the
                            size threshold. (default: None)
                            
 --ml, --minimum-length     Minimum sequence length value. The module identifies alleles shorter
                            than this value. (default: None)
                            
 --cpu, --cpu-cores         Number of CPU cores/threads that will be used to run the process (chewie
                            resets to a lower value if it is equal to or exceeds the total number of
                            available CPU cores/threads). (default: 1)
                            
 --loci-reports             Create a detailed report page for each locus. The locus report includes
                            components with relevant data and analysis results, such as allele
                            diversity charts, a MSA for the alignment of the distinct translated
                            alleles and a tree drawn with Phylocanvas based on the MAFFT guide tree.
                            (default: False)
                            
 --light                    Skips MSA computation with MAFFT and does not add the Phylogenetic Tree
                            and MSA components to the loci reports. (default: False)
                            
 --add-sequences            Adds Code Editor components with the DNA and Protein sequences to the
                            loci reports. The Code Editor is in readonly mode (allows to search for
                            and copy text). (default: False)
                            

The module can evaluate schemas created with chewBBACA or other external MLST platforms. Module
documentation available at
https://chewbbaca.readthedocs.io/en/latest/user/modules/SchemaEvaluator.html
```

## chewbbaca_AlleleCallEvaluator

### Tool Description
Build an interactive report for allele calling results evaluation.

### Metadata
- **Docker Image**: quay.io/biocontainers/chewbbaca:3.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/B-UMMI/chewBBACA
- **Package**: https://anaconda.org/channels/bioconda/packages/chewbbaca/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chewbbaca/overview
- **Total Downloads**: 97.0K
- **Last updated**: 2026-01-11
- **GitHub**: https://github.com/B-UMMI/chewBBACA
- **Stars**: N/A
### Original Help Text
```text
chewBBACA version: 3.5.1
Authors: Rafael Mamede, Pedro Cerqueira, Mickael Silva, João Carriço, Mário Ramirez
Github: https://github.com/B-UMMI/chewBBACA
Documentation: https://chewbbaca.readthedocs.io/en/latest/index.html
Contacts: imm-bioinfo@medicina.ulisboa.pt

===================================
  chewBBACA - AlleleCallEvaluator
===================================
usage: chewBBACA.py AlleleCallEvaluator --input-files <dir> --schema-directory <dir> --output-directory <dir> [options]

Build an interactive report for allele calling results evaluation.

options:
 -h, --help              show this help message and exit
                         
 -i, --input-files       Path to the directory that contains the allele calling results generated by
                         the AlleleCall module. (default: None)
                         
 -g, --schema-directory  Path to the schema's directory. (default: None)
                         
 -o, --output-directory  Path to the output directory where the module will store intermediate files
                         and create the report HTML files. (default: None)
                         
 -a, --annotations       Path to the TSV file created by the UniprotFinder module. (default: None)
                         
 --cpu, --cpu-cores      Number of CPU cores/threads that will be used to run the process (chewie
                         resets to a lower value if it is equal to or exceeds the total number of
                         available CPU cores/threads). (default: 1)
                         
 --light                 Do not compute the presence-absence matrix, the distance matrix and the
                         Neighbor-Joining tree. (default: False)
                         
 --no-pa                 Do not compute the presence-absence matrix. (default: False)
                         
 --no-dm                 Do not compute the distance matrix. (default: False)
                         
 --no-tree               Do not compute the Neighbor-Joining tree. (default: False)
                         
 --cg-alignment          Compute the MSA of the core genome loci, even if `--no-tree` is provided.
                         (default: False)
                         

Module documentation available at
https://chewbbaca.readthedocs.io/en/latest/user/modules/AlleleCallEvaluator.html
```

## chewbbaca_ExtractCgMLST

### Tool Description
Determine the set of loci that constitute the core genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/chewbbaca:3.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/B-UMMI/chewBBACA
- **Package**: https://anaconda.org/channels/bioconda/packages/chewbbaca/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chewbbaca/overview
- **Total Downloads**: 97.0K
- **Last updated**: 2026-01-11
- **GitHub**: https://github.com/B-UMMI/chewBBACA
- **Stars**: N/A
### Original Help Text
```text
chewBBACA version: 3.5.1
Authors: Rafael Mamede, Pedro Cerqueira, Mickael Silva, João Carriço, Mário Ramirez
Github: https://github.com/B-UMMI/chewBBACA
Documentation: https://chewbbaca.readthedocs.io/en/latest/index.html
Contacts: imm-bioinfo@medicina.ulisboa.pt

=============================
  chewBBACA - ExtractCgMLST
=============================
usage: chewBBACA.py ExtractCgMLST --input-file <file> --output-directory <dir> [options]

Determine the set of loci that constitute the core genome.

options:
 -h, --help              show this help message and exit
                         
 -i, --input-file        Path to the TSV file that contains the allelic profiles determined by the
                         AlleleCall module. (default: None)
                         
 -o, --output-directory  Path to the directory where the process will store the output files.
                         (default: None)
                         
 --t, --threshold        Genes that constitute the core genome must be in a proportion of genomes
                         that is at least equal to this value. Provide multiple values to compute
                         the core genome for multiple threshold values. (default: [0.95, 0.99, 1])
                         
 --s, --step             The allele calling results are processed iteratively to evaluate the impact
                         of adding subsets of the results in computing the core genome. The step
                         value controls the number of profiles added in each iteration until all
                         profiles are included. (default: 1)
                         
 --r, --genes2remove     Path to a file with a list of gene IDs to exclude from the analysis (one
                         gene identifier per line). (default: False)
                         
 --g, --genomes2remove   Path to a file with a list of genome IDs to exclude from the analysis (one
                         genome identifier per line). (default: False)
                         

Module documentation available at
https://chewbbaca.readthedocs.io/en/latest/user/modules/ExtractCgMLST.html
```

## chewbbaca_RemoveGenes

### Tool Description
Remove a set of loci from allele calling results.

### Metadata
- **Docker Image**: quay.io/biocontainers/chewbbaca:3.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/B-UMMI/chewBBACA
- **Package**: https://anaconda.org/channels/bioconda/packages/chewbbaca/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chewbbaca/overview
- **Total Downloads**: 97.0K
- **Last updated**: 2026-01-11
- **GitHub**: https://github.com/B-UMMI/chewBBACA
- **Stars**: N/A
### Original Help Text
```text
chewBBACA version: 3.5.1
Authors: Rafael Mamede, Pedro Cerqueira, Mickael Silva, João Carriço, Mário Ramirez
Github: https://github.com/B-UMMI/chewBBACA
Documentation: https://chewbbaca.readthedocs.io/en/latest/index.html
Contacts: imm-bioinfo@medicina.ulisboa.pt

===========================
  chewBBACA - RemoveGenes
===========================
usage: chewBBACA.py RemoveGenes --input-file <file> --genes-list <file> --output-file <file> [options]

Remove a set of loci from allele calling results.

options:
 -h, --help         show this help message and exit
                    
 -i, --input-file   Path to a TSV file with allelic profiles determined by the AlleleCall process.
                    (default: None)
                    
 -g, --genes-list   Path to a file with a list of genes to remove, one identifier per line.
                    (default: None)
                    
 -o, --output-file  Path to the output file. (default: None)
                    
 --inverse          If provided, the genes included in the list will be kept, and all other genes
                    will be removed. (default: False)
                    

Module documentation available at
https://chewbbaca.readthedocs.io/en/latest/user/modules/RemoveGenes.html
```

## chewbbaca_PrepExternalSchema

### Tool Description
Adapt an external schema to be used with chewBBACA.

### Metadata
- **Docker Image**: quay.io/biocontainers/chewbbaca:3.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/B-UMMI/chewBBACA
- **Package**: https://anaconda.org/channels/bioconda/packages/chewbbaca/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chewbbaca/overview
- **Total Downloads**: 97.0K
- **Last updated**: 2026-01-11
- **GitHub**: https://github.com/B-UMMI/chewBBACA
- **Stars**: N/A
### Original Help Text
```text
chewBBACA version: 3.5.1
Authors: Rafael Mamede, Pedro Cerqueira, Mickael Silva, João Carriço, Mário Ramirez
Github: https://github.com/B-UMMI/chewBBACA
Documentation: https://chewbbaca.readthedocs.io/en/latest/index.html
Contacts: imm-bioinfo@medicina.ulisboa.pt

==================================
  chewBBACA - PrepExternalSchema
==================================
usage: chewBBACA.py PrepExternalSchema --schema-directory <dir> --output-directory <dir> [options]

Adapt an external schema to be used with chewBBACA.

options:
 -h, --help                  show this help message and exit
                             
 -g, --schema-directory      Path to the directory of the schema to adapt. The schema must contain
                             one FASTA file per gene/locus. (default: None)
                             
 -o, --output-directory      Path to the output directory where the adapted schema will be created.
                             (default: None)
                             
 --gl, --genes-list          Path to a file with the list of loci in the schema that the process
                             should adapt (one per line, full paths or loci IDs). (default: False)
                             
 --ptf, --training-file      Path to the Prodigal training file that will be included in the
                             directory of the adapted schema. The translation table used to create
                             this file overrides any value passed to `--t`, `--translation-table`.
                             (default: None)
                             
 --bsr, --blast-score-ratio  BLAST Score Ratio (BSR) value. The process selects representative
                             alleles for each locus based on this value. Representative alleles are
                             selected until all alleles in a locus align against one of the
                             representatives with a BSR >= than the specified value. (default: 0.6)
                             
 --l, --minimum-length       Minimum sequence length value stored in the schema config file. The
                             schema adaptation process will only discard sequences smaller than this
                             value if the --size-filter parameter is provided. (default: 0)
                             
 --t, --translation-table    Genetic code used for allele translation. This value is ignored if a
                             valid training file is passed to `--ptf`, `--training-file`. (default:
                             None)
                             
 --st, --size-threshold      Allele size variation threshold value stored in the schema config file.
                             The schema adaptation process will only discard alleles with a size
                             that deviates from the locus length mode +- the size theshold value if
                             the --size-filter parameter is provided. (default: 0.2)
                             
 --cpu, --cpu-cores          Number of CPU cores/threads that will be used to run the process
                             (chewie resets to a lower value if it is equal to or exceeds the total
                             number of available CPU cores/threads). (default: 1)
                             
 --b, --blast-path           Path to the directory that contains the BLAST executables. (default: )
                             
 --size-filter               Apply the minimum length and size threshold values to filter out
                             alleles during schema adaptation. (default: False)
                             

Module documentation available at
https://chewbbaca.readthedocs.io/en/latest/user/modules/PrepExternalSchema.html
```

## chewbbaca_JoinProfiles

### Tool Description
Join allele calling results from different runs.

### Metadata
- **Docker Image**: quay.io/biocontainers/chewbbaca:3.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/B-UMMI/chewBBACA
- **Package**: https://anaconda.org/channels/bioconda/packages/chewbbaca/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chewbbaca/overview
- **Total Downloads**: 97.0K
- **Last updated**: 2026-01-11
- **GitHub**: https://github.com/B-UMMI/chewBBACA
- **Stars**: N/A
### Original Help Text
```text
chewBBACA version: 3.5.1
Authors: Rafael Mamede, Pedro Cerqueira, Mickael Silva, João Carriço, Mário Ramirez
Github: https://github.com/B-UMMI/chewBBACA
Documentation: https://chewbbaca.readthedocs.io/en/latest/index.html
Contacts: imm-bioinfo@medicina.ulisboa.pt

============================
  chewBBACA - JoinProfiles
============================
usage: chewBBACA.py JoinProfiles --profiles <file> <file> ... --output-file <file> [options]

Join allele calling results from different runs.

options:
 -h, --help         show this help message and exit
                    
 -p, --profiles     Paths to the files containing allelic profiles determined by the AlleleCall
                    module. It is possible to provide any number of files. The results must have
                    been determined with the same schema and share all the loci or a subset of the
                    loci if using the --common parameter. (default: None)
                    
 -o, --output-file  Path to the output file. (default: None)
                    
 --common           Merge the results based on the subset of loci shared between all files.
                    (default: False)
                    

Module documentation available at
https://chewbbaca.readthedocs.io/en/latest/user/modules/JoinProfiles.html
```

## chewbbaca_GetAlleles

### Tool Description
Create FASTA files containing the alleles identified by the AlleleCall module.

### Metadata
- **Docker Image**: quay.io/biocontainers/chewbbaca:3.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/B-UMMI/chewBBACA
- **Package**: https://anaconda.org/channels/bioconda/packages/chewbbaca/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chewbbaca/overview
- **Total Downloads**: 97.0K
- **Last updated**: 2026-01-11
- **GitHub**: https://github.com/B-UMMI/chewBBACA
- **Stars**: N/A
### Original Help Text
```text
chewBBACA version: 3.5.1
Authors: Rafael Mamede, Pedro Cerqueira, Mickael Silva, João Carriço, Mário Ramirez
Github: https://github.com/B-UMMI/chewBBACA
Documentation: https://chewbbaca.readthedocs.io/en/latest/index.html
Contacts: imm-bioinfo@medicina.ulisboa.pt

==========================
  chewBBACA - GetAlleles
==========================
usage: chewBBACA.py GetAlleles --input-file <file> --schema-directory <dir> --output-directory <dir> [options]

Create FASTA files containing the alleles identified by the AlleleCall module.

options:
 -h, --help                 show this help message and exit
                            
 -i, --input-file           Path to the TSV file containing the allelic profiles. (default: None)
                            
 -g, --schema-directory     Path to the schema directory. (default: None)
                            
 --gl, --genes-list         Path to a file with the list of genes/loci to create FASTA files for.
                            The file must include the identifiers of the loci, one per line, without
                            the .fasta extension. (default: None)
                            
 -o, --output-directory     Path to the output directory. (default: None)
                            
 --cpu, --cpu-cores         Number of CPU cores/threads that will be used to run the process (chewie
                            resets to a lower value if it is equal to or exceeds the total number of
                            available CPU cores/threads). (default: 1)
                            
 --distinct                 Only get distinct alleles. (default: False)
                            
 --translate                Create FASTA files with the translated alleles. (default: False)
                            
 --ta, --translation-table  Genetic code used to translate coding DNAsequences (CDSs). If no value
                            is specified, the process tries to get the value stored in the schema
                            config file. If the schema does not include a config file, the process
                            uses the default translation table (11). (default: None)
                            

Module documentation available at
https://chewbbaca.readthedocs.io/en/latest/user/modules/GetAlleles.html
```

## chewbbaca_UniprotFinder

### Tool Description
Retrieve annotations for loci in a schema.

### Metadata
- **Docker Image**: quay.io/biocontainers/chewbbaca:3.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/B-UMMI/chewBBACA
- **Package**: https://anaconda.org/channels/bioconda/packages/chewbbaca/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chewbbaca/overview
- **Total Downloads**: 97.0K
- **Last updated**: 2026-01-11
- **GitHub**: https://github.com/B-UMMI/chewBBACA
- **Stars**: N/A
### Original Help Text
```text
chewBBACA version: 3.5.1
Authors: Rafael Mamede, Pedro Cerqueira, Mickael Silva, João Carriço, Mário Ramirez
Github: https://github.com/B-UMMI/chewBBACA
Documentation: https://chewbbaca.readthedocs.io/en/latest/index.html
Contacts: imm-bioinfo@medicina.ulisboa.pt

=============================
  chewBBACA - UniprotFinder
=============================
usage: chewBBACA.py UniprotFinder --schema-directory <dir> --output-directory <dir> [options]

Retrieve annotations for loci in a schema.

options:
 -h, --help              show this help message and exit
                         
 -g, --schema-directory  Path to the schema's directory. (default: None)
                         
 -o, --output-directory  Path to the output directory where the process will store intermediate
                         files and save the final TSV file with the loci annotations. (default:
                         None)
                         
 --gl, --genes-list      Path to a file with the list of loci in the schema that the process should
                         find annotations for (one per line, full paths or loci IDs). (default:
                         False)
                         
 -t, --protein-table     Path to the TSV file with coding sequence (CDS) coordinate data,
                         "cds_coordinates.tsv", created by the CreateSchema process. (default: None)
                         
 --bsr                   BLAST Score Ratio value. The BSR is only used when taxa names are provided
                         to the --taxa parameter and local sequences are aligned against reference
                         proteomes downloaded from UniProt. Annotations are selected based on a BSR
                         >= than the specified value. (default: 0.6)
                         
 --cpu, --cpu-cores      Number of CPU cores/threads that will be used to run the process (chewie
                         resets to a lower value if it is equal to or exceeds the total number of
                         available CPU cores/threads). (default: 1)
                         
 --taxa                  List of scientific names for a set of taxa. The process will download
                         reference proteomes from UniProt associated to taxa names that contain any
                         of the provided terms. The schema representative alleles are aligned
                         against the reference proteomes to assign annotations based on high-BSR
                         matches. (default: None)
                         
 --pm                    Maximum number of proteome matches to report. (default: 1)
                         
 --no-sparql             Do not search for annotations through the UniProt SPARQL endpoint.
                         (default: False)
                         
 --no-cleanup            If provided, intermediate files generated during process execution are not
                         removed at the end. (default: False)
                         
 --b, --blast-path       Path to the directory that contains the BLAST executables. (default: )
                         

Module documentation available at
https://chewbbaca.readthedocs.io/en/latest/user/modules/UniprotFinder.html
```

## chewbbaca_ComputeMSA

### Tool Description
Compute a Multiple Sequence Alignment based on allele calling results.

### Metadata
- **Docker Image**: quay.io/biocontainers/chewbbaca:3.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/B-UMMI/chewBBACA
- **Package**: https://anaconda.org/channels/bioconda/packages/chewbbaca/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chewbbaca/overview
- **Total Downloads**: 97.0K
- **Last updated**: 2026-01-11
- **GitHub**: https://github.com/B-UMMI/chewBBACA
- **Stars**: N/A
### Original Help Text
```text
chewBBACA version: 3.5.1
Authors: Rafael Mamede, Pedro Cerqueira, Mickael Silva, João Carriço, Mário Ramirez
Github: https://github.com/B-UMMI/chewBBACA
Documentation: https://chewbbaca.readthedocs.io/en/latest/index.html
Contacts: imm-bioinfo@medicina.ulisboa.pt

==========================
  chewBBACA - ComputeMSA
==========================
usage: chewBBACA.py ComputeMSA --input-file <file> --schema-directory <dir> --output-directory <dir> [options]

Compute a Multiple Sequence Alignment based on allele calling results.

options:
 -h, --help                show this help message and exit
                           
 -i, --input-path          Path to a TSV file containing allelic profiles or to a folder containing
                           FASTA files. If a TSV file containing allelic profiles is provided, it is
                           necessary to provide the path to the schema to the `--schema-directory`
                           parameter. The module will create a FASTA file with the alleles
                           identified in the samples for each schema locus and compute a MSA. The
                           loci MSAs are joined to create the complete MSA based on the allele
                           calling results. If a path to a folder is provided, the module computes a
                           MSA for each FASTA file in the folder, but will not attempt to join the
                           MSAs as it does not have the sample information (in this case, it is not
                           necessary to pass the schema path). (default: None)
                           
 -o, --output-directory    Path to the output directory where the process will store intermediate
                           and final results. (default: None)
                           
 -g, --schema-directory    Path to the schema's directory. This parameter is only required if the
                           input is a TSV file with allelic profiles. (default: None)
                           
 --dna-msa                 Converts the protein MSA back to DNA to create an additional output file
                           with the DNA MSA. (default: False)
                           
 --output-variable         Output a reduced MSA including only the variable positions. If the
                           `--dna-msa` parameter is provided, the process will output a reduced MSA
                           for both the protein and DNA MSAs. (default: False)
                           
 --t, --translation-table  Genetic code used for sequence translation. (default: 11)
                           
 --cpu, --cpu-cores        Number of CPU cores/threads that will be used to run the process (chewie
                           resets to a lower value if it is equal to or exceeds the total number of
                           available CPU cores/threads). (default: 1)
                           
 --only-loci-msas          Do not compute the full MSA when the input file is a TSV file containing
                           allelic profiles (this is already the default when the input is a path to
                           a folder with FASTA files). (default: False)
                           
 --gaps                    How to treat gaps when determining the reduced MSA for the variable
                           positions. The default value, "exclude", removes variable positions if
                           any of the aligned sequences contain a gap. The "ignore" option allows to
                           consider variable positions that include gaps in some sequences as long
                           as other sequences include variable non-gap characters. The character
                           used to represent gaps is "-". (default: exclude)
                           
 --ambiguous               How to treat ambiguous amino acids or nucleotides when determining the
                           reduced MSA for the variable positions. The default value, "exclude",
                           removes variable positions if any of the aligned sequences contain an
                           ambiguous amino acid or nucleotide. The "ignore" option allows to
                           consider variable positions that include ambiguous amino acids or
                           nucleotides in some sequences as long as other sequences include variable
                           non-ambiguous characters. The characters interpreted as ambiguous amino
                           acids are [B, Z, X, J]. The characters interpreted as ambiguous
                           nucleotides are [R, Y, S, W, K, M, B, D, H, V, N] (default: exclude)
                           
 --custom-mafft-params     Custom parameters to pass to MAFFT when computing the loci MSAs. The
                           value must be a single string with all parameters enclosed in quotes
                           (e.g. "--retree 1 --maxiterate 0"). (default: None)
                           
 --protein-input           Input files contain protein sequences. This option is only valid for
                           cases when users provide a path to a directory containing FASTA files.
                           (default: False)
                           
 --no-cleanup              Keep intermediate files with locus/file MSAs and sample MSAs if input is
                           a TSV file containing allelic profiles. (default: False)
                           

Module documentation available at
https://chewbbaca.readthedocs.io/en/latest/user/modules/ComputeMSA.html
```

## chewbbaca_DownloadSchema

### Tool Description
Download a schema from Chewie-NS.

### Metadata
- **Docker Image**: quay.io/biocontainers/chewbbaca:3.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/B-UMMI/chewBBACA
- **Package**: https://anaconda.org/channels/bioconda/packages/chewbbaca/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chewbbaca/overview
- **Total Downloads**: 97.0K
- **Last updated**: 2026-01-11
- **GitHub**: https://github.com/B-UMMI/chewBBACA
- **Stars**: N/A
### Original Help Text
```text
chewBBACA version: 3.5.1
Authors: Rafael Mamede, Pedro Cerqueira, Mickael Silva, João Carriço, Mário Ramirez
Github: https://github.com/B-UMMI/chewBBACA
Documentation: https://chewbbaca.readthedocs.io/en/latest/index.html
Contacts: imm-bioinfo@medicina.ulisboa.pt

==============================
  chewBBACA - DownloadSchema
==============================
usage: chewBBACA.py DownloadSchema --species-id <id> --schema-id <id> --download-folder <dir> [options]

Download a schema from Chewie-NS.

options:
 -h, --help                   show this help message and exit
                              
 -sp, --species-id            The integer identifier or name of the species that the schema is
                              associated to in Chewie-NS. (default: None)
                              
 -sc, --schema-id             The URI, integer identifier or name of the schema to download from
                              Chewie-NS. (default: None)
                              
 -o, --download-folder        Output folder to which the schema will be saved. (default: None)
                              
 --cpu, --cpu-cores           Number of CPU cores/threads that will be used to run the process
                              (chewie resets to a lower value if it is equal to or exceeds the total
                              number of available CPU cores/threads). This value is only used if it
                              is necessary to construct the schema locally. (default: 1)
                              
 --ns, --nomenclature-server  The base URL for the Chewie-NS instance. The default value, "main",
                              will establish a connection to "https://chewbbaca.online/", "tutorial"
                              to "https://tutorial.chewbbaca.online/" and "local" to
                              "http://127.0.0.1:5000/NS/api/" (localhost). Users may also provide
                              the IP address to other Chewie-NS instances. (default: main)
                              
 --b, --blast-path            Path to the directory that contains the BLAST executables. (default: )
                              
 --d, --date                  Download schema with state from specified date. Must be in the format
                              "Y-m-dTH:M:S". (default: None)
                              
 --latest                     If the compressed version that is available is not the latest,
                              downloads all loci FASTA files and constructs schema locally.
                              (default: False)
                              

Module documentation available at
https://chewbbaca.readthedocs.io/en/latest/user/modules/DownloadSchema.html
```

## chewbbaca_LoadSchema

### Tool Description
Upload a schema to Chewie-NS.

### Metadata
- **Docker Image**: quay.io/biocontainers/chewbbaca:3.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/B-UMMI/chewBBACA
- **Package**: https://anaconda.org/channels/bioconda/packages/chewbbaca/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chewbbaca/overview
- **Total Downloads**: 97.0K
- **Last updated**: 2026-01-11
- **GitHub**: https://github.com/B-UMMI/chewBBACA
- **Stars**: N/A
### Original Help Text
```text
chewBBACA version: 3.5.1
Authors: Rafael Mamede, Pedro Cerqueira, Mickael Silva, João Carriço, Mário Ramirez
Github: https://github.com/B-UMMI/chewBBACA
Documentation: https://chewbbaca.readthedocs.io/en/latest/index.html
Contacts: imm-bioinfo@medicina.ulisboa.pt

==========================
  chewBBACA - LoadSchema
==========================
usage: chewBBACA.py LoadSchema --schema-directory <dir> --species-id <id> --schema-name <name> --loci-prefix <prefix> [options]

Upload a schema to Chewie-NS.

options:
 -h, --help                   show this help message and exit
                              
 -i, --schema-directory       Path to the directory of the schema to upload. (default: None)
                              
 -sp, --species-id            The integer identifier or name of the species that the schema will be
                              associated to in Chewie-NS. (default: None)
                              
 -sn, --schema-name           A brief and meaningful name that should help understand the type and
                              content of the schema. (default: None)
                              
 -lp, --loci-prefix           Prefix included in the name of each locus of the schema. (default:
                              None)
                              
 --df, --description-file     Path to a text file with a description about the schema. Markdown
                              syntax is supported in order to offer greater customizability of the
                              rendered description in the Frontend. Will default to the schema's
                              name if the user does not provide a valid path for a file. (default:
                              None)
                              
 --a, --annotations           Path to a TSV file with loci annotations. The first column has loci
                              identifiers (w/o .fasta extension), the second has UniProt protein
                              names, the third has UniProt gene names, the fourth has UniProt URIs,
                              the fifth has user annotations, and the sixth has custom annotations.
                              (default: None)
                              
 --cpu, --cpu-cores           Number of CPU cores/threads that will be used to run the process
                              (chewie resets to a lower value if it is equal to or exceeds the total
                              number of available CPU cores/threads). This value is used to
                              accelerate the quality control step that checks all alleles in the
                              schema. (default: 1)
                              
 --ns, --nomenclature-server  The base URL for the Chewie-NS instance. The default value, "main",
                              will establish a connection to "https://chewbbaca.online/", "tutorial"
                              to "https://tutorial.chewbbaca.online/" and "local" to
                              "http://127.0.0.1:5000/NS/api/" (localhost). Users may also provide
                              the IP address to other Chewie-NS instances. (default: main)
                              
 --continue_up                Check if the schema upload was interrupted and attempt to continue
                              upload. (default: False)
                              

Module documentation available at
https://chewbbaca.readthedocs.io/en/latest/user/modules/LoadSchema.html
```

## chewbbaca_SyncSchema

### Tool Description
Synchronize a schema with its remote version in Chewie-NS.

### Metadata
- **Docker Image**: quay.io/biocontainers/chewbbaca:3.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/B-UMMI/chewBBACA
- **Package**: https://anaconda.org/channels/bioconda/packages/chewbbaca/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chewbbaca/overview
- **Total Downloads**: 97.0K
- **Last updated**: 2026-01-11
- **GitHub**: https://github.com/B-UMMI/chewBBACA
- **Stars**: N/A
### Original Help Text
```text
chewBBACA version: 3.5.1
Authors: Rafael Mamede, Pedro Cerqueira, Mickael Silva, João Carriço, Mário Ramirez
Github: https://github.com/B-UMMI/chewBBACA
Documentation: https://chewbbaca.readthedocs.io/en/latest/index.html
Contacts: imm-bioinfo@medicina.ulisboa.pt

==========================
  chewBBACA - SyncSchema
==========================
usage: chewBBACA.py SyncSchema --schema-directory <dir> [options]

Synchronize a schema with its remote version in Chewie-NS.

options:
 -h, --help                   show this help message and exit
                              
 -sc, --schema-directory      Path to the directory with the schema to be synced. (default: None)
                              
 --cpu, --cpu-cores           Number of CPU cores/threads that will be used to run the process
                              (chewie resets to a lower value if it is equal to or exceeds the total
                              number of available CPU cores/threads). This value is only used if the
                              process retrieves novel alleles from the remote schema and needs to
                              redetermine the set of representative alleles for the local schema.
                              (default: 1)
                              
 --ns, --nomenclature-server  The base URL for the Chewie-NS instance. The default option will get
                              the base URL from the schema's URI. It is also possible to specify
                              other options that are available in chewBBACA's configs, such as:
                              "main" will establish a connection to "https://chewbbaca.online/",
                              "tutorial" to "https://tutorial.chewbbaca.online/" and "local" to
                              "http://127.0.0.1:5000/NS/api/" (localhost). Users may also provide
                              the IP address to other Chewie-NS instances. (default: None)
                              
 --b, --blast-path            Path to the directory that contains the BLAST executables. (default: )
                              
 --submit                     If the process should identify new alleles in the local schema and
                              send them to the Chewie-NS instance. (only authorized users can submit
                              new alleles). (default: False)
                              

Module documentation available at
https://chewbbaca.readthedocs.io/en/latest/user/modules/SyncSchema.html
```

## chewbbaca_NSStats

### Tool Description
Retrieve basic information about the species and schemas in Chewie-NS.

### Metadata
- **Docker Image**: quay.io/biocontainers/chewbbaca:3.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/B-UMMI/chewBBACA
- **Package**: https://anaconda.org/channels/bioconda/packages/chewbbaca/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chewbbaca/overview
- **Total Downloads**: 97.0K
- **Last updated**: 2026-01-11
- **GitHub**: https://github.com/B-UMMI/chewBBACA
- **Stars**: N/A
### Original Help Text
```text
chewBBACA version: 3.5.1
Authors: Rafael Mamede, Pedro Cerqueira, Mickael Silva, João Carriço, Mário Ramirez
Github: https://github.com/B-UMMI/chewBBACA
Documentation: https://chewbbaca.readthedocs.io/en/latest/index.html
Contacts: imm-bioinfo@medicina.ulisboa.pt

=======================
  chewBBACA - NSStats
=======================
usage: chewBBACA.py NSStats --mode <mode> [options]

Retrieve basic information about the species and schemas in Chewie-NS.

options:
 -h, --help                   show this help message and exit
                              
 -m, --mode                   The process can retrieve the list of species ("species" option) in
                              Chewie-NS or the list of schemas for a species ("schemas" option).
                              (default: None)
                              
 --sp, --species-id           The integer identifier of a species in Chewie-NS. (default: None)
                              
 --sc, --schema-id            The integer identifier of a schema in Chewie-NS. (default: None)
                              
 --ns, --nomenclature-server  The base URL for the Chewie-NS instance. The default value, "main",
                              will establish a connection to "https://chewbbaca.online/", "tutorial"
                              to "https://tutorial.chewbbaca.online/" and "local" to
                              "http://127.0.0.1:5000/NS/api/" (localhost). Users may also provide
                              the IP address to other Chewie-NS instances. (default: main)
                              

Module documentation available at
https://chewbbaca.readthedocs.io/en/latest/user/modules/NSStats.html
```

