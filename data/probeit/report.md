# probeit CWL Generation Report

## probeit_posnegset

### Tool Description
It generates a probe set with sequences included in the positive genome but not in the negative genome

### Metadata
- **Docker Image**: quay.io/biocontainers/probeit:2.2--py36hff8b118_0
- **Homepage**: https://github.com/steineggerlab/probeit
- **Package**: https://anaconda.org/channels/bioconda/packages/probeit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/probeit/overview
- **Total Downloads**: 15.8K
- **Last updated**: 2025-09-02
- **GitHub**: https://github.com/steineggerlab/probeit
- **Stars**: N/A
### Original Help Text
```text
CURRENT:  /
Your arguments: posnegset 
[ERR]You didn't input a proper argument for '--positive' parameter or missed it.
[INFO] Probeit posnegset without negative genomes.
[ERR]You didn't input a proper argument for '--output' parameter or missed it.
Probeit posnegset
It generates a probe set with sequences included in the positive genome but not in the negative genome
probeit -p [POSITIVE GENOME]-n [NEGATIVE GENOME] -o [DIR]
Usage
 -h|--help NONE
	 Show usage
REQUIRED OPTIONS
 -p|--positive FASTA file
	 The genome which MUST be covered by the probes.
 -o|--output DIR
	 Output directory The Directory is automatically created by Probeit.
ADDITIONAL OPTIONS
 -n|--negative FASTA file
	 The genome which MUST NOT be covered by the probes.
 --threads INT[8]
	 number of CPU-cores used
 --window-size INT[200]
	 size of windows for 2nd probes
 --not-cluster NONE
	 Use it when you DO NOT need to cluster positive genome
 --not-make-probe2 NONE
	 Use it when you DO NOT need to make 2nd probes
 --not-thermo-filter NONE
	 Use it when you DO NOT need the thermodynamic filter
 --probe1-len INT[40]
	 Length of 1st Probes
 --probe2-len INT[20]
	 Length of 2nd Probes
OPTIONS FOR GENMAP PART: Genmap calculates mappability by summarizing k-mers.
 --probe1-error INT[0]
	 The number of error allowed in 1st Probes
 --probe2-error INT[1]
	 The number of error allowed in 2nd Probes
OPTIONS FOR SETCOVER PART: Setcover makes probesets cover targets with the minimum number of probes.
--probe1-cover INT[1]
	 The number of times each Seqs from positive genome should be covered by 1st Probes
--probe2-cover INT[1]
	 The number of times each 1st Probe should be covered by 2nd Probes
--probe1-repeat INT[1]
	 The number of random iterations when minimizing 1st Probes
--probe2-repeat INT[10]
	 The number of random iterations when minimizing 2nd Probes
--probe1-earlystop INT[90]
	 Early stop picking new probes if X% of sequences are covered at least N(--probe1-cover) times
--probe2-earlystop INT[99]
	 Early stop picking new probes if X% of sequences are covered at least N(--probe2-cover) times
```


## probeit_snp

### Tool Description
It generates a probe set which detect input amino acid SNPs from strain genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/probeit:2.2--py36hff8b118_0
- **Homepage**: https://github.com/steineggerlab/probeit
- **Package**: https://anaconda.org/channels/bioconda/packages/probeit/overview
- **Validation**: PASS

### Original Help Text
```text
CURRENT:  /
Your arguments: posnegset --help 
Probeit snp
It generates a probe set which detect input amino acid SNPs from strain genome.
probeit snp -r [REF GENOME] -s [STR GENOME] -p [positions] -m [SNPs] -o [DIR] -a [REF ANNOTATION]
Usage
 -h|--help NONE
	 Show usage
REQUIRED OPTIONS
 -r|--reference FASTA file
	 The wildtype genome.
 -s|--strain FASTA file
	 The strain Genome.
 -p|--positions COMMA SEPARATED INT ARRAY
	 Position List: The position of this indicates the position of the SNP on the 1st Probes
 -m|--mutations COMMA SEPARATED SNP ARRAY
	 SNP List. Both amino acid differences and nucleotide differences are allowed.
 -o|--output DIR
	 Output directory. The Directory is automatically created by Probeit.
 -a|--annotation GFF file
	 The wildtype genome annotation. Only required when using amino acid differences in the -m option.
ADDITIONAL OPTIONS
 --not-make-probe2 NONE
	 Use it when you DO NOT need to make 2nd probes
 --threads INT[8]
	 number of CPU-cores used
 --max-window NONE
	 When you need maximum window mode, then use this option. Default window mode is minimum window.
 --window-size INT[200]
	 size of windows for 2nd probes
 --probe1-len INT[40]
	 Length of 1st Probes
 --probe2-len INT[20]
	 Length of 2nd Probes
 --not-make-probe2 NONE
	 Use it when you DO NOT need to make 2nd probes
OPTIONS FOR GENMAP PART: Genmap calculates mappability by summarizing k-mers.
 --probe2-error INT[1]
	 The number of error allowed in 2nd Probes
OPTIONS FOR SETCOVER PART: Setcover makes probesets cover targets with the minimum number of probes.
 --probe2-cover INT[1]
	 The number of times each 1st Probe should be covered by 2nd Probes
 --probe2-repeat INT[10]
	 The number of random iterations when minimizing 2nd Probes
 --probe2-earlystop INT[99]
	 Early stop picking new probes if X% of sequences are covered at least N(--probe2-cover) times.
```


## Metadata
- **Skill**: generated
