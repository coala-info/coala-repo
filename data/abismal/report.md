# abismal CWL Generation Report

## abismal_map

### Tool Description
map bisulfite converted reads (v3.3.0)

### Metadata
- **Docker Image**: quay.io/biocontainers/abismal:3.3.0--h077b44d_0
- **Homepage**: https://github.com/smithlabcode/abismal
- **Package**: https://anaconda.org/channels/bioconda/packages/abismal/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: map [OPTIONS] <reads-fq1> [<reads-fq2>]

Options:
  -i, -index           index file  
  -g, -genome          genome file (FASTA)  
  -o, -outfile         output file [-] 
  -B, -bam             output BAM format  
  -s, -stats           map statistics file (YAML)  
  -c, -max-candidates  max candidates per seed (0 = use index estimate) 
                       [0] 
  -l, -min-frag        min fragment size (pe mode) [32] 
  -L, -max-frag        max fragment size (pe mode) [3000] 
  -m, -max-distance    max fractional edit distance [0.100000] 
  -a, -ambig           report a posn for ambiguous mappers  
  -P, -pbat            input follows the PBAT protocol  
  -R, -random-pbat     input follows random PBAT protocol  
  -A, -a-rich          indicates reads are a-rich (se mode)  
  -t, -threads         number of threads [1] 
  -v, -verbose         print more run info  

Help options:
  -?, -help            print this help message  
      -about           print about message  

PROGRAM: map
map bisulfite converted reads (v3.3.0)
```


## abismal_idx

### Tool Description
build abismal index

### Metadata
- **Docker Image**: quay.io/biocontainers/abismal:3.3.0--h077b44d_0
- **Homepage**: https://github.com/smithlabcode/abismal
- **Package**: https://anaconda.org/channels/bioconda/packages/abismal/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: idx [OPTIONS] <genome-fasta> <abismal-index-file>

Options:
  -A, -targets  target regions  
  -t, -threads  number of threads [1] 
  -v, -verbose  print more run info  

Help options:
  -?, -help     print this help message  
      -about    print about message  

PROGRAM: idx
build abismal index (v3.3.0)
```


## abismal_sim

### Tool Description
Simulate reads from a reference genome with optional bisulfite conversion and mutations.

### Metadata
- **Docker Image**: quay.io/biocontainers/abismal:3.3.0--h077b44d_0
- **Homepage**: https://github.com/smithlabcode/abismal
- **Package**: https://anaconda.org/channels/bioconda/packages/abismal/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sim [OPTIONS] <reference-genome-fasta>

Options:
  -o, -out            output file prefix [required] 
      -single         output single end  
      -loc            write locations here  
  -l, -read-len       read length [100] 
      -min-fraglen    min fragment length [100] 
      -max-fraglen    max fragment length [250] 
  -n, -n-reads        number of reads [100] 
  -m, -mut            mutation rate [0.0] 
  -b, -bis            bisulfite conversion rate [1.000000] 
      -show-matches   show match symbols in cigar  
  -c, -changes        change types (comma sep relative vals)  
  -M, -max-mut        max mutations [infty] 
  -a, -pbat           pbat  
  -R, -random-pbat    random pbat  
  -s, -strand         strand {f, r, b} [b] 
      -fasta          output fasta format (no quality scores)  
      -seed           rng seed (default: from system) [infty] 
      -require-valid  require valid bases in fragments  
  -v, -verbose        print more run info  

Help options:
  -?, -help           print this help message  
      -about          print about message
```


## Metadata
- **Skill**: generated
