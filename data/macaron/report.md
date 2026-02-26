# macaron CWL Generation Report

## macaron_MACARON

### Tool Description
Script to identify SnpClusters (SNPs within the same genetic codon)

### Metadata
- **Docker Image**: quay.io/biocontainers/macaron:1.0--pyh864c0ab_1
- **Homepage**: https://github.com/waqasuddinkhan/MACARON-GenMed-LabEx
- **Package**: https://anaconda.org/channels/bioconda/packages/macaron/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/macaron/overview
- **Total Downloads**: 6.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/waqasuddinkhan/MACARON-GenMed-LabEx
- **Stars**: N/A
### Original Help Text
```text
usage: MACARON [-h] -i INPUTFILE [-o OUTPUTFILE] [-f FIELDS]
               [--HG_REF HG_REF_PATH] [--GATK GATK_PATH]
               [--JAVA_OPTIONS JAVA_OPTIONS] [--SNPEFF SNPEFF_PATH]
               [--SNPEFF_HG SNPEFF_HG_VERSION] [-v] [-c] [--keep_tmp]
               [--gatk4_previous]

-Script to identify SnpClusters (SNPs within the same genetic codon)

optional arguments:
  -h, --help            show this help message and exit
  -i INPUTFILE, --infile INPUTFILE
                        Full path of the input VCF file.
  -o OUTPUTFILE, --outfile OUTPUTFILE
                        Path of the output txt file (Default Output file:
                        MACARON_output.txt)
  -f FIELDS, --fields FIELDS
                        Single field name or comma-seperated ',' multiple
                        field names can be given. Field name should be given
                        according to the (INFO) field header of the input vcf
                        file. Example: -f Func.refGene,ExonicFunc.refGene,Gene
                        .refGene,1000g2015aug_all,ExAC_ALL,ExAC_EAS,clinvar_20
                        161128,gnomAD_exome_ALL,gnomAD_genome_ALL,EFF,CSQ
  --HG_REF HG_REF_PATH  Indicate the full path to the reference genome fasta
                        file
  --GATK GATK_PATH      You can use this option to directly indicate the full
                        path to the GATK program (gatk wrapper or .jar)
  --JAVA_OPTIONS JAVA_OPTIONS
                        You can use this option to specify java arguments
                        required by GATK (default: --JAVA-OPTIONS "-Xmx4G")
  --SNPEFF SNPEFF_PATH  You can use this option to directly indicate the full
                        path to the snpEff jar or wrapper
  --SNPEFF_HG SNPEFF_HG_VERSION
                        Indicate SnpEff human genome annotation database
                        version
  -v, --verbosity       Use to print verbosity (Mostly GATK/SNPEFF output)
  -c, --add_anim        Add animation while running (looks good but costs a
                        thread)
  --keep_tmp            Keep temporary files in the directory tmp_macaron, at
                        the same location than the output file.
  --gatk4_previous      Use this option if you are using a version of gatk 4
                        older than gatk 4.1.4.1
```

