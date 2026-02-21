# antarna CWL Generation Report

## antarna

### Tool Description
The provided text does not contain help information as the executable was not found in the environment.

### Metadata
- **Docker Image**: quay.io/biocontainers/antarna:2.0.1.2--py27_0
- **Homepage**: https://github.com/RobertKleinkauf/antarna
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/antarna/overview
- **Total Downloads**: 5.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/RobertKleinkauf/antarna
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/06 18:39:47  warn rootless{dev/console} creating empty file in place of device 5:1
INFO:    Inserting Apptainer configuration...
INFO:    Creating SIF file...
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
FATAL:   "antarna": executable file not found in $PATH
```


## Metadata
- **Skill**: generated

## antarna_antarna.py

### Tool Description
Ant Colony Optimized RNA Sequence Design

### Metadata
- **Docker Image**: quay.io/biocontainers/antarna:2.0.1.2--py27_0
- **Homepage**: https://github.com/RobertKleinkauf/antarna
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
usage: antarna.py [-h] [-Cseq CSEQ] [-l LEVEL] -tGC TGC [-tGCmax TGCMAX]
                  [-tGCvar TGCVAR] [-T TEMPERATURE] [-P PARAMFILE] [-noGU]
                  [-noLBP] [-n NOOFCOLONIES] [-of OUTPUT_FILE] [-rPY]
                  [--name NAME] [-v] [-ov] [--plot] [-s SEED]
                  [-ip IMPROVE_PROCEDURE] [-r RESETS]
                  [-aps ANTS_PER_SELECTION] [-CC CONVERGENCECOUNT]
                  [-aTC ANTSTERCONV] [--alpha ALPHA] [--beta BETA]
                  [--omega OMEGA] [-er ER] [-Cstrw CSTRWEIGHT]
                  [-Cgcw CGCWEIGHT] [-Cseqw CSEQWEIGHT] [-t TIME]
                  {MFE,DP} ...

    
	#########################################################################
	#       antaRNA - ant assembled RNA                                     #
	#       -> Ant Colony Optimized RNA Sequence Design                     #
	#       ------------------------------------------------------------    #
	#       Robert Kleinkauf (c) 2015                                       #
	#       Bioinformatics, Albert-Ludwigs University Freiburg, Germany     #
	#########################################################################
  
	- For antaRNA only the VIENNNA RNA Package must be installed on your linux system.
	  antaRNA will only check, if the executables of RNAfold  of the ViennaRNA package can be found. If those programs are 
	  not installed correctly, no output will be generated, an also no warning will be prompted.
	  So the binary path of the Vienna Tools must be set up correctly in your system's PATH variable in order to run antaRNA correctly!
	- If you want to use the pseudoknot functionality, pKiss_mfe of the RNAshapes studio OR HotKnots OR IPKnot must be installed and callable as standalone in order to execute antaRNA.
    
    - antaRNA was only tested under Linux.
    
    - For questions and remarks please feel free to contact us at http://www.bioinf.uni-freiburg.de/
	
	

positional arguments:
  {MFE,DP}              'MFE' (minimum free energy) or 'DP' (dotplot) mode selection
    MFE                 MFE mode: compute an RNA sequence according to the mfe model of a structure. Required for the pseudoknot variant.
    DP                  DP mode: compute an RNA sequence according to the dotplot(s) model.

optional arguments:
  -h, --help            show this help message and exit

Constraint Variables:
  Use to define an RNA constraint system.

  -Cseq CSEQ, --Cseq CSEQ
                        Sequence constraint using RNA nucleotide alphabet {A,C,G,U} and wild-card "N". 
                        (TYPE: str)
                        
  -l LEVEL, --level LEVEL
                        Sets the level of allowed influence of sequence constraint on the structure constraint [0:no influence; 3:extensive influence].
                        (TYPE: int)
                        
  -tGC TGC, --tGC TGC   Objective target GC content in [0,1].
                        (TYPE: parseGC)
                        
  -tGCmax TGCMAX, --tGCmax TGCMAX
                        Provides a maximum tGC value [0,1] for the case of uniform distribution sampling. The regular tGC value serves as minimum value.
                        (DEFAULT: -1.0, TYPE: float)
                        
  -tGCvar TGCVAR, --tGCvar TGCVAR
                        Provides a tGC variance (sigma square) for the case of normal distribution sampling. The regular tGC value serves as expectation value (mu).
                        (DEFAULT: -1.0, TYPE: float)
                        
  -T TEMPERATURE, --temperature TEMPERATURE
                        Provides a temperature for the folding algorithms.
                        (DEFAULT: 37.0, TYPE: float)
                        
  -P PARAMFILE, --paramFile PARAMFILE
                        Changes the energy parameterfile of RNAfold. If using this explicitly, please provide a suitable energy file delivered by RNAfold. 
                        (DEFAULT: , TYPE: str)
                        
  -noGU, --noGUBasePair
                        Forbid GU base pairs. 
                        
  -noLBP, --noLBPmanagement
                        Disallowing antaRNA lonely base pair-management. 
                        

Output Variables:
  Tweak form and verbosity of output.

  -n NOOFCOLONIES, --noOfColonies NOOFCOLONIES
                        Number of sequences which shall be produced. 
                        (TYPE: int)
                        
  -of OUTPUT_FILE, --output_file OUTPUT_FILE
                        Provide a path and an output file, e.g. "/path/to/the/target_file". 
                        (DEFAULT: STDOUT, TYPE: str)
                        
  -rPY, --py            Switch on PYTHON compatible behavior. 
                        (DEFAULT: False)
                        
  --name NAME           Defines a name which is used in the sequence output. 
                        (DEFAULT: antaRNA, TYPE: str)
                        
  -v, --verbose         Displayes intermediate output.
                        
  -ov, --output_verbose
                        Prints additional features and stats to the headers of the produced sequences. Also adds the structure of the sequence.
                        
  --plot                Print Terrain Nodes and edges files.
                        

Ant Colony Variables:
  Alter the behavior of the ant colony optimization.

  -s SEED, --seed SEED  Provides a seed value for the used pseudo random number generator.
                        (DEFAULT: None, TYPE: str)
                        
  -ip IMPROVE_PROCEDURE, --improve_procedure IMPROVE_PROCEDURE
                        Select the improving method.  h=hierarchical, s=score_based.
                        (DEFAULT: s, TYPE: str)
                        
  -r RESETS, --Resets RESETS
                        Amount of maximal terrain resets, until the best solution is retuned as solution.
                        (DEFAULT: 5, TYPE: int)
                        
  -aps ANTS_PER_SELECTION, --ants_per_selection ANTS_PER_SELECTION
                        best out of k ants.
                        (DEFAULT: 10, TYPE: int)
                        
  -CC CONVERGENCECOUNT, --ConvergenceCount CONVERGENCECOUNT
                        Delimits the convergence count criterion for a reset.
                        (DEFAULT: 130, TYPE: int)
                        
  -aTC ANTSTERCONV, --antsTerConv ANTSTERCONV
                        Delimits the amount of internal ants for termination convergence criterion for a reset.
                        (DEFAULT: 50, TYPE: int)
                        
  --alpha ALPHA         Sets alpha, probability weight for terrain pheromone influence. [0,1] 
                        (DEFAULT: 1.0, TYPE: float)
                        
  --beta BETA           Sets beta, probability weight for terrain path influence. [0,1]
                        (DEFAULT: 1.0, TYPE: float)
                        
  --omega OMEGA         Sets the value, which is used in the mimiced 1/x evaluation function in order to set a crossing point on the y-axis.
  -er ER, --ER ER       Pheromone evaporation rate. 
                        (DEFAULT: 0.2, TYPE: float)
                        
  -Cstrw CSTRWEIGHT, --Cstrweight CSTRWEIGHT
                        Structure constraint quality weighting factor. [0,1]
                        (DEFAULT: 0.5, TYPE: float)
                        
  -Cgcw CGCWEIGHT, --Cgcweight CGCWEIGHT
                        GC content constraint quality weighting factor. [0,1]
                        (DEFAULT: 5.0, TYPE: float)
                        
  -Cseqw CSEQWEIGHT, --Cseqweight CSEQWEIGHT
                        Sequence constraint quality weighting factor. [0,1]
                        (DEFAULT: 1.0, TYPE: float)
                        
                        
  -t TIME, --time TIME  Limiting runtime [seconds]
                        (DEFAULT: 600, TYPE: int)
                        
                        

   
	Example calls:
		python antaRNA_vXY.py -Cstr "...(((...)))..." -tGC 0.5 -n 2 -v
		python antaRNA_vXY.py -Cstr ".........aaa(((...)))aaa........." -tGC 0.5 -n 10 --output_file /path/to/antaRNA_TESTRUN -v
		python antaRNA_vXY.py -Cstr "BBBBB....AAA(((...)))AAA....BBBBB" -Cseq "NNNNANNNNNCNNNNNNNNNNNGNNNNNNUNNN" --tGC 0.5 -n 10

	#########################################################################
	#       --- Hail to the Queen!!! All power to the swarm!!! ---          #
	#########################################################################
```

