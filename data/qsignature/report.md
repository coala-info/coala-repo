# qsignature CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| qsignature_QSigCompare | Failed | image problem: Java fails at start with UnsatisfiedLinkError (libnio.so cannot load libnet.so) |
| qsignature_SignatureGenerator | Failed | image problem: Java fails at start with UnsatisfiedLinkError (libnio.so cannot load libnet.so) |

## qsignature_SignatureGenerator

### Tool Description
Generate a qsignature VCF of base counts at SNP positions from a BAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/qsignature:0.1pre--3
- **Homepage**: https://github.com/AdamaJava/adamajava/tree/master/qsignature
- **Package**: https://anaconda.org/channels/bioconda/packages/qsignature/overview
- **Validation**: PASS

### Original Help Text
```text
usage: qsignature ToolName [-options] (See https://qcmg-wiki.imb.uq.edu.au/index.php/Qsignature for more details)
Option                                  Description                            
------                                  -----------                            
-V, -v, --version                       Print version info.                    
--additionalSearchString <Additional    Specifies an input file or directory.  
  Search string>                                                               
--cutoff <Float: cutoff>                Specifies the cutoff value to be used  
                                          in the comparison                    
-d, --dir, --directory <outdir>         Specifies the output directory.        
--email <email>                         Specifies an input file or directory.  
--emailSubject <emailSubject>           Specifies an input file or directory.  
--excludeVcfsFile <excludeVcfsFile>     Specifies an input file or directory.  
-h, --help                              Shows this help message.               
-i, --input <infile>                    Specifies an input file or directory.  
--illuminaArraysDesign <Illumina        Specifies an input file or directory.  
  Arrays Design file>                                                          
--log                                   Full path to file where log output     
                                          will be directed (must have write    
                                          permissions)                         
--loglevel                              Logging level required, e.g. INFO,     
                                          DEBUG. (Optional) If no parameter is 
                                          specified, will default to INFO      
--minBaseQuality <Integer:              Specifies the minimum base quality the 
  minBaseQuality>                         base must have to be considered in   
                                          the calculation                      
--minCoverage <Integer: minCoverage>    Specifies the minimum coverage to be   
                                          used in the comparison               
--minMappingQuality <Integer:           Specifies the minimum mapping quality  
  minMappingQuality>                      the read must have to be considered  
                                          in the calculation                   
--noOfThreads <Integer: noOfThreads>    Specifies the number of threads to be  
                                          used when retireving positions from  
                                          bam files                            
--output <outputfile>                   Specifies the output file.             
-p, --position <position>               Specifies an input file or directory.  
--searchSuffix <Search suffix>          Specifies an input file or directory.  
--sequential                            Specifies that bam access should be    
                                          sequential rather than indexed       
--snpChipSearchSuffix <Snp Chip Search  Specifies an input file or directory.  
  Suffix>                                                                      
--snpPositions <snpPositions>           Specifies the snp positions file.      
--validation                            How strict to be when reading a SAM or 
                                          BAM. Possible values: {STRICT,       
                                          LENIENT, SILENT}
```

## qsignature_QSigCompare

### Tool Description
Compare qsignature VCF files in a directory and report the pairwise similarity as XML.

### Metadata
- **Docker Image**: quay.io/biocontainers/qsignature:0.1pre--3
- **Homepage**: https://github.com/AdamaJava/adamajava/tree/master/qsignature
- **Package**: https://anaconda.org/channels/bioconda/packages/qsignature/overview
- **Validation**: PASS

### Original Help Text
```text
usage: qsignature ToolName [-options] (See https://qcmg-wiki.imb.uq.edu.au/index.php/Qsignature for more details)
Option                                  Description                            
------                                  -----------                            
-V, -v, --version                       Print version info.                    
--additionalSearchString <Additional    Specifies an input file or directory.  
  Search string>                                                               
--cutoff <Float: cutoff>                Specifies the cutoff value to be used  
                                          in the comparison                    
-d, --dir, --directory <outdir>         Specifies the output directory.        
--email <email>                         Specifies an input file or directory.  
--emailSubject <emailSubject>           Specifies an input file or directory.  
--excludeVcfsFile <excludeVcfsFile>     Specifies an input file or directory.  
-h, --help                              Shows this help message.               
-i, --input <infile>                    Specifies an input file or directory.  
--illuminaArraysDesign <Illumina        Specifies an input file or directory.  
  Arrays Design file>                                                          
--log                                   Full path to file where log output     
                                          will be directed (must have write    
                                          permissions)                         
--loglevel                              Logging level required, e.g. INFO,     
                                          DEBUG. (Optional) If no parameter is 
                                          specified, will default to INFO      
--minBaseQuality <Integer:              Specifies the minimum base quality the 
  minBaseQuality>                         base must have to be considered in   
                                          the calculation                      
--minCoverage <Integer: minCoverage>    Specifies the minimum coverage to be   
                                          used in the comparison               
--minMappingQuality <Integer:           Specifies the minimum mapping quality  
  minMappingQuality>                      the read must have to be considered  
                                          in the calculation                   
--noOfThreads <Integer: noOfThreads>    Specifies the number of threads to be  
                                          used when retireving positions from  
                                          bam files                            
--output <outputfile>                   Specifies the output file.             
-p, --position <position>               Specifies an input file or directory.  
--searchSuffix <Search suffix>          Specifies an input file or directory.  
--sequential                            Specifies that bam access should be    
                                          sequential rather than indexed       
--snpChipSearchSuffix <Snp Chip Search  Specifies an input file or directory.  
  Suffix>                                                                      
--snpPositions <snpPositions>           Specifies the snp positions file.      
--validation                            How strict to be when reading a SAM or 
                                          BAM. Possible values: {STRICT,       
                                          LENIENT, SILENT}
```

## Metadata
- **Skill**: generated

