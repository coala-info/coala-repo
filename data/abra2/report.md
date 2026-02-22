# abra2 CWL Generation Report

## abra2

### Tool Description
ABRA2 is a realigner for next generation sequencing data. It uses localized assembly and genetic algorithms to improve the accuracy of indel detection.

### Metadata
- **Docker Image**: quay.io/biocontainers/abra2:2.24--hdcf5f25_3
- **Homepage**: https://github.com/mozack/abra2
- **Package**: https://anaconda.org/channels/bioconda/packages/abra2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/abra2/overview
- **Total Downloads**: 20.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mozack/abra2
- **Stars**: 95
### Original Help Text
```text
Picked up JAVA_TOOL_OPTIONS: -Xmx4G
INFO	Sun Feb 22 05:17:21 GMT 2026	Abra version: 2.24
INFO	Sun Feb 22 05:17:21 GMT 2026	Abra params: [/usr/local/share/abra2-2.24-3/abra2.jar -help]
'h' is not a recognized option
Option                                  Description                            
------                                  -----------                            
--amq <Integer>                         Set mapq for alignments that map       
                                          equally well to reference and an     
                                          ABRA generated contig.  default of   
                                          -1 disables (default: -1)            
--ca                                    Contig anchor [M_bases_at_contig_edge, 
                                          max_mismatches_near_edge] (default:  
                                          10,2)                                
--cl <Integer>                          Compression level of output bam file   
                                          (s) (default: 5)                     
--cons                                  Use positional consensus sequence when 
                                          aligning high quality soft clipping  
--contigs                               Optional file to which assembled       
                                          contigs are written                  
--dist <Integer>                        Max read move distance (default: 1000) 
--gc                                    If specified, only reprocess regions   
                                          that contain at least one contig     
                                          containing an indel or splice        
                                          (experimental)                       
--gkl                                   If specified, use the GKL Intel        
                                          Deflater.                            
--gtf                                   GTF file defining exons and transcripts
--in                                    Required list of input sam or bam file 
                                          (s) separated by comma               
--in-vcf                                VCF containing known (or suspected)    
                                          variant sites.  Very large files     
                                          should be avoided.                   
--index                                 Enable BAM index generation when       
                                          outputting sorted alignments (may    
                                          require additonal memory)            
--junctions                             Splice junctions definition file       
--keep-tmp                              Do not delete the temporary directory  
--kmer                                  Optional assembly kmer size(delimit    
                                          with commas if multiple sizes        
                                          specified)                           
--log                                   Logging level (trace,debug,info,warn,  
                                          error) (default: info)               
--mac <Integer>                         Max assembled contigs (default: 64)    
--mad <Integer>                         Regions with average depth exceeding   
                                          this value will be downsampled       
                                          (default: 1000)                      
--mapq [Integer]                        Minimum mapping quality for a read to  
                                          be used in assembly and be eligible  
                                          for realignment (default: 20)        
--maxn [Integer]                        Maximum pre-pruned nodes in regional   
                                          assembly (default: 150000)           
--mbq [Integer]                         Minimum base quality for inclusion in  
                                          assembly.  This value is compared    
                                          against the sum of base qualities    
                                          per kmer position (default: 20)      
--mcl [Integer]                         Assembly minimum contig length         
                                          (default: -1)                        
--mcr <Integer>                         Max number of cached reads per sample  
                                          per thread (default: 1000000)        
--mer <Double>                          Min edge pruning ratio.  Default value 
                                          is appropriate for relatively        
                                          sensitive somatic cases.  May be     
                                          increased for improved speed in      
                                          germline only cases. (default: 0.01) 
--mmr <Double>                          Max allowed mismatch rate when mapping 
                                          reads back to contigs (default: 0.05)
--mnf <Integer>                         Assembly minimum node frequency        
                                          (default: 1)                         
--mrn <Double>                          Reads with noise score exceeding this  
                                          value are not remapped.              
                                          numMismatches+(numIndels*2) <        
                                          readLength*mnr (default: 0.1)        
--mrr <Integer>                         Regions containing more reads than     
                                          this value are not processed.  Use   
                                          -1 to disable. (default: 1000000)    
--msr <Integer>                         Max reads to keep in memory per sample 
                                          during the sort phase.  When this    
                                          value is exceeded, sort spills to    
                                          disk (default: 1000000)              
--no-edge-ci                            If specified, do not update alignments 
                                          for reads that have a complex indel  
                                          at the read edge.  i.e. Do not allow 
                                          alignments like: 90M10D10I           
--no-ndn                                If specified, do not allow adjacent N- 
                                          D-N cigar elements                   
--nosort                                Do not attempt to sort final output    
--out                                   Required list of output sam or bam file
                                          (s) separated by comma               
--rcf <Double>                          Minimum read candidate fraction for    
                                          triggering assembly (default: 0.01)  
--ref                                   Genome reference location              
--sa                                    Skip assembly                          
--sc                                    Soft clip contig args [max_contigs,    
                                          min_base_qual,frac_high_qual_bases,  
                                          min_soft_clip_len] (default:         
                                          16,13,80,15)                         
--sga                                   Scoring used for contig alignments     
                                          (match, mismatch_penalty,            
                                          gap_open_penalty,                    
                                          gap_extend_penalty) (default:        
                                          8,32,48,1)                           
--single                                Input is single end                    
--skip                                  If no target specified, skip           
                                          realignment of chromosomes matching  
                                          specified regex.  Skipped reads are  
                                          output without modification.         
                                          Specify none to disable. (default:   
                                          GL.*|hs37d5|chr.*random|chrUn.       
                                          *|chrEBV|CMV|HBV|HCV.*|HIV.          
                                          *|KSHV|HTLV.*|MCV|SV40|HPV.*)        
--sobs                                  Do not use observed indels in original 
                                          alignments to generate contigs       
--ssc                                   Skip usage of soft clipped sequences   
                                          as putative contigs                  
--sua                                   Do not use unmapped reads anchored by  
                                          mate to trigger assembly.  These     
                                          reads are still eligible to          
                                          contribute to assembly               
--target-kmers                          BED-like file containing target        
                                          regions with per region kmer sizes   
                                          in 4th column                        
--targets                               BED file containing target regions     
--threads <Integer>                     Number of threads (default: 4)         
--tmpdir                                Set the temp directory (overrides java.
                                          io.tmpdir)                           
--ujac                                  If specified, use junction permuations 
                                          as contigs (Experimental - may use   
                                          excessive memory and compute times)  
--undup                                 Unset duplicate flag                   
--ws                                    Processing window size and overlap     
                                          (size,overlap) (default: 400,200)    
Exception in thread "main" joptsimple.UnrecognizedOptionException: 'h' is not a recognized option
	at joptsimple.OptionException.unrecognizedOption(OptionException.java:88)
	at joptsimple.OptionParser.validateOptionCharacters(OptionParser.java:472)
	at joptsimple.OptionParser.handleShortOptionCluster(OptionParser.java:421)
	at joptsimple.OptionParser.handleShortOptionToken(OptionParser.java:416)
	at joptsimple.OptionParserState$2.handleArgument(OptionParserState.java:56)
	at joptsimple.OptionParser.parse(OptionParser.java:379)
	at abra.Options.parseOptions(Options.java:32)
	at abra.ReAligner.run(ReAligner.java:1742)
	at abra.Abra.main(Abra.java:12)
```


## Metadata
- **Skill**: generated
