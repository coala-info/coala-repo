# plek CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| plek | Failed | tool bug: PLEK.py ends with sys.exit(1) after a correct run (predictions are right: 8 of 10 test transcripts, lncRNA HOTAIR and XIST called non-coding), so cwltool reports failure; fixed wrong flags |
| plek_PLEKModelling.py | PASS | NCBI RefSeq human mRNA (330) and non-coding RNA (330) transcripts; model and range files written and load in PLEK.py; new CWL for PLEKModelling.py |

## plek

### Tool Description
Predictor of Long non-coding RNAs and messenger RNAs based on K-mer scheme

### Metadata
- **Docker Image**: quay.io/biocontainers/plek:1.2--py310h8ea774a_10
- **Homepage**: https://sourceforge.net/projects/plek
- **Package**: https://anaconda.org/channels/bioconda/packages/plek/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/plek/overview
- **Total Downloads**: 18.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/plek:1.2--py310h8ea774a_10 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:069e4406073bea3fbaf53a17d344aea688faa0be34b0d5f4805550828b637a8f: unpack entry: usr/local/bin/PLEK.model: unpack to regular file: short write: write /tmp/build-temp-3868314617/rootfs/usr/local/bin/PLEK.model: no space left on device
```

## plek_PLEKModelling.py

### Tool Description
Build your own PLEK classifier with training data (mRNA and lncRNA transcripts).

### Metadata
- **Docker Image**: quay.io/biocontainers/plek:1.2--py310h8ea774a_10
- **Homepage**: https://sourceforge.net/projects/plek
- **Package**: https://anaconda.org/channels/bioconda/packages/plek/overview
- **Validation**: PASS

### Original Help Text
```text
=====================
  USAGE AND EXAMPLES
=====================
Usage of PLEK Modelling -- used to build your own classifier with your 
                           training data (mRNA/lncRNA transcripts):
 
python PLEKModelling.py -mRNA mRNAs_fasta -lncRNA lncRNAs_fasta 
   -prefix prefix_of_output -log2c range_of_log2c -log2g range_of_log2g 
   -thread number_of_threads -model model_file -range range_file  
   -minlength min_length_of_sequence -isoutmsg 0_or_1 -isrmtempfile 0_or_1
   -k k_mer -nfold n_fold_cross_validation -isbalanced 0_or_1 
   
   -mRNA          mRNA transcripts used to build predictor, in fasta format.
   
   -lncRNA        lncRNA transcripts used to build predictor, in fasta format.
   
   -prefix        Prefix of the output files.
   
   -log2c        (Optional) The specified range of C parameter for the svm parameter 
                  search. Default value: 0,5,1. (from, to, by; 0,1,2,3,4,5)   
				  
   -log2g        (Optional) The specified range of G parameter for the svm parameter 
                  search. Default value: 0,-5,-1.(from, to, by; 0,-1,-2,-3,-4,-5) 
				  
   -thread       (Optional) The number of threads for running the PLEKModelling 
                  program. The bigger this number is, the faster PLEKModelling runs.
                  Note that a larger thread number means larger consumption of memory.
                  Default value: 12.
				  
   -model        (Optional) The name of a predictor model file (an output file
                  by PLEKModelling.py).   
				  
   -range        (Optional) The name of a svm range file (an output file by 
                  PLEKModelling.py).   
				  
   -minlength    (Optional) The minimum length of sequences. The sequences whose 
                  lengths are more than minlength will be processed. Default 
                  value: 200.             
				  
   -isoutmsg     (Optional) Output messages to stdout(screen) or not. "0" means 
                 that PLEKModelling be run quietly. "1" means that PLEKModelling 
                 outputs the details of processing. Default value: 0.   
				 
   -isrmtempfile (Optional) Remove temporary files or not. "0" means that PLEKModelling 
                  retains temporary files. "1" means that PLEKModelling remove temporary 
                  files. Default value: 1.
				  
   -k            (Optional) range of k. k=5 means that we will calculate usage of 
                 1364 k-mer patterns. (k=1, 4 patterns; k=2, 16; k=3, 64; k=4, 256; 
                 k=5, 1024; 1364=4+64+256+1024). Default value: 5. 
				 
   -nfold        (Optional) n-fold cross-validation in search for optimal parameters.
                 Default value: 10.   
   
   -isbalanced   (Optional) In the case of isbalanced=1, if the samples are 
                 unbalanced, it will subsample the overrepresented class to obtain an 
                 equal amount of positives and negatives.
                 Default value: 0.
           

Examples: 
1. $ python PLEKModelling.py -mRNA PLEK_mRNAs.fa -lncRNA PLEK_lncRNAs.fa -prefix 20140531 

   NOTE: To train a classifier using the mRNA sequences in the 'PLEK_mRNAs.fa' file
   and lncRNA in 'PLEK_lncRNAs.fa'. The program outputs the model in the file 
   '20140531.model' and the svm-scale range in '20140531.range'. 
   We can use the new model as follows:
    python PLEK.py -fasta PLEK_test.fa -out 20140531.predicted -thread 10  \
    -range 20140531.range -model 20140531.model 
	
2. $ python PLEKModelling.py -mRNA PLEK_mRNAs.fa -lncRNA PLEK_lncRNAs.fa -prefix 20140601 \
     -log2c 1,3,1 -log2g -1,-3,-1 -nfold 2 -k 4      

   NOTE: This example is used to demonstrate the usage of PLEKModelling.py
   in a simple/quick way. User can run this to check if our program can run correctly.
   To train a classifier using the mRNA sequences in the 'PLEK_mRNAs.fa' file
   and lncRNA in 'PLEK_lncRNAs.fa'. The range of log2c is 1,2,3. The range of log2g
   is -1,-2,-3. Use a 2-fold cross-validation. K is 4, it will calculate the usage
   of 340 patterns (4+16+63+256=340). The program outputs the model in the file 
   '20140601.model' and the svm-scale range in '20140601.range'. 
   We can use the new model as follows:
    python PLEK.py -fasta PLEK_test.fa -out 20140601.predicted -thread 10  \
    -range 20140601.range -model 20140601.model -k 4

Notes:
   (1) In general, it is time-consuming to build a new classifier.          
   (2) The accuracy of a classifier model is connected with the quality and 
   quantity of training samples. We encourage users to supply as many reliable 
   samples as possible to PLEKModelling.py to train a classifier. We suggest
   that transcripts annotated with 'pseudogene', 'predicted' and 'putative' 
   be removed before training models. 
   (3) To parallel run PLEKModelling.py in PBS, please see 
   PLEK_howto_generate_scripts.pdf   
   
   
=====================
  CONTACTS
=====================
Aimin Li: LiAiminMail@gmail.com
Junying Zhang: jyzhang@mail.xidian.edu.cn     

======================
  WEBSITE
=====================
https://sourceforge.net/projects/plek/
```

## Metadata
- **Skill**: generated

