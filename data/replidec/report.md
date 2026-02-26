# replidec CWL Generation Report

## replidec_Replidec

### Tool Description
Replidec, Replication cycle prediction tool for prokaryotic viruses

### Metadata
- **Docker Image**: quay.io/biocontainers/replidec:0.3.5--pyhdfd78af_0
- **Homepage**: https://github.com/deng-lab/Replidec
- **Package**: https://anaconda.org/channels/bioconda/packages/replidec/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/replidec/overview
- **Total Downloads**: 2.0K
- **Last updated**: 2025-07-02
- **GitHub**: https://github.com/deng-lab/Replidec
- **Stars**: N/A
### Original Help Text
```text
usage: Replidec [-h] [-v] -p  [-i ] [-w ] [-n ] [-t ] [-e ] [-E ] [-m ] [-M ]
                [-b ] [-B ] [-d]

Replidec, Replication cycle prediction tool for prokaryotic viruses

options:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
  -p, --program         { multi_fasta | genome_table | protein_table }
                        
                        multi_fasta mode:
                        input is a fasta file and treat each sequence as one virus
                        
                        genome_table mode:
                        input is a tab separated file with two columns
                        ___1st column: sample name
                        ___2nd column: path to the genome sequence file of the virus
                        
                        protein_table mode:
                        input is a tab separated file with two columns
                        ___1st column: sample name
                        ___2nd column: path to the protein file of the virus
                        
  -i, --input_file      The input file, which can be a sequence file or an index table
  -w, --work_dir        Directory to store intermediate and final results (default = ./Replidec_results)
  -n, --file_name       Name of final summary file (default = prediction_summary.tsv)
  -t, --threads         Number of parallel threads (default = 10)
  -e, --hmmer_Eval      E-value threshold to filter hmmer result (default = 1e-5)
  -E, --hmmer_parameters 
                        Parameters used for hmmer (default = --noali --cpu 3)
  -m, --mmseq_Eval      E-value threshold to filter mmseqs2 result (default = 1e-5)
  -M, --mmseq_parameters 
                        Parameter used for mmseqs
                        (default = -s 7 --max-seqs 1 --alignment-mode 3 --alignment-output-mode 0 --min-aln-len 40 --cov-mode 0 --greedy-best-hits 1 --threads 3)
  -b, --blastp_Eval     E-value threshold to filter blast result (default =1e-5)
  -B, --blastp_parameter 
                        Parameters used for blastp (default = -num_threads 3)
  -d, --db_redownload   Remove and re-download database
```

