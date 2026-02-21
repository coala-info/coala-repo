# pepquery CWL Generation Report

## pepquery

### Tool Description
A tool for peptide-centric identification and validation of proteomics data.

### Metadata
- **Docker Image**: quay.io/biocontainers/pepquery:2.0.2--hdfd78af_0
- **Homepage**: https://github.com/bzhanglab/PepQuery
- **Package**: https://anaconda.org/channels/bioconda/packages/pepquery/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pepquery/overview
- **Total Downloads**: 15.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bzhanglab/PepQuery
- **Stars**: N/A
### Original Help Text
```text
java -Xmx2G -jar pepquery.jar
usage: Options
 -i <arg>                The value for this parameter could be (1) a single peptide sequence; (2)
                         multiple peptide sequences separated by ','; (3) a file contains peptide
                         sequence(s). If it is a file contains peptide sequence(s), each row is a
                         single peptide sequence and there is no header in the file; (4) a file
                         contains peptide sequence and spectrum ID and they are separated by tab
                         '\t'. There is no header in the file. This is used when perform PSM level
                         validation; (5) a protein sequence. This is used when perform novel protein
                         identification; (6) a protein ID. This is used for targeted known protein
                         identification; (7) a DNA sequence; (8) a VCF file; (9) a bed file; (10) a
                         GTF file.
 -t <arg>                Input type for parameter -i: peptide (or pep) when the setting for -i
                         belongs to (1)-(4), protein (or pro) when the setting for -i belongs to
                         (5)-(6), DNA (or dna), VCF (or vcf), BED (or bed), GTF or (gtf). The
                         default is peptide.
 -s <arg>                Task type: 1 => novel peptide/protein validation (default), 2 => known
                         peptide/protein validation. Default is 1.
 -ms <arg>               MS/MS data used for identification. MGF, mzML, mzXML, mgf.gz, mzML.gz,
                         mzXML.gz and raw formats are supported. USI is also supported.
 -indexType <arg>        When the input MS/MS data is in MGF format, what type of index will be
                         used: 1 => index (1-based), 2 => spectrum title in MGF file. Default is 1.
 -b <arg>                MS/MS dataset ID(s) to search. Two types of dataset ID are supported: the
                         dataset ID from indexed PepQueryDB and dataset ID from public proteomics
                         data repositories including PRIDE, MassIVE, jPOSTrepo and iProX. Multiple
                         datasets from PepQueryDB must be separated by comma. A pattern to match
                         datasets in PepQueryDB is also supported, for example, use '-b CPTAC' to
                         search all datasets contain 'CPTAC'. In addition, dataset selection from
                         PepQueryDB based on data type (w:global proteome, p:phosphorylation,
                         a:acetylation, u:ubiquitination, g:glycosylation) is also supported. For
                         example, use '-b p' to search all phosphoproteomics datasets in PepQueryDB.
                         Use '-b show' to present all MS/MS datasets available in PepQueryDB. For
                         dataset ID from public proteomics data repositories, one dataset is
                         supported for each analysis. For example, use '-b PXD000529' to use all
                         MS/MS data from dataset PXD000529 or use '-b PXD000529:LM3' to use data
                         files containing LM3 from dataset PXD000529.
 -db <arg>               A protein reference database in FASTA format. For example, a protein
                         sequence database from RefSeq, GENCODE, Ensembl or UniProt. A string like
                         swissprot:human, refseq:human or gencode:human is also accepted. If later
                         is the case, PepQuery will automatically download protein database from
                         online databases.
 -frame <arg>            The frame to translate DNA sequence to protein. The right format is like
                         this: '1,2,3,4,5,6', '1,2,3', '1' or '0' which means to keep the longest
                         frame. In default, for each frame only the longest protein is used. It is
                         only used when the input for '-i' is a DNA sequence.
 -anno <arg>             Annotation files folder for VCF/BED/GTF
 -decoy                  In known protein identification mode, try to identity the decoy version of
                         the selected target protein. Default is false.
 -e <arg>                Enzyme used for protein digestion. 0:Non enzyme, 1:Trypsin (default),
                         2:Trypsin (no P rule), 3:Arg-C, 4:Arg-C (no P rule), 5:Arg-N, 6:Glu-C,
                         7:Lys-C
 -c <arg>                The max missed cleavages, default is 2
 -minLength <arg>        The minimum length of peptide to consider, default is 7
 -maxLength <arg>        The maximum length of peptide to consider, default is 45
 -tol <arg>              Precursor ion m/z tolerance, default is 10
 -tolu <arg>             The unit of precursor ion m/z tolerance, default is ppm
 -itol <arg>             Fragment ion m/z tolerance in Da, default is 0.6
 -fragmentMethod <arg>   1: CID/HCD (default), 2: ETD
 -fixMod <arg>           Fixed modification, the format is like : 1,2,3. Use '-printPTM' to show all
                         supported modifications. Default is 1 (Carbamidomethylation(C)[57.02]). If
                         there is no fixed modification, set it as '-fixMod no' or '-fixMod 0'.
 -varMod <arg>           Variable modification, the format is same with -fixMod. Default is 2
                         (Oxidation(M)[15.99]). If there is no variable modification, set it as
                         '-varMod no' or '-varMod 0'.
 -maxVar <arg>           Max number of variable modifications, default is 3
 -aa                     Whether or not to consider aa substitution modifications when perform
                         modification filtering. In default, don't consider.
 -printPTM               Print PTMs
 -ti <arg>               Range of allowed isotope peak errors, such as '0,1'; Default: 0
 -p <arg>                MS/MS searching parameter set name. Use '-p show' to show all predefined
                         parameter sets.
 -m <arg>                Scoring method: 1=HyperScore (default), 2=MVH
 -hc                     When perform validation with unrestricted modification searching (UMS),
                         whether or not to use more stringent criterion. TRUE:
                         score(UMS)>=score(targetPSM); FALSE: score(UMS)>score(targetPSM), default
 -x                      Add extra score validation. It means use two scoring algorithms for peptide
                         identification.
 -fast                   Choose to use the fast mode for searching or not. In fast mode, only one
                         better match from reference peptide-based competitive filtering steps will
                         be returned. A peptide identified or not is not affected by this setting.
 -n <arg>                The number of random peptides generated for p-value calculation, default is
                         10000.
 -minPeaks <arg>         Min peaks in spectrum, default is 10
 -minScore <arg>         Minimum score to consider for peptide searching, default is 12
 -o <arg>                Output directory
 -cpu <arg>              The number of cpus used, default is to use all available CPUs
 -minCharge <arg>        The minimum charge to consider if the charge state is not available,
                         default is 2
 -maxCharge <arg>        The maximum charge to consider if the charge state is not available,
                         default is 3
 -dc <arg>               Tool path for Raw MS/MS data conversion: for example,
                         /home/test/ThermoRawFileParser/ThermoRawFileParser.exe
 -plot                   Generate PSM annotation data for plot.
 -h                      Help
```


## Metadata
- **Skill**: not generated
