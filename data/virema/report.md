# virema CWL Generation Report

## virema_ViReMa.py

### Tool Description
ViReMa Version 0.6 - written by Andrew Routh

### Metadata
- **Docker Image**: quay.io/biocontainers/virema:0.6--py27_0
- **Homepage**: https://sourceforge.net/projects/virema/
- **Package**: https://anaconda.org/channels/bioconda/packages/virema/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/virema/overview
- **Total Downloads**: 6.1K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
-------------------------------------------------------------------------------------------
ViReMa Version 0.6 - written by Andrew Routh
Last modified 6/6/2014
-------------------------------------------------------------------------------------------
usage: ViReMa.py [-h] [--Host_Index HOST_INDEX] [--N N] [--Seed SEED]
                 [--ThreePad THREEPAD] [--FivePad FIVEPAD] [--X X]
                 [--Host_Seed HOST_SEED] [-F] [--Defuzz DEFUZZ]
                 [--MaxFuzz MAXFUZZ] [-DeDup] [-ReadNamesEntry]
                 [--MicroInDel_Length MICROINDEL_LENGTH]
                 [--Compound_Handling COMPOUND_HANDLING]
                 [--Output_Tag OUTPUT_TAG] [--Output_Dir OUTPUT_DIR] [--p P]
                 [--Chunk CHUNK] [--Aligner ALIGNER] [-No_Compile] [-BED]
                 [-Win]
                 Virus_Index Input_Data Output_Data

positional arguments:
  Virus_Index           Virus genome reference index key. e.g. FHV_Genome
  Input_Data            File containing single reads in FASTQ format
  Output_Data           Destination file for results

optional arguments:
  -h, --help            show this help message and exit
  --Host_Index HOST_INDEX
                        Host genome reference index key, e.g.
                        d_melanogaster_fb5_22
  --N N                 Number of mismatches tolerated in mapped seed and in
                        mapped segments. Default is 1.
  --Seed SEED           Number of nucleotides in the Seed region. Default is
                        25.
  --ThreePad THREEPAD   Number of nucleotides not allowed to have mismatches
                        at 3' end of segment. Default is 5.
  --FivePad FIVEPAD     Number of nucleotides not allowed to have mismatches
                        at 5' end of segment. Default is 5.
  --X X                 Number of nucleotides not allowed to have mismatches
                        at 3' end and 5' of segment. Overrides seperate
                        ThreePad and FivePad settings. Default is 5.
  --Host_Seed HOST_SEED
                        Number of nucleotides in the Seed region when mapping
                        to the Host Genome. Default is same as Seed value.
  -F                    Select '-F' if data is in FASTA format fasta. Default
                        is FASTQ.
  --Defuzz DEFUZZ       Choose how to defuzz data: '5' to report at 5' end of
                        fuzzy region, '3' to report at 3' end, or '0' to
                        report in centre of fuzzy region. Default is no fuzz
                        handling (similar to choosing Right - see Routh et
                        al).
  --MaxFuzz MAXFUZZ     Select maximum allowed length of fuzzy region.
                        Recombination events with longer fuzzy regions will
                        not be reported. Default is Seed Length.
  -DeDup                Remove potential PCR duplicates. Default is 'off'.
  -ReadNamesEntry       Append Read Names contributing to each compiled
                        result. Default is off.
  --MicroInDel_Length MICROINDEL_LENGTH
                        Size of MicroInDels - these are common artifacts of
                        cDNA preparation. See Routh et al JMB 2012. Default
                        size is 0)
  --Compound_Handling COMPOUND_HANDLING
                        Select this option for compound recombination event
                        mapping (see manual for details). Enter number of
                        nucleotides to map (must be less than Seed, and
                        greater than number of nts in MicroInDel). Default is
                        off.
  --Output_Tag OUTPUT_TAG
                        Enter a tag name that will be appended to end of each
                        output file.
  --Output_Dir OUTPUT_DIR
                        Enter a directory name that all compiled output files
                        will be saved in.
  --p P                 Enter number of available processors. Default is 1.
  --Chunk CHUNK         Enter number of reads to process together.
  --Aligner ALIGNER     Enter Alignment Software: 'bwa', 'bowtie'. Default is
                        bowtie.
  -No_Compile           Select this option if you do not wish to compile the
                        results file into. Maybe useful when combining results
                        from different datasets.
  -BED                  Output recombination data into BED files.
  -Win                  Select this option if running ViReMa from a
                        Windows/Cygwin shell.
```


## virema_Compiler_Module.py

### Tool Description
Viral Recombination Mapper - Compilation Module

### Metadata
- **Docker Image**: quay.io/biocontainers/virema:0.6--py27_0
- **Homepage**: https://sourceforge.net/projects/virema/
- **Package**: https://anaconda.org/channels/bioconda/packages/virema/overview
- **Validation**: PASS

### Original Help Text
```text
-------------------------------------------------------------------------------------------
ViReMa_0.6 - Viral Recombination Mapper - Compilation Module
Last modified 6/05/2014
-------------------------------------------------------------------------------------------
usage: Compiler_Module.py [-h] [--Output_Tag OUTPUT_TAG] [-DeDup]
                          [-ReadNamesEntry] [--Defuzz DEFUZZ]
                          [--MaxFuzz MAXFUZZ]
                          [--MicroInDel_Length MICROINDEL_LENGTH]
                          [--Compound_Handling COMPOUND_HANDLING]
                          [--Output_Dir OUTPUT_DIR] [-BED]
                          Input_Data

positional arguments:
  Input_Data            UnCompiled Results file from ViReMa run

optional arguments:
  -h, --help            show this help message and exit
  --Output_Tag OUTPUT_TAG
                        Enter a tag name that will be appended to end of each
                        output file.
  -DeDup                Remove potential PCR duplicates. Default is off.
  -ReadNamesEntry       Append Read Names contributing to each compiled
                        result. Default is off.
  --Defuzz DEFUZZ       Choose how to defuzz data: '5' to report at 5' end of
                        fuzzy region, '3' to report at 3' end, or '0' to
                        report in centre of fuzzy region. Default is no fuzz
                        handling (similar to choosing Right - see Routh et
                        al).
  --MaxFuzz MAXFUZZ     Select maximum allowed length of fuzzy region.
                        Recombination events with longer fuzzy regions will
                        not be reported. Default is Seed Length.
  --MicroInDel_Length MICROINDEL_LENGTH
                        Size of MicroInDels - these are common artifacts of
                        cDNA preparation. See Routh et al JMB 2012. Default
                        size is 0)
  --Compound_Handling COMPOUND_HANDLING
                        Select this option for compound recombination event
                        mapping (see manual for details). Enter number of
                        nucleotides to map (must be less than Seed, and
                        greater than number of nts in MicroInDel). Default is
                        off.
  --Output_Dir OUTPUT_DIR
                        Enter a directory name that all compiled output files
                        will be saved in.
  -BED                  Output recombination data into BED files.
```

