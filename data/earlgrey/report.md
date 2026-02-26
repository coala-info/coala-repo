# earlgrey CWL Generation Report

## earlgrey_earlGrey

### Tool Description
A script for modification and automation of RepeatMasker configuration with Dfam 3.9.

### Metadata
- **Docker Image**: quay.io/biocontainers/earlgrey:7.0.2--hd63eeec_0
- **Homepage**: https://github.com/TobyBaril/EarlGrey
- **Package**: https://anaconda.org/channels/bioconda/packages/earlgrey/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/earlgrey/overview
- **Total Downloads**: 31.4K
- **Last updated**: 2026-02-12
- **GitHub**: https://github.com/TobyBaril/EarlGrey
- **Stars**: N/A
### Original Help Text
```text
)  (
	     (   ) )
	     ) ( (
	   _______)_
	.-'---------|  
       ( C|/\/\/\/\/|
	'-./\/\/\/\/|
	  '_________'
	   '-------'
	<<< Checking Parameters >>>
WARNING: Earl Grey v6.1.0 has updated to Dfam v3.9.
Before using Earl Grey, you MUST download the required partitions from Dfam (https://dfam.org/releases/current/families/FamDB/)
These must be located at /usr/local/share/RepeatMasker/Libraries/famdb/. Then, you must reconfigure RepeatMasker before using Earl Grey.
I have written the required commands for you to faciliate the process.
Please follow these carefully to ensure successful configuration of RepeatMasker with Dfam 3.9.
As a note, these DB paritions are BIG, so only download the ones you need for your studies (or, if you do need all of them, make sure you have the space for them)
########################################################
A script for modification and automation of these steps has been generated in //configure_dfam39.sh
Please open the script in your preferred text editor (e.g. nano or vim) and change the partition numbers in [] to those that you would like to download
then, make the script executable (chmod +x //configure_dfam39.sh) and run it: ./configure_dfam39.sh
Alternatively, you can run the steps below one-by-one to achieve the same outcome:
########################################################

# first, change directory to the famdb library location
cd /usr/local/share/RepeatMasker/Libraries/famdb/

# download the partitions you require from Dfam 3.9. In the below, change the numbers or range inside the square brackets to choose your subsets.
# e.g. to download partitions 0 to 10: [0-10]; or to download partitions 3,5, and 7: [3,5,7]; [0-16] is ALL PARTITIONS
curl -o 'dfam39_full.#1.h5.gz' 'https://dfam.org/releases/current/families/FamDB/dfam39_full.[0-16].h5.gz'

# decompress Dfam 3.9 paritions
gunzip *.gz

# move up to RepeatMasker main directory
cd /usr/local/share/RepeatMasker/

# save the min_init partition as a backup, just in case!
mv /usr/local/share/RepeatMasker/Libraries/famdb/min_init.0.h5 /usr/local/share/RepeatMasker/Libraries/famdb/min_init.0.h5.bak

# Rerun RepeatMasker configuration
perl ./configure -libdir /usr/local/share/RepeatMasker/Libraries/     		-trf_prgm /usr/local/bin/trf    			-rmblast_dir /usr/local/bin     		-hmmer_dir /usr/local/bin     		-abblast_dir /usr/local/bin     		-crossmatch_dir /usr/local/bin     		-default_search_engine rmblast

########################################################

Following these steps should enable you to use Dfam 3.9 with RepeatMasker and Earl Grey
You will not see this message again if configuration is successful
If you only want partition 0, you do not have to do anything except rerun your Earl Grey command
If you are still having trouble, please open an issue on the Earl Grey github and we will try to help!
```


## earlgrey_earlGreyLibConstruct

### Tool Description
A script for modification and automation of Dfam configuration steps for RepeatMasker.

### Metadata
- **Docker Image**: quay.io/biocontainers/earlgrey:7.0.2--hd63eeec_0
- **Homepage**: https://github.com/TobyBaril/EarlGrey
- **Package**: https://anaconda.org/channels/bioconda/packages/earlgrey/overview
- **Validation**: PASS

