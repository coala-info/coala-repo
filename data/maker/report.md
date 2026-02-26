# maker CWL Generation Report

## maker

### Tool Description
MAKER is a program that produces gene annotations in GFF3 format using evidence such as EST alignments and protein homology. MAKER can be used to produce gene annotations for new genomes as well as update annotations from existing genome databases.

### Metadata
- **Docker Image**: quay.io/biocontainers/maker:3.01.04--pl5321h7b50bb2_0
- **Homepage**: http://www.yandell-lab.org/software/maker.html
- **Package**: https://anaconda.org/channels/bioconda/packages/maker/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/maker/overview
- **Total Downloads**: 98.2K
- **Last updated**: 2025-07-28
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
MAKER version 3.01.04

Usage:

     maker [options] <maker_opts> <maker_bopts> <maker_exe>


Description:

     MAKER is a program that produces gene annotations in GFF3 format using
     evidence such as EST alignments and protein homology. MAKER can be used to
     produce gene annotations for new genomes as well as update annotations
     from existing genome databases.

     The three input arguments are control files that specify how MAKER should
     behave. All options for MAKER should be set in the control files, but a
     few can also be set on the command line. Command line options provide a
     convenient machanism to override commonly altered control file values.
     MAKER will automatically search for the control files in the current
     working directory if they are not specified on the command line.

     Input files listed in the control options files must be in fasta format
     unless otherwise specified. Please see MAKER documentation to learn more
     about control file  configuration.  MAKER will automatically try and
     locate the user control files in the current working directory if these
     arguments are not supplied when initializing MAKER.

     It is important to note that MAKER does not try and recalculated data that
     it has already calculated.  For example, if you run an analysis twice on
     the same dataset you will notice that MAKER does not rerun any of the
     BLAST analyses, but instead uses the blast analyses stored from the
     previous run. To force MAKER to rerun all analyses, use the -f flag.

     MAKER also supports parallelization via MPI on computer clusters. Just
     launch MAKER via mpiexec (i.e. mpiexec -n 40 maker). MPI support must be
     configured during the MAKER installation process for this to work though
     

Options:

     -genome|g <file>    Overrides the genome file path in the control files

     -RM_off|R           Turns all repeat masking options off.

     -datastore/         Forcably turn on/off MAKER's two deep directory
      nodatastore        structure for output.  Always on by default.

     -old_struct         Use the old directory styles (MAKER 2.26 and lower)

     -base    <string>   Set the base name MAKER uses to save output files.
                         MAKER uses the input genome file name by default.

     -tries|t <integer>  Run contigs up to the specified number of tries.

     -cpus|c  <integer>  Tells how many cpus to use for BLAST analysis.
                         Note: this is for BLAST and not for MPI!

     -force|f            Forces MAKER to delete old files before running again.
			 This will require all blast analyses to be rerun.

     -again|a            recaculate all annotations and output files even if no
			 settings have changed. Does not delete old analyses.

     -quiet|q            Regular quiet. Only a handlful of status messages.

     -qq                 Even more quiet. There are no status messages.

     -dsindex            Quickly generate datastore index file. Note that this
                         will not check if run settings have changed on contigs

     -nolock             Turn off file locks. May be usful on some file systems,
                         but can cause race conditions if running in parallel.

     -TMP                Specify temporary directory to use.

     -CTL                Generate empty control files in the current directory.

     -OPTS               Generates just the maker_opts.ctl file.

     -BOPTS              Generates just the maker_bopts.ctl file.

     -EXE                Generates just the maker_exe.ctl file.

     -MWAS    <option>   Easy way to control mwas_server for web-based GUI

                              options:  STOP
                                        START
                                        RESTART

     -version            Prints the MAKER version.

     -help|?             Prints this usage statement.
```

