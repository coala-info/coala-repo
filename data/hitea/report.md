# hitea CWL Generation Report

## hitea

### Tool Description
No input provided

### Metadata
- **Docker Image**: quay.io/biocontainers/hitea:0.1.5--hdfd78af_1
- **Homepage**: https://github.com/parklab/HiTea
- **Package**: https://anaconda.org/channels/bioconda/packages/hitea/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hitea/overview
- **Total Downloads**: 5.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/parklab/HiTea
- **Stars**: N/A
### Original Help Text
```text
****No input provided


Usage: hitea [-w workdir] [-e enzyme] [-q anchor_mapq] [-o outprefix] [-s clip] [-g genome] [-r remap] [-x T/F,if WGS] [-n index] [-b repbase] [-p indexP] [-a anno] [-h help] -i inputs (space separated psam/bam in inverted commas)

Required****
    -i inputs :          Input file in pairsam format or unsorted-lossless bam format
    -e enzyme :          Restriction endunuclease used for the assay (default: '', available:MboI,DpnII,HindIII,Arima,NcoI,NotI)
    -g genome :          Genome build to be used (default:hg38, available: hg19)

Optional
  (following 4 parameters are optional if -g is specified)
    -n index :           fasta format file for TE-consensus sequences
    -b repbase :         fasta format file for Repbase subfamily sequences
    -p indexP :          fasta format file for Polymorphic sequences (header should be Family~name format
    -a anno :            reference-genome copies for TE-family members

    -o outprefix :       Output prefix while generating report files (default: project)
    -w workdir:          Working directory where the files are to be written
    -q anchor_mapq :     Mapping quality threshold for repeat anchored mate on the reference genome (default: 28)
    -s clip :            Minimum clip length for detecting insertion (should be >=13bp) (default: 20) 
    -r remap :           whether to remap unmapped clipped reads to the polymoprhic sequences (default:F)
    -x wgs :             whether the file is a WGS experiment (default:F)
    -h help :            Display help message
```

