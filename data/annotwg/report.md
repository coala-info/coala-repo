# annotwg CWL Generation Report

## annotwg

### Tool Description
AnnotWG annotate a WG bgzipped and tabixed VCF file

### Metadata
- **Docker Image**: quay.io/biocontainers/annotwg:1.0--hdfd78af_1
- **Homepage**: https://gitlab.com/cnrgh/annotwg
- **Package**: https://anaconda.org/channels/bioconda/packages/annotwg/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/annotwg/overview
- **Total Downloads**: 2.0K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
USAGE :
annotwg [options]
  -v, --vcf <file.vcf.gz>
        vcf file bgzipped and indexed with tabix to annotate [Mandatory]
  -r, --reference <ref.fa>
        indexed fasta genome reference (.fai or .dict format) [Mandatory]
  -a, --annot <bcf_annot_file>
        path to an annotation file (bcf format csi indexed) [Mandatory]
  -s, --annot-list <list>
        a comma separated list of INFO features to annotate (all annotations by default)
  -t, --thread <integer>
        number of threads used by annotwg (optional) [default:1]
  -d, --tempdir <path/to/tmp> [default: working directory]
        path to annotWG temporary directory
  -o, --output <out_file> [default: <input_prefix>.annotated.vcf.gz]
        output, e.g. annotated VCF file
  -O, --output-format <b|z>
        b: compressed BCF, z: compressed VCF [default : z]
  -m, --join-alleles
        Annotation of splitted alleles can skip variants with bcftools.
        This flag try to use bcftools norm -m + to join alleles to correct this behavior [optional flag]
  -I, --indexing
        perform on the fly csi index generation of the ouput [optional flag]
  -T, --tbi
        generate a tbi index instead of csi
  -p, --annotprefix <prefix>
        prefix that will be added before every annotation from the annotation file [default ''].
        example: if '-p annotwg_' the XXX field from the annotation source will be annotated annotwg_XXX.
  -i, --id
        Annotate the ID field from the annotation source (optional flag)
  -l, --compression-level
        The level of compression (integer from 1 to 9) (optional) [default:-1]
  -h, --help
        print help

DESCRIPTION :
AnnotWG annotate a WG bgzipped and tabixed VCF file

EXAMPLE :
annotwg -v file.vcf.gz -r ref.fasta -a annot.bcf
```


## Metadata
- **Skill**: not generated
