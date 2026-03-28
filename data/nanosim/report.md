# nanosim CWL Generation Report

## nanosim_read_analysis.py

### Tool Description
Read characterization step
Given raw ONT reads, reference genome, metagenome, and/or
transcriptome, learn read features and output error profiles

### Metadata
- **Docker Image**: quay.io/biocontainers/nanosim:3.2.3--hdfd78af_0
- **Homepage**: https://github.com/bcgsc/NanoSim
- **Package**: https://anaconda.org/channels/bioconda/packages/nanosim/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/nanosim/overview
- **Total Downloads**: 59.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bcgsc/NanoSim
- **Stars**: N/A
### Original Help Text
```text
/usr/local/bin/besthit_to_histogram.py:46: SyntaxWarning: invalid escape sequence '\*'
  for item in re.findall('(:[0-9]+|\*[a-z][a-z]|[=\+\-][A-Za-z]+)', cs_string):
/usr/local/bin/besthit_to_histogram.py:84: SyntaxWarning: invalid escape sequence '\d'
  cigar = re.findall('(\d+)([MIDSHX=])', cigar_str)  # Don't find (\d+)N since those are introns
/usr/local/bin/model_base_qualities.py:25: SyntaxWarning: invalid escape sequence '\*'
  for item in re.findall('(:[0-9]+|\*[a-z][a-z]|[=\+\-][A-Za-z]+)', cs_string):
usage: read_analysis.py [-h] [-v]
                        {genome,transcriptome,metagenome,quantify,detect_ir}
                        ...

Read characterization step
-----------------------------------------------------------
Given raw ONT reads, reference genome, metagenome, and/or 
transcriptome, learn read features and output error profiles

options:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit

subcommands:
  
  There are five modes in read_analysis.
  For detailed usage of each mode:
      read_analysis.py mode -h
  -------------------------------------------------------

  {genome,transcriptome,metagenome,quantify,detect_ir}
    genome              Run the simulator on genome mode
    transcriptome       Run the simulator on transcriptome mode
    metagenome          Run the simulator on metagenome mode
    quantify            Quantify transcriptome expression or metagenome
                        abundance
    detect_ir           Detect Intron Retention events using the alignment
                        file
```


## nanosim_simulator.py

### Tool Description
Given error profiles, reference genome, metagenome,
and/or transcriptome, simulate ONT DNA or RNA reads

### Metadata
- **Docker Image**: quay.io/biocontainers/nanosim:3.2.3--hdfd78af_0
- **Homepage**: https://github.com/bcgsc/NanoSim
- **Package**: https://anaconda.org/channels/bioconda/packages/nanosim/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/simulator.py:511: SyntaxWarning: invalid escape sequence '\d'
  hp_mis_rate = float(re.search("\d+\.?\d*", next(homopolymer_length_params))[0])
/usr/local/bin/model_base_qualities.py:25: SyntaxWarning: invalid escape sequence '\*'
  for item in re.findall('(:[0-9]+|\*[a-z][a-z]|[=\+\-][A-Za-z]+)', cs_string):
usage: simulator.py [-h] [-v] {genome,transcriptome,metagenome} ...

Simulation step
-----------------------------------------------------------
Given error profiles, reference genome, metagenome,
and/or transcriptome, simulate ONT DNA or RNA reads

options:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit

subcommands:
  
  There are two modes in read_analysis.
  For detailed usage of each mode:
      simulator.py mode -h
  -------------------------------------------------------

  {genome,transcriptome,metagenome}
                        You may run the simulator on genome, transcriptome, or
                        metagenome mode.
    genome              Run the simulator on genome mode
    transcriptome       Run the simulator on transcriptome mode
    metagenome          Run the simulator on metagenome mode
```


## Metadata
- **Skill**: generated
