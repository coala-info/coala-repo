# annosine2 CWL Generation Report

## annosine2_AnnoSINE_v2

### Tool Description
SINE Annotation Tool for Plant Genomes

### Metadata
- **Docker Image**: quay.io/biocontainers/annosine2:2.0.9--pyh7e72e81_0
- **Homepage**: https://github.com/liaoherui/AnnoSINE
- **Package**: https://anaconda.org/channels/bioconda/packages/annosine2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/annosine2/overview
- **Total Downloads**: 7.3K
- **Last updated**: 2025-06-08
- **GitHub**: https://github.com/liaoherui/AnnoSINE
- **Stars**: N/A
### Original Help Text
```text
Example: AnnoSINE_v2 3 ../Input_Files/test.fasta ../Output_Files
usage: AnnoSINE_v2 [-h] [-e] [-v] [-l] [-c] [-s] [-g] [-minc] [-numa] [-a]
                   [-b] [-f] [-temd] [-auto] [-r] [-t] [-irf] [-rpm]
                   mode input_filename output_filename

SINE Annotation Tool for Plant Genomes

positional arguments:
  mode                  [1 | 2 | 3]
                        Choose the running mode of the program.
                        	1--Homology-based method;
                        	2--Structure-based method;
                        	3--Hybrid of homology-based and structure-based method.
  input_filename        input genome assembly path
  output_filename       output files path

options:
  -h, --help            show this help message and exit
  -e , --hmmer_evalue   Expectation value threshold for saving hits of homology search (default: 1e-10)
  -v , --blast_evalue   Expectation value threshold for sequences alignment search (default: 1e-10)
  -l , --length_factor 
                        Threshold of the local alignment length relative to the the BLAST query length (default: 0.3)
  -c , --copy_number_factor 
                        Threshold of the copy number that determines the SINE boundary (default: 0.15)
  -s , --shift          Maximum threshold of the boundary shift (default: 50)
  -g , --gap            Maximum threshold of the truncated gap (default: 10)
  -minc , --copy_number 
                        Minimum threshold of the copy number for each element (default: 20)
  -numa , --num_alignments 
                        --num_alignments value for blast alignments (default: 50000)
  -a , --animal         If set to 1, then Hmmer will search SINE using the animal hmm files from Dfam. If set to 2, then Hmmer will search SINE using both the plant and animal hmm files. (default: 0)
  -b , --boundary       Output SINE seed boundaries based on TSD or MSA (default: msa)
  -f , --figure         Output the SINE seed MSA figures and copy number profiles (y/n). Please note that this step may take a long time to process. (default: n)
  -temd , --temp_dir    The temp dir used by paf2blast6 script. If not set, will use /tmp folder automatically.
  -auto , --automatically_continue 
                        If set to 1, then the program will skip finished steps and continue unifinished steps for a previously processed output dir. (default: 0)
  -r , --non_redundant 
                        Annotate SINE in the whole genome based on the non-redundant library (y/n) (default: y)
  -t , --threads        Threads for each tool in AnnoSINE (default: 36)
  -irf , --irf_path     Path to the irf program (default: '')
  -rpm , --RepeatMasker_enable 
                        If set to 0, then will not run RepearMasker (Step 8 for the code). (default: 1)
```