### Original Help Text
```text
)  (
             (   ) )
             ) ( (
           _______)_
        .-'---------|  
       ( C|/\/\/\/\/|
        '-./\/\/\/\/|
          '_________'
           '-------'
        <<< Checking Parameters >>>
WARNING: Earl Grey v6.1.0 has updated to Dfam v3.9.
Before using Earl Grey, you MUST download the required partitions from Dfam (https://dfam.org/releases/current/families/FamDB/)
These must be located at /usr/local/share/RepeatMasker/Libraries/famdb/. Then, you must reconfigure RepeatMasker before using Earl Grey.
I have written the required commands for you to faciliate the process.
Please follow these carefully to ensure successful configuration of RepeatMasker with Dfam 3.9.
As a note, these DB paritions are BIG, so only download the ones you need for your studies (or, if you do need all of them, make sure you have the space for them)
########################################################
A script for modification and automation of these steps has been generated in //configure_dfam39.sh
Please open the script in your preferred text editor (e.g. nano or vim) and change the partition numbers in [] to those that you would like to download
then, make the script executable (chmod +x //configure_dfam39.sh) and run it: ./configure_dfam39.sh
Alternatively, you can run the steps below one-by-one to achieve the same outcome:
########################################################

# first, change directory to the famdb library location
cd /usr/local/share/RepeatMasker/Libraries/famdb/

# download the partitions you require from Dfam 3.9. In the below, change the numbers or range inside the square brackets to choose your subsets.
# e.g. to download partitions 0 to 10: [0-10]; or to download partitions 3,5, and 7: [3,5,7]; [0-16] is ALL PARTITIONS
curl -o 'dfam39_full.#1.h5.gz' 'https://dfam.org/releases/current/families/FamDB/dfam39_full.[0-16].h5.gz'

# decompress Dfam 3.9 paritions
gunzip *.gz

# move up to RepeatMasker main directory
cd /usr/local/share/RepeatMasker/

# save the min_init partition as a backup, just in case!
mv /usr/local/share/RepeatMasker/Libraries/famdb/min_init.0.h5 /usr/local/share/RepeatMasker/Libraries/famdb/min_init.0.h5.bak

# Rerun RepeatMasker configuration
perl ./configure -libdir /usr/local/share/RepeatMasker/Libraries/     		-trf_prgm /usr/local/bin/trf    			-rmblast_dir /usr/local/bin     		-hmmer_dir /usr/local/bin     		-abblast_dir /usr/local/bin     		-crossmatch_dir /usr/local/bin     		-default_search_engine rmblast

########################################################

Following these steps should enable you to use Dfam 3.9 with RepeatMasker and Earl Grey
You will not see this message again if configuration is successful
If you only want partition 0, you do not have to do anything except rerun your Earl Grey command
If you are still having trouble, please open an issue on the Earl Grey github and we will try to help!
```


## earlgrey_earlGreyAnnotationOnly

### Tool Description
earlGrey version 7.0.2 (AnnotationOnly)

### Metadata
- **Docker Image**: quay.io/biocontainers/earlgrey:7.0.2--hd63eeec_0
- **Homepage**: https://github.com/TobyBaril/EarlGrey
- **Package**: https://anaconda.org/channels/bioconda/packages/earlgrey/overview
- **Validation**: PASS

### Original Help Text
```text
)  (
	     (   ) )
	     ) ( (
	   _______)_
	.-'---------|  
       ( C|/\/\/\/\/|
	'-./\/\/\/\/|
	  '_________'
	   '-------'
	<<< Checking Parameters >>>
	#############################
	earlGrey version 7.0.2 (AnnotationOnly)
	Required Parameters:
		-g == genome.fasta
		-s == species name
		-o == output directory
        -l == Starting consensus library for annotation (in fasta format)

	Optional Parameters:
		-t == Number of Threads (DO NOT specify more than are available)
       	-r == RepeatMasker species for addition to custom library (Default: None)
		-m == Remove putative spurious TE annotations <100bp? (yes/no, Default: no)
		-d == Create soft-masked genome at the end? (yes/no, Default: no)
		-e == Run HELIANO as an optional step to detect Helitrons (yes/no, Default: no)
		-h == Show help

	Example Usage:

	earlGreyAnnotationOnly -g bombyxMori.fasta -s bombyxMori -o /home/toby/bombyxMori/repeatAnnotation/ -l bombyx-families.fa.strained -t 16

	Queries can be sent to:
	tobias.baril[at]unine.ch

	Please make use of the GitHub Issues and Discussion Tabs at: https://github.com/TobyBaril/EarlGrey
	#############################
```

