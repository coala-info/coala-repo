# djinn CWL Generation Report

## djinn_fastq

### Tool Description
FASTQ file conversions and modifications

### Metadata
- **Docker Image**: quay.io/biocontainers/djinn:2.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/pdimens/djinn
- **Package**: https://anaconda.org/channels/bioconda/packages/djinn/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/djinn/overview
- **Total Downloads**: 282
- **Last updated**: 2026-02-19
- **GitHub**: https://github.com/pdimens/djinn
- **Stars**: N/A
### Original Help Text
```text
Usage: djinn fastq COMMAND [ARGS]...                                            
                                                                                
FASTQ file conversions and modifications                                        
In most cases, you can specify --threads if pigz is available in your PATH. If  
pigz isn't available in your path, djinn will fall back to gzip and this value  
will be ignored. Otherwise, the number of threads will be divided evenly between
the number of FASTQ output files (therefore use even numbers for paired-end     
FASTQ files).                                                                   
                                                                                
Commands:                                                                       
  convert            Convert between linked-read formats                        
  extract            Extract all barcodes                                       
  filter-invalid     Retain only valid-barcoded reads                           
  filter-singletons  Retain reads with non-singleton barcodes                   
  ncbi               FASTQ → BAM conversion for NCBI                            
  sample             Downsample data by barcode                                 
  sort               Sort by barcode                                            
  spoof-hic          Convert linked-reads into fake HI-C data                   
  standardize        Move barcodes to BX+VX sequence header tags
```


## djinn_sam

### Tool Description
SAM/BAM file conversions and modifications

### Metadata
- **Docker Image**: quay.io/biocontainers/djinn:2.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/pdimens/djinn
- **Package**: https://anaconda.org/channels/bioconda/packages/djinn/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: djinn sam COMMAND [ARGS]...                                              
                                                                                
SAM/BAM file conversions and modifications                                      
Always writes to stdout. Use the subcommands below with the sam prefix, e.g.:   
                                                                                
                                                                                
 djinn sam sample options... args...                                            
                                                                                
                                                                                
Commands:                                                                       
  assign-mi          Assign an MI:i (Molecular Identifier) tags                 
  concat             Molecule-aware file concatenation                          
  extract            Extract all barcodes                                       
  filter-invalid     Retain only valid-barcoded reads                           
  filter-singletons  Retain only non-singleton reads                            
  ncbi               BAM → FASTQ conversion from NCBI                           
  sample             Downsample data by barcode                                 
  sort               Sort by barcode                                            
  standardize        Move barcodes to BX+VX sequence header tags
```

