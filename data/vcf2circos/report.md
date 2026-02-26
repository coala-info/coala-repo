# vcf2circos CWL Generation Report

## vcf2circos

### Tool Description
vcf2circos is a tool to visualize VCF files in a circular genome plot.

### Metadata
- **Docker Image**: quay.io/biocontainers/vcf2circos:1.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/bioinfo-chru-strasbourg/vcf2circos
- **Package**: https://anaconda.org/channels/bioconda/packages/vcf2circos/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/vcf2circos/overview
- **Total Downloads**: 4.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bioinfo-chru-strasbourg/vcf2circos
- **Stars**: N/A
### Original Help Text
```text
-._    _.--'"`'--._    _.--'"`'--._    _.--'"`'--._    _   
    '-:`.'|`|"':-.  '-:`.'|`|"':-.  '-:`.'|`|"':-.  '.` : '.   
  '.  '.  | |  | |'.  '.  | |  | |'.  '.  | |  | |'.  '.:   '.  '.
  : '.  '.| |  | |  '.  '.| |  | |  '.  '.| |  | |  '.  '.  : '.  `.
  '   '.  `.:_ | :_.' '.  `.:_ | :_.' '.  `.:_ | :_.' '.  `.'   `.
         `-..,..-'       `-..,..-'       `-..,..-'       `         `
    
                     __ ___      _                   
                    / _|__ \    (_)                  
         __   _____| |_   ) |___ _ _ __ ___ ___  ___ 
         \ \ / / __|  _| / // __| | '__/ __/ _ \/ __|
          \ V / (__| |  / /| (__| | | | (_| (_) \__ \
           \_/ \___|_| |____\___|_|_|  \___\___/|___/
                                                     
                                                     

Author: Jean-Baptiste Lamouche, Antony Le Bechec, Jin Cui
Version: 1.2.0
Last update: 18 Juin 2024


usage: python vcf2circos.py [-h] -i INPUT -o OUTPUT [-e EXPORT] [-p OPTIONS]
                            [-a ASSEMBLY]

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Input vcf File
                        VCF SHOULD be multiallelic split to avoid trouble in vcf2circos
                        example: bcftools -m -any <vcf>
                        Format will be autodetected from file path.
                        Supported format:
                           'vcf.gz', 'vcf'
  -o OUTPUT, --output OUTPUT
                        Output file.
                        Format will be autodetected from file path.
                        Supported format:
                           'png', 'jpg', 'jpeg', 'webp', 'svg', 'pdf', 'eps', 'json'
  -e EXPORT, --export EXPORT
                        Export file.
                        Format is 'json'.
                        Generate json file from VCF input file
  -p OPTIONS, --options OPTIONS
                        Options file in json format
  -a ASSEMBLY, --assembly ASSEMBLY
                        Genome assembly to use for now values available (hg19, hg38)
```

