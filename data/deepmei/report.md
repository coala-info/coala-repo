# deepmei CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| deepmei | Failed | image problem: the DeepMEI_model/reference folder (default ME_add_ALU.fa and ME_*.bed files) is missing, and the script writes temp files into its read-only install folder /usr/local/bin. |

## deepmei

### Tool Description
DeepMEI: detect mobile element insertions from short-read BAM or CRAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepmei:1.6.24--hdfd78af_1
- **Homepage**: https://github.com/Kanglu123/deepmei
- **Package**: https://anaconda.org/channels/bioconda/packages/deepmei/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepmei/overview
- **Total Downloads**: 2.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Kanglu123/deepmei
- **Stars**: N/A
### Original Help Text
```text
deepmei version 1.6.24
Usage:
  deepmei [-i bamfile] [-r reference] [-b bedfile] [-m ME_REF] [-q input genotype] [ -q quick_model] [-o output_prefix] [-v docker] [-w output_dir] [-d depth] [-c clean] [-j joint] [-h/? usage]  
   -i input bam file or cram file full path, required
   -r reference full path, required
   -m mobile elements reference, optional
   -b input genotype file, optional
   -q quick model, optional
   -o output prefix, optional,default is bam name
   -v only avaliable in docker images, optional
   -w output directory, required
   -d sequencing depth, default is 25, optional
   -c clean temp files[-c 1], optional but recommended
   -j joint genotyping,optional
   -h help
   -? help
```


## Metadata
- **Skill**: generated

