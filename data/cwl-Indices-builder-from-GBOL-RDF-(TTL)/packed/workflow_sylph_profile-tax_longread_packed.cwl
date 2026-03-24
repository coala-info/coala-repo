{
    "$graph": [
        {
            "class": "CommandLineTool",
            "label": "Concatenate multiple files",
            "baseCommand": [
                "cat"
            ],
            "stdout": "$(inputs.outname)",
            "hints": [
                {
                    "dockerPull": "debian:buster",
                    "class": "DockerRequirement"
                }
            ],
            "inputs": [
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "inputBinding": {
                        "position": 2
                    },
                    "id": "#concatenate.cwl/infiles"
                },
                {
                    "type": "string",
                    "id": "#concatenate.cwl/outname"
                }
            ],
            "id": "#concatenate.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "https://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "https://schema.org/name": "Jasper Koehorst"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateModified": "2024-10-07",
            "https://schema.org/dateCreated": "2021-00-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential",
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.outname)"
                    },
                    "id": "#concatenate.cwl/output"
                }
            ]
        },
        {
            "class": "CommandLineTool",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "label": "Convert an array of 1 file to a file object",
            "doc": "Converts the array and returns the first file in the array. \nShould only be used when 1 file is in the array.\n",
            "inputs": [
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "id": "#array_to_file_tool.cwl/files"
                }
            ],
            "baseCommand": [
                "mv"
            ],
            "arguments": [
                {
                    "valueFrom": "$(inputs.files[0].path)",
                    "position": 1
                },
                {
                    "valueFrom": "./",
                    "position": 2
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.files[0].basename)"
                    },
                    "id": "#array_to_file_tool.cwl/file"
                }
            ],
            "id": "#array_to_file_tool.cwl"
        },
        {
            "class": "ExpressionTool",
            "doc": "Transforms the input files to a mentioned directory\n",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "inputs": [
                {
                    "type": "string",
                    "id": "#files_to_folder.cwl/destination"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "id": "#files_to_folder.cwl/files"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "Directory"
                        }
                    ],
                    "id": "#files_to_folder.cwl/folders"
                }
            ],
            "expression": "${\n  var array = []\n  if (inputs.files != null) {\n    array = array.concat(inputs.files)\n  }\n  if (inputs.folders != null) {\n    array = array.concat(inputs.folders)\n  }\n  var r = {\n     'results':\n       { \"class\": \"Directory\",\n         \"basename\": inputs.destination,\n         \"listing\": array\n       } \n     };\n   return r; \n }\n",
            "outputs": [
                {
                    "type": "Directory",
                    "id": "#files_to_folder.cwl/results"
                }
            ],
            "id": "#files_to_folder.cwl",
            "http://schema.org/citation": "https://m-unlock.nl",
            "http://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "http://schema.org/dateModified": "2024-10-07",
            "http://schema.org/dateCreated": "2020-00-00",
            "http://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "http://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "Fastplong",
            "doc": "Ultrafast preprocessing and quality control for long reads (Nanopore, PacBio, Cyclone, etc.).",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "dockerPull": "quay.io/biocontainers/fastplong:0.3.0--h224cc79_0",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "0.3.0"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/fastplong"
                            ],
                            "package": "fastp"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "arguments": [
                {
                    "prefix": "--out",
                    "valueFrom": "$(inputs.output_filename_prefix)_fastplong.fastq.gz"
                },
                {
                    "prefix": "--html",
                    "valueFrom": "$(inputs.output_filename_prefix)_fastplong-report.html"
                },
                {
                    "prefix": "--json",
                    "valueFrom": "$(inputs.output_filename_prefix)_fastplong-report.json"
                },
                {
                    "${ inputs.failed_out ? \"--failed-out\"": "null }"
                },
                {
                    "${ inputs.failed_out ? inputs.identifier + \"_fastplong_failed.fastq.gz\"": "null }"
                }
            ],
            "baseCommand": [
                "fastplong"
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "inputBinding": {
                        "prefix": "--adapter_fasta"
                    },
                    "label": "Adapter fasta",
                    "doc": "Specify a FASTA file to trim both read by all the sequences in this FASTA file (string [=])",
                    "id": "#fastplong.cwl/adapter_fasta"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 30,
                    "inputBinding": {
                        "prefix": "--complexity_threshold"
                    },
                    "label": "Complexity threshold",
                    "doc": "The threshold for low complexity filter (0~100). Default is 30, which means 30% complexity is required",
                    "id": "#fastplong.cwl/complexity_threshold"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--compression"
                    },
                    "label": "Compression",
                    "doc": "Compression level for gzip output (1 ~ 9). 1 is fastest, 9 is smallest, Default 4",
                    "id": "#fastplong.cwl/compression"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--cut_front"
                    },
                    "label": "Cut front",
                    "doc": "Move a sliding window from front (5') to tail, drop the bases in the window if its mean quality < threshold, stop otherwise. Default false",
                    "id": "#fastplong.cwl/cut_front"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--cut_front_mean_quality"
                    },
                    "label": "Cut_front_mean_quality",
                    "doc": "The mean quality requirement option for cut_front, default to cut_mean_quality if not specified (int [=20])",
                    "id": "#fastplong.cwl/cut_front_mean_quality"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--cut_front_window_size"
                    },
                    "label": "Cut_front_window_size",
                    "doc": "The window size option of cut_front, default to cut_window_size if not specified (int [=4])",
                    "id": "#fastplong.cwl/cut_front_window_size"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--cut_mean_quality"
                    },
                    "label": "Cut mean quality",
                    "doc": "The mean quality requirement option shared by cut_front, cut_tail or cut_sliding. Range: 1~36. Default 20",
                    "id": "#fastplong.cwl/cut_mean_quality"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--cut_tail"
                    },
                    "label": "Cut tail",
                    "doc": "Move a sliding window from tail (3') to front, drop the bases in the window if its mean quality < threshold, stop otherwise Default false.",
                    "id": "#fastplong.cwl/cut_tail"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--cut_tail_mean_quality"
                    },
                    "label": "Cut_tail_mean_quality",
                    "doc": "The mean quality requirement option for cut_tail, default to cut_mean_quality if not specified (int [=20])",
                    "id": "#fastplong.cwl/cut_tail_mean_quality"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--cut_tail_window_size"
                    },
                    "label": "Cut_tail_window_size",
                    "doc": "The window size option of cut_tail, default to cut_window_size if not specified (int [=4])",
                    "id": "#fastplong.cwl/cut_tail_window_size"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--cut_window_size"
                    },
                    "label": "Cut window size",
                    "doc": "The window size option shared by cut_front, cut_tail or cut_sliding. Range: 1~1000. Default 4",
                    "id": "#fastplong.cwl/cut_window_size"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--disable_adapter_trimming"
                    },
                    "label": "Disable adapter trimming",
                    "doc": "Adapter trimming is enabled by default. If this option is specified, adapter trimming is disabled. Default false",
                    "id": "#fastplong.cwl/disable_adapter_trimming"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--disable_length_filtering"
                    },
                    "label": "Disable_length_filtering",
                    "doc": "Length filtering is enabled by default. If this option is specified, length filtering is disabled",
                    "id": "#fastplong.cwl/disable_length_filtering"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--disable_quality_filtering"
                    },
                    "label": "Disable_quality_filtering",
                    "doc": "Quality filtering is enabled by default. If this option is specified, quality filtering is disabled",
                    "id": "#fastplong.cwl/disable_quality_filtering"
                },
                {
                    "type": [
                        "null",
                        "float"
                    ],
                    "inputBinding": {
                        "prefix": "--distance_threshold"
                    },
                    "label": "Distance threshold",
                    "doc": "Threshold of sequence-adapter-distance/adapter-length (0.0 ~ 1.0), greater value means more adapters detected. Default 0.25",
                    "id": "#fastplong.cwl/distance_threshold"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "inputBinding": {
                        "prefix": "--end_adapter"
                    },
                    "label": "End adapter",
                    "doc": "The adapter sequence at read end (3'). Default auto-detect",
                    "id": "#fastplong.cwl/end_adapter"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "label": "failed_out",
                    "inputBinding": {
                        "prefix": "--failed-out"
                    },
                    "doc": "Output failed reads to a separate file. Disabled by default.",
                    "id": "#fastplong.cwl/failed_out"
                },
                {
                    "type": "File",
                    "inputBinding": {
                        "prefix": "--in"
                    },
                    "label": "Input file",
                    "doc": "Read input file name (string [=])",
                    "id": "#fastplong.cwl/input_file"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 0,
                    "inputBinding": {
                        "prefix": "--length_limit"
                    },
                    "label": "Length limit",
                    "doc": "Reads longer than length_limit will be discarded. Default 0 means no limitation",
                    "id": "#fastplong.cwl/length_limit"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 15,
                    "inputBinding": {
                        "prefix": "--length_required"
                    },
                    "label": "Length required",
                    "doc": "Reads shorter than length required will be discarded. Default 15",
                    "id": "#fastplong.cwl/length_required"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--low_complexity_filter"
                    },
                    "label": "Low complexity filter",
                    "doc": "Enable low complexity filter. The complexity is defined as the percentage of base that is different from its next base (base[i] != base[i+1]).",
                    "id": "#fastplong.cwl/low_complexity_filter"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--mean_qual"
                    },
                    "label": "Mean quality",
                    "doc": "If one read's mean_qual quality score <mean_qual, then this read is discarded. Default 0 means no requirement",
                    "id": "#fastplong.cwl/mean_qual"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 5,
                    "inputBinding": {
                        "prefix": "--n_base_limit"
                    },
                    "label": "N_base_limit",
                    "doc": "If one read's number of N base is >n_base_limit, then this read is discarded. Default 5",
                    "id": "#fastplong.cwl/n_base_limit"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "doc": "Name of the output file. .fastq.gz will be appended to the reads. Default \"fastplong_out\"",
                    "label": "Output filename (base)",
                    "default": "fastplong_out",
                    "id": "#fastplong.cwl/output_filename_prefix"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--poly_x_min_len"
                    },
                    "label": "Poly_x_min_len",
                    "doc": "The minimum length to detect polyX in the read tail. Default 10",
                    "id": "#fastplong.cwl/poly_x_min_len"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 8,
                    "inputBinding": {
                        "prefix": "--qualified_quality_phred"
                    },
                    "label": "Qualified_quality_phred",
                    "doc": "The quality value that a base is qualified. Default 8 means phred quality >=Q8 is qualified.",
                    "id": "#fastplong.cwl/qualified_quality_phred"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--reads_to_process"
                    },
                    "label": "Reads_to_process",
                    "doc": "Specify how many reads/pairs to be processed. Default 0 means process all reads. Default 0",
                    "id": "#fastplong.cwl/reads_to_process"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "inputBinding": {
                        "prefix": "--report_title"
                    },
                    "doc": "Should be quoted with ' or \", default is \"fastplong report\" (string [=fastplong report])",
                    "id": "#fastplong.cwl/report_title"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--split"
                    },
                    "label": "Split",
                    "doc": "Split output by limiting total split file number with this option (2~999), a sequential number prefix will be added to output name ( 0001.out.fq, 0002.out.fq...), disabled by default",
                    "id": "#fastplong.cwl/split"
                },
                {
                    "type": [
                        "null",
                        "long"
                    ],
                    "inputBinding": {
                        "prefix": "--split_by_lines"
                    },
                    "label": "Split by lines",
                    "doc": "Split output by limiting lines of each file with this option(>=1000), a sequential number prefix will be added to output name ( 0001.out.fq, 0002.out.fq...), disabled by default",
                    "id": "#fastplong.cwl/split_by_lines"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--split_prefix_digits"
                    },
                    "label": "Split prefix digits",
                    "doc": "The digits for the sequential number padding (1~10), default is 4, so the filename will be padded as 0001.xxx, 0 to disable padding",
                    "id": "#fastplong.cwl/split_prefix_digits"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "inputBinding": {
                        "prefix": "--start_adapter"
                    },
                    "label": "start_adapter",
                    "doc": "The adapter sequence at read start (5'). Default auto-detect",
                    "id": "#fastplong.cwl/start_adapter"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 3,
                    "inputBinding": {
                        "prefix": "--thread"
                    },
                    "label": "Threads",
                    "doc": "Worker thread number. Default 3",
                    "id": "#fastplong.cwl/threads"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--trim_front"
                    },
                    "label": "Trim_front",
                    "doc": "Trimming how many bases in front for read. Default 0",
                    "id": "#fastplong.cwl/trim_front"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--trim_poly_x"
                    },
                    "label": "Trim_poly_x",
                    "doc": "Enable polyX trimming in 3' ends. Default false",
                    "id": "#fastplong.cwl/trim_poly_x"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--trim_tail"
                    },
                    "label": "trim_tail",
                    "doc": "Trimming how many bases in tail for read, Default 0",
                    "id": "#fastplong.cwl/trim_tail"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--trimming_extension"
                    },
                    "label": "Trimming extension",
                    "doc": "When an adapter is detected, extend the trimming to make cleaner trimming, Default 10 means trimming 10 bases more",
                    "id": "#fastplong.cwl/trimming_extension"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 40,
                    "inputBinding": {
                        "prefix": "--unqualified_percent_limit"
                    },
                    "label": "Unqualified_percent_limit",
                    "doc": "How many percents of bases are allowed to be unqualified (0~100). Default 40 means 40%",
                    "id": "#fastplong.cwl/unqualified_percent_limit"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--verbose"
                    },
                    "label": "Verbose",
                    "doc": "Output verbose log information (i.e. when every 1M reads are processed).",
                    "id": "#fastplong.cwl/verbose"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*_fastplong-report.html"
                    },
                    "id": "#fastplong.cwl/html_report"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*_fastplong-report.json"
                    },
                    "id": "#fastplong.cwl/json_report"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*_fastplong.fastq.gz"
                    },
                    "id": "#fastplong.cwl/out_reads"
                }
            ],
            "id": "#fastplong.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateCreated": "2025-07-22",
            "https://schema.org/dateModified": "2025-08-04",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "Hostile",
            "doc": "Read contamination filtering for longread paired end data. \nIt will use minimap2 as it's aligner.\n",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "dockerPull": "quay.io/biocontainers/hostile:2.0.1--pyhdfd78af_0",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "2.0.1"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/hostile"
                            ],
                            "package": "hostile"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "baseCommand": [
                "hostile",
                "clean"
            ],
            "stdout": "$(inputs.output_filename_prefix)_summary.json",
            "arguments": [
                {
                    "prefix": "--aligner",
                    "valueFrom": "minimap2"
                },
                {
                    "prefix": "--out",
                    "valueFrom": "hostile_out"
                }
            ],
            "inputs": [
                {
                    "type": "File",
                    "doc": "Index file",
                    "inputBinding": {
                        "prefix": "--index"
                    },
                    "id": "#hostile_clean_longreads.cwl/index"
                },
                {
                    "type": "boolean",
                    "doc": "Keep only reads aligning to the index (and their mates if applicable) (default false)",
                    "label": "Invert",
                    "default": false,
                    "inputBinding": {
                        "prefix": "--invert"
                    },
                    "id": "#hostile_clean_longreads.cwl/invert"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "doc": "Name of the output file. (_1/_2).fq.gz will be appended to the reads. Default \"hostile_clean\"",
                    "label": "Output filename (base)",
                    "default": "hostile_clean",
                    "id": "#hostile_clean_longreads.cwl/output_filename_prefix"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "label": "Reads",
                    "doc": "Long read file",
                    "inputBinding": {
                        "prefix": "--fastq1"
                    },
                    "id": "#hostile_clean_longreads.cwl/reads"
                },
                {
                    "type": "int",
                    "doc": "Number of parallel threads to use. Default 4",
                    "label": "Threads",
                    "default": 4,
                    "inputBinding": {
                        "prefix": "--threads"
                    },
                    "id": "#hostile_clean_longreads.cwl/threads"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "hostile_out/*fastq.gz",
                        "outputEval": "${self[0].basename=inputs.output_filename_prefix+\".fastq.gz\"; return self;}"
                    },
                    "id": "#hostile_clean_longreads.cwl/out_reads"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*.json"
                    },
                    "id": "#hostile_clean_longreads.cwl/summary"
                }
            ],
            "id": "#hostile_clean_longreads.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateModified": "2025-07-25",
            "https://schema.org/dateCreated": "2025-07-25",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "NanoPlot",
            "doc": "Plotting suite for long read sequencing data and alignments\n\nModified from:\n  https://github.com/common-workflow-library/bio-cwl-tools/blob/release/nanoplot/nanoplot.cwl\n",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                },
                {
                    "networkAccess": true,
                    "class": "NetworkAccess"
                }
            ],
            "hints": [
                {
                    "dockerPull": "quay.io/biocontainers/nanoplot:1.43.0--pyhdfd78af_1",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "specs": [
                                "https://github.com/wdecoster/NanoPlot/releases",
                                "file:///home/bart/git/cwl/tools/nanoplot/doi.org/10.1093/bioinformatics/btad311"
                            ],
                            "version": [
                                "1.43.0"
                            ],
                            "package": "NanoPlot"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "baseCommand": "NanoPlot",
            "inputs": [
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--alength"
                    },
                    "id": "#nanoplot.cwl/aligned_length"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "format": "http://edamontology.org/format_2572",
                    "inputBinding": {
                        "prefix": "--bam"
                    },
                    "id": "#nanoplot.cwl/bam_files"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--barcoded"
                    },
                    "id": "#nanoplot.cwl/barcoded"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "inputBinding": {
                        "prefix": "--color"
                    },
                    "id": "#nanoplot.cwl/color"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "inputBinding": {
                        "prefix": "--colormap"
                    },
                    "id": "#nanoplot.cwl/colormap"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "format": "http://edamontology.org/format_3462",
                    "inputBinding": {
                        "prefix": "--cram"
                    },
                    "id": "#nanoplot.cwl/cram_files"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--downsample"
                    },
                    "id": "#nanoplot.cwl/downsample"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--dpi"
                    },
                    "id": "#nanoplot.cwl/dpi"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--drop_outliers"
                    },
                    "id": "#nanoplot.cwl/drop_outliers"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "format": "http://edamontology.org/format_1931",
                    "inputBinding": {
                        "prefix": "--fasta"
                    },
                    "id": "#nanoplot.cwl/fasta_files"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "inputBinding": {
                        "prefix": "--fastq"
                    },
                    "id": "#nanoplot.cwl/fastq_files"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "inputBinding": {
                        "prefix": "--prefix"
                    },
                    "default": "",
                    "id": "#nanoplot.cwl/file_prefix"
                },
                {
                    "type": [
                        "null",
                        "float"
                    ],
                    "inputBinding": {
                        "prefix": "--font_scale"
                    },
                    "id": "#nanoplot.cwl/font_scale"
                },
                {
                    "type": [
                        {
                            "type": "enum",
                            "symbols": [
                                "#nanoplot.cwl/format/eps",
                                "#nanoplot.cwl/format/jpeg",
                                "#nanoplot.cwl/format/jpg",
                                "#nanoplot.cwl/format/pdf",
                                "#nanoplot.cwl/format/pgf",
                                "#nanoplot.cwl/format/png",
                                "#nanoplot.cwl/format/ps",
                                "#nanoplot.cwl/format/raw",
                                "#nanoplot.cwl/format/rgba",
                                "#nanoplot.cwl/format/svg",
                                "#nanoplot.cwl/format/svgz",
                                "#nanoplot.cwl/format/tif",
                                "#nanoplot.cwl/format/tiff"
                            ]
                        },
                        "null"
                    ],
                    "inputBinding": {
                        "prefix": "--format"
                    },
                    "id": "#nanoplot.cwl/format"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--no-N50"
                    },
                    "id": "#nanoplot.cwl/hide_n50"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--hide_stats"
                    },
                    "id": "#nanoplot.cwl/hide_stats"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "doc": "Add NanoPlot run info in the report.",
                    "inputBinding": {
                        "prefix": "--info_in_report"
                    },
                    "id": "#nanoplot.cwl/info_in_report"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--listcolormaps"
                    },
                    "id": "#nanoplot.cwl/listcolormaps"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--listcolors"
                    },
                    "id": "#nanoplot.cwl/listcolors"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--loglength"
                    },
                    "id": "#nanoplot.cwl/log_length"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--maxlength"
                    },
                    "id": "#nanoplot.cwl/max_length"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--minlength"
                    },
                    "id": "#nanoplot.cwl/min_length"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--minqual"
                    },
                    "id": "#nanoplot.cwl/min_quality"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "inputBinding": {
                        "prefix": "--fastq_minimal"
                    },
                    "id": "#nanoplot.cwl/minimal_fastq_files"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--percentqual"
                    },
                    "id": "#nanoplot.cwl/percent_quality"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "inputBinding": {
                        "prefix": "--title"
                    },
                    "id": "#nanoplot.cwl/plot_title"
                },
                {
                    "type": [
                        {
                            "type": "array",
                            "items": {
                                "type": "enum",
                                "symbols": [
                                    "#nanoplot.cwl/plots/kde",
                                    "#nanoplot.cwl/plots/hex",
                                    "#nanoplot.cwl/plots/dot"
                                ]
                            }
                        },
                        "null"
                    ],
                    "inputBinding": {
                        "prefix": "--plots"
                    },
                    "id": "#nanoplot.cwl/plots"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "enum",
                            "symbols": [
                                "#nanoplot.cwl/read_type/1D",
                                "#nanoplot.cwl/read_type/2D",
                                "#nanoplot.cwl/read_type/1D2"
                            ]
                        }
                    ],
                    "inputBinding": {
                        "prefix": "--readtype"
                    },
                    "id": "#nanoplot.cwl/read_type"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "inputBinding": {
                        "prefix": "--fastq_rich"
                    },
                    "id": "#nanoplot.cwl/rich_fastq_files"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--runtime_until"
                    },
                    "id": "#nanoplot.cwl/run_until"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--N50"
                    },
                    "id": "#nanoplot.cwl/show_n50"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "doc": "Store the extracted data in a pickle file for future plotting.",
                    "inputBinding": {
                        "prefix": "--store"
                    },
                    "id": "#nanoplot.cwl/store_pickle"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "doc": "Store the extracted data in tab separated file.",
                    "inputBinding": {
                        "prefix": "--raw"
                    },
                    "id": "#nanoplot.cwl/store_raw"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "inputBinding": {
                        "prefix": "--summary"
                    },
                    "id": "#nanoplot.cwl/summary_files"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--threads"
                    },
                    "id": "#nanoplot.cwl/threads"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "doc": "Output the stats file as a properly formatted TSV.",
                    "inputBinding": {
                        "prefix": "--tsv_stats"
                    },
                    "id": "#nanoplot.cwl/tsv_stats"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "inputBinding": {
                        "prefix": "--ubam"
                    },
                    "id": "#nanoplot.cwl/ubam_files"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--pickle"
                    },
                    "id": "#nanoplot.cwl/use_pickle_file"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--verbose"
                    },
                    "default": true,
                    "id": "#nanoplot.cwl/verbose"
                }
            ],
            "outputs": [
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "outputBinding": {
                        "glob": "$(inputs.file_prefix)ActivePores_Over_Time.*"
                    },
                    "id": "#nanoplot.cwl/ActivePores_Over_Time"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "outputBinding": {
                        "glob": "$(inputs.file_prefix)ActivityMap_ReadsPerChannel.*"
                    },
                    "id": "#nanoplot.cwl/ActivityMap_ReadsPerChannel"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "outputBinding": {
                        "glob": "$(inputs.file_prefix)CumulativeYieldPlot_Gigabases.*"
                    },
                    "id": "#nanoplot.cwl/CumulativeYieldPlot_Gigabases"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "outputBinding": {
                        "glob": "$(inputs.file_prefix)CumulativeYieldPlot_NumberOfReads.*"
                    },
                    "id": "#nanoplot.cwl/CumulativeYieldPlot_NumberOfReads"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "outputBinding": {
                        "glob": "$(inputs.file_prefix)LengthvsQualityScatterPlot_*.*"
                    },
                    "id": "#nanoplot.cwl/LengthvsQualityScatterPlot"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "outputBinding": {
                        "glob": "$(inputs.file_prefix)Non_weightedHistogramReadlength.*"
                    },
                    "id": "#nanoplot.cwl/Non_weightedHistogramReadlength"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "outputBinding": {
                        "glob": "$(inputs.file_prefix)Non_weightedLogTransformed_HistogramReadlength.*"
                    },
                    "id": "#nanoplot.cwl/Non_weightedLogTransformed_HistogramReadlength"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "outputBinding": {
                        "glob": "$(inputs.file_prefix)NumberOfReads_Over_Time.*"
                    },
                    "id": "#nanoplot.cwl/NumberOfReads_Over_Time"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "outputBinding": {
                        "glob": "$(inputs.file_prefix)TimeLengthViolinPlot.*"
                    },
                    "id": "#nanoplot.cwl/TimeLengthViolinPlot"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "outputBinding": {
                        "glob": "$(inputs.file_prefix)TimeQualityViolinPlot.*"
                    },
                    "id": "#nanoplot.cwl/TimeQualityViolinPlot"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "outputBinding": {
                        "glob": "$(inputs.file_prefix)WeightedHistogramReadlength.*"
                    },
                    "id": "#nanoplot.cwl/WeightedHistogramReadlength"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "outputBinding": {
                        "glob": "$(inputs.file_prefix)WeightedLogTransformed_HistogramReadlength.*"
                    },
                    "id": "#nanoplot.cwl/WeightedLogTransformed_HistogramReadlength"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "outputBinding": {
                        "glob": "$(inputs.file_prefix)Yield_By_Length.*"
                    },
                    "id": "#nanoplot.cwl/Yield_By_Length"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "outputBinding": {
                        "glob": "*.log"
                    },
                    "id": "#nanoplot.cwl/log"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "$(inputs.file_prefix)NanoPlot_*.log"
                    },
                    "id": "#nanoplot.cwl/logfile"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "$(inputs.file_prefix)NanoStats.txt"
                    },
                    "id": "#nanoplot.cwl/nanostats"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "$(inputs.file_prefix)NanoPlot-data.pickle"
                    },
                    "id": "#nanoplot.cwl/pickle"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "$(inputs.file_prefix)NanoPlot-data.tsv.gz"
                    },
                    "id": "#nanoplot.cwl/raw_data"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "$(inputs.file_prefix)NanoPlot-report.html"
                    },
                    "id": "#nanoplot.cwl/report"
                }
            ],
            "id": "#nanoplot.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0002-2703-8936",
                    "https://schema.org/name": "Miguel Boland"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "https://schema.org/name": "Michael R. Crusoe"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateCreated": "2020-04-04",
            "https://schema.org/dateModified": "2023-04-03",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "sylph",
            "doc": "sylph is a program that performs ultrafast (1) ANI querying or (2) metagenomic profiling for metagenomic shotgun samples.",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "dockerPull": "quay.io/biocontainers/sylph:0.8.1--ha6fb395_0",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "0.8.1"
                            ],
                            "specs": [
                                "https://identifiers.org/RRID:SCR_026478",
                                "https://anaconda.org/bioconda/sylph",
                                "https://doi.org/10.1038/s41587-024-02412-y"
                            ],
                            "package": "sylph"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "baseCommand": [
                "sylph",
                "profile"
            ],
            "arguments": [
                {
                    "prefix": "--output-file",
                    "valueFrom": "$(inputs.output_filename_prefix+\".\"+inputs.database.basename.replace(/\\.syldb$/, '')+\".sylph-profile.tsv\")"
                }
            ],
            "inputs": [
                {
                    "type": "File",
                    "doc": "Sylph database",
                    "label": "Database",
                    "inputBinding": {
                        "position": 0
                    },
                    "id": "#sylph_profile.cwl/database"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "doc": "Estimate true coverage and scale sequence abundance in `profile` by estimated unknown sequence percentage",
                    "label": "Estimate unknown",
                    "inputBinding": {
                        "prefix": "--estimate-unknown",
                        "position": 14
                    },
                    "id": "#sylph_profile.cwl/estimate_unknown"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "The file containing the forward reads. (fastx/gzip)",
                    "label": "Forward reads",
                    "inputBinding": {
                        "prefix": "--first-pairs",
                        "position": 11
                    },
                    "id": "#sylph_profile.cwl/forward_reads"
                },
                {
                    "type": "string",
                    "doc": "Name of the output file. (_sylph-profile.tsv will be appended)",
                    "label": "Output filename (base)",
                    "id": "#sylph_profile.cwl/output_filename_prefix"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "The file containing the reverse reads. (fastx/gzip)",
                    "label": "Reverse reads",
                    "inputBinding": {
                        "prefix": "--second-pairs",
                        "position": 12
                    },
                    "id": "#sylph_profile.cwl/reverse_reads"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "Single end reads, for example long reads. (fastx/gzip)",
                    "label": "Single end reads",
                    "inputBinding": {
                        "position": 1
                    },
                    "id": "#sylph_profile.cwl/single_end_reads"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "doc": "Maximum threads to use. Default 3",
                    "label": "Threads",
                    "default": 3,
                    "inputBinding": {
                        "prefix": "-t",
                        "position": 10
                    },
                    "id": "#sylph_profile.cwl/threads"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*.tsv"
                    },
                    "id": "#sylph_profile.cwl/sylph_profile"
                }
            ],
            "id": "#sylph_profile.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateModified": "2025-02-21",
            "https://schema.org/dateCreated": "2025-02-21",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "sylph-tax",
            "doc": "Sylph is an efficient and accurate metagenome profiler. \nHowever, its output does not have taxonomic information. \nsylph-tax can turn sylph's TSV output into a taxonomic profile like Kraken or MetaPhlAn. \nsylph-tax does this by using custom taxonomy files to annotate sylph's output.\n\nCurrently only works with a single sylph input tsv and 1 taxonomy metadata file.\n",
            "hints": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/sylph_sylph-tax:0.8.1_1.5.1",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "1.5.1"
                            ],
                            "specs": [
                                "file:///home/bart/git/cwl/tools/sylph/identifiers.org/RRID:SCR_026478",
                                "https://anaconda.org/bioconda/sylph-tax",
                                "https://doi.org/10.1038/s41587-024-02412-y"
                            ],
                            "package": "sylph-tax"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "baseCommand": [
                "sylph-tax",
                "taxprof"
            ],
            "arguments": [
                {
                    "prefix": "--taxonomy-metadata",
                    "position": 99,
                    "shellQuote": false,
                    "valueFrom": "${\n  if (inputs.taxonomy_metadata.taxonomy_metadata_file){\n    return inputs.taxonomy_metadata.taxonomy_metadata_file.path\n  } else {\n    return inputs.taxonomy_metadata.builtin_taxonomy_metadata\n  }\n}\n"
                }
            ],
            "inputs": [
                {
                    "type": "boolean",
                    "doc": "Add additional column(s) by integrating viral-host information available (currently available for IMGVR4.1). Default false",
                    "label": "Annotate virus hosts",
                    "default": false,
                    "inputBinding": {
                        "prefix": "--annotate-virus-hosts",
                        "position": 99
                    },
                    "id": "#sylph_tax.cwl/annotate_virus_hosts"
                },
                {
                    "type": "string",
                    "doc": "Name of the output file. If present builtin_taxonomy will appended i.e. GTDB_R220.sylphmpa Otherwise only .sylphmpa",
                    "label": "Output filename (base)",
                    "id": "#sylph_tax.cwl/output_filename_prefix"
                },
                {
                    "type": "boolean",
                    "doc": "Output in Pavian compatible format. Default false",
                    "label": "Pavian format",
                    "default": false,
                    "inputBinding": {
                        "prefix": "--pavian",
                        "position": 99
                    },
                    "id": "#sylph_tax.cwl/pavian_format"
                },
                {
                    "type": "File",
                    "doc": "Sylph profile coming from the 'sylph profile' tool function",
                    "label": "Sylph profile",
                    "inputBinding": {
                        "position": 0
                    },
                    "id": "#sylph_tax.cwl/sylph_profile"
                },
                {
                    "type": [
                        {
                            "type": "record",
                            "name": "#sylph_tax.cwl/taxonomy_metadata/builtin_taxonomy_metadata",
                            "fields": [
                                {
                                    "type": [
                                        {
                                            "type": "enum",
                                            "symbols": [
                                                "#sylph_tax.cwl/taxonomy_metadata/builtin_taxonomy_metadata/builtin_taxonomy_metadata/GTDB_r214",
                                                "#sylph_tax.cwl/taxonomy_metadata/builtin_taxonomy_metadata/builtin_taxonomy_metadata/GTDB_r220",
                                                "#sylph_tax.cwl/taxonomy_metadata/builtin_taxonomy_metadata/builtin_taxonomy_metadata/GTDB_r226",
                                                "#sylph_tax.cwl/taxonomy_metadata/builtin_taxonomy_metadata/builtin_taxonomy_metadata/IMGVR_4.1",
                                                "#sylph_tax.cwl/taxonomy_metadata/builtin_taxonomy_metadata/builtin_taxonomy_metadata/SoilSMAG",
                                                "#sylph_tax.cwl/taxonomy_metadata/builtin_taxonomy_metadata/builtin_taxonomy_metadata/OceanDNA",
                                                "#sylph_tax.cwl/taxonomy_metadata/builtin_taxonomy_metadata/builtin_taxonomy_metadata/TaraEukaryoticSMAG",
                                                "#sylph_tax.cwl/taxonomy_metadata/builtin_taxonomy_metadata/builtin_taxonomy_metadata/FungiRefSeq-2024-07-25"
                                            ]
                                        }
                                    ],
                                    "doc": "Provided taxonomy metadata from default sylph databases. (only available when running with the container image)",
                                    "label": "Taxonomy metadata",
                                    "name": "#sylph_tax.cwl/taxonomy_metadata/builtin_taxonomy_metadata/builtin_taxonomy_metadata"
                                }
                            ]
                        },
                        {
                            "type": "record",
                            "name": "#sylph_tax.cwl/taxonomy_metadata/taxonomy_metadata_file",
                            "fields": [
                                {
                                    "type": "File",
                                    "doc": "Taxonomy metadata file(s) that are not incorporated in the docker image.",
                                    "label": "Taxonomy metadata file",
                                    "name": "#sylph_tax.cwl/taxonomy_metadata/taxonomy_metadata_file/taxonomy_metadata_file"
                                }
                            ]
                        }
                    ],
                    "id": "#sylph_tax.cwl/taxonomy_metadata"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$('*.sylphmpa')",
                        "outputEval": "${ \n   // rename default output name and include builtin taxonomy name when used to the outputname\n   if (inputs.taxonomy_metadata.builtin_taxonomy_metadata){\n    self[0].basename=inputs.output_filename_prefix+\".\"+(inputs.taxonomy_metadata.builtin_taxonomy_metadata+\".sylphmpa\").toLowerCase(); return self; \n   } else {\n    self[0].basename=inputs.output_filename_prefix+\".sylphmpa\"; return self;\n   }           \n  }\n"
                    },
                    "id": "#sylph_tax.cwl/sylph_tax"
                }
            ],
            "id": "#sylph_tax.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateCreated": "2025-02-21",
            "https://schema.org/dateModified": "2025-08-06",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "Workflow",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                },
                {
                    "class": "MultipleInputFeatureRequirement"
                },
                {
                    "class": "ScatterFeatureRequirement"
                },
                {
                    "class": "StepInputExpressionRequirement"
                },
                {
                    "class": "SubworkflowFeatureRequirement"
                }
            ],
            "label": "Long Read Quality Control and Filtering",
            "doc": "**Workflow for long read quality control and contamination filtering.**\n- NanoPlot before and after filtering (read quality control)\n- Filtlong filter on quality and length\n- minimap2 read filtering based on given references\n\nOther UNLOCK workflows on WorkflowHub: https://workflowhub.eu/projects/16/workflows?view=default<br><br>\n\n**All tool CWL files and other workflows can be found here:**<br>\n  Tools: https://gitlab.com/m-unlock/cwl/-/tree/master/cwl <br>\n  Workflows: https://gitlab.com/m-unlock/cwl/-/tree/master/cwl/workflows<br>\n\n**How to setup and use an UNLOCK workflow:**<br>\nhttps://docs.m-unlock.nl/docs/workflows/setup.html<br>\n",
            "outputs": [
                {
                    "type": "File",
                    "label": "Filtered long reads",
                    "doc": "Filtered long reads",
                    "outputSource": "#workflow_longread_quality.cwl/output_filtered_reads/reads_out",
                    "id": "#workflow_longread_quality.cwl/filtered_reads"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "label": "Reports folder",
                    "doc": "Folder with quality plots and filter reports",
                    "outputSource": "#workflow_longread_quality.cwl/reports_files_to_folder/results",
                    "id": "#workflow_longread_quality.cwl/reports_folder"
                }
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "label": "Adapter fasta",
                    "doc": "Specify a FASTA file to trim both read ends by all the sequences in this FASTA file. (Default None)",
                    "id": "#workflow_longread_quality.cwl/adapter_fasta"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "label": "Cut front",
                    "doc": "Move a sliding window from front (5') to tail, drop the bases in the window if its mean quality < threshold, stop otherwise. Default false",
                    "id": "#workflow_longread_quality.cwl/cut_front"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "Cut mean quality",
                    "doc": "The mean quality requirement option shared by cut_front, cut_tail or cut_sliding. Range: 1~36. Default 20",
                    "id": "#workflow_longread_quality.cwl/cut_mean_quality"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "label": "Cut tail",
                    "doc": "Move a sliding window from tail (3') to front, drop the bases in the window if its mean quality < threshold, stop otherwise Default false.",
                    "id": "#workflow_longread_quality.cwl/cut_tail"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 4,
                    "label": "Cut window size",
                    "doc": "The window size option shared by cut_front, cut_tail or cut_sliding. Range: 1~1000. Default 4",
                    "id": "#workflow_longread_quality.cwl/cut_window_size"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "label": "Output Destination",
                    "doc": "Optional output destination only used for cwl-prov reporting.",
                    "id": "#workflow_longread_quality.cwl/destination"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "label": "Disable adapter trimming",
                    "doc": "Adapter trimming is enabled by default. If this option is specified, adapter trimming is disabled. Default false",
                    "id": "#workflow_longread_quality.cwl/disable_adapter_trimming"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "label": "Disable_quality_filtering",
                    "doc": "\"Quality filtering is enabled by default. If this option is specified, quality filtering is disabled. \nDoes not apply to human and reference filtering. (Default false)\"\n",
                    "id": "#workflow_longread_quality.cwl/disable_quality_filtering"
                },
                {
                    "type": "boolean",
                    "label": "Don't output reads.",
                    "doc": "Do not output filtered reads. (default false)",
                    "default": false,
                    "id": "#workflow_longread_quality.cwl/do_not_output_filtered_reads"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "label": "End adapter",
                    "doc": "The adapter sequence at read end (3'). (Default auto-detect)",
                    "id": "#workflow_longread_quality.cwl/end_adapter"
                },
                {
                    "type": "boolean",
                    "doc": "Input fastq is generated by albacore, MinKNOW or guppy  with additional information concerning channel and time. \nUsed to creating more informative quality plots (Default false)\n",
                    "label": "Fastq rich (ONT)",
                    "default": false,
                    "id": "#workflow_longread_quality.cwl/fastq_rich"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "A fasta file or minimap2 indexed filed (.mmi) index needs to be provided. Preindexed is much faster. (Default None)",
                    "label": "Filter human reads",
                    "loadListing": "no_listing",
                    "id": "#workflow_longread_quality.cwl/humandb"
                },
                {
                    "type": "string",
                    "doc": "Identifier for this dataset used in this workflow",
                    "label": "identifier used",
                    "id": "#workflow_longread_quality.cwl/identifier"
                },
                {
                    "type": "boolean",
                    "doc": "Discard unmapped and keep reads mapped to the given reference. Default false (discard mapped)",
                    "label": "Keep mapped reads",
                    "default": false,
                    "id": "#workflow_longread_quality.cwl/keep_reference_mapped_reads"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "Maximum length limit",
                    "doc": "Reads longer than length_limit will be discarded. (Default no limit)",
                    "id": "#workflow_longread_quality.cwl/length_limit"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "doc": "Long read sequence file locally fastq format",
                    "label": "Long reads",
                    "id": "#workflow_longread_quality.cwl/longreads"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "Mean quality",
                    "doc": "if one read's mean_qual quality score < mean_qual, then this read is discarded. (Default 10)",
                    "default": 10,
                    "id": "#workflow_longread_quality.cwl/mean_qual"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 100,
                    "label": "Minimum length required",
                    "doc": "Reads shorter will be discarded. (Default 100)",
                    "id": "#workflow_longread_quality.cwl/minimum_length"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "Poly_x_min_len",
                    "doc": "The minimum length to detect polyX in the read tail. (Default 10 when trim_poly_x is true)",
                    "id": "#workflow_longread_quality.cwl/poly_x_min_len"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "Qualified_quality_phred",
                    "doc": "the quality value that a base is qualified. Default 9 means phred quality >=Q9 is qualified.",
                    "default": 9,
                    "id": "#workflow_longread_quality.cwl/qualified_quality_phred"
                },
                {
                    "type": [
                        {
                            "type": "enum",
                            "symbols": [
                                "#workflow_longread_quality.cwl/readtype/nanopore",
                                "#workflow_longread_quality.cwl/readtype/pacbio"
                            ]
                        }
                    ],
                    "doc": "Type of read PacBio or Nanopore.",
                    "label": "Read type",
                    "id": "#workflow_longread_quality.cwl/readtype"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "A fasta file or minimap2 indexed filed (.mmi) index needs to be provided. Preindexed is much faster. (Default none)",
                    "label": "Filter reference file(s)",
                    "loadListing": "no_listing",
                    "id": "#workflow_longread_quality.cwl/reference_filter_db"
                },
                {
                    "type": "boolean",
                    "doc": "Skip quality plot of filter input data (Default false)",
                    "label": "Skip NanoPlot after",
                    "default": false,
                    "id": "#workflow_longread_quality.cwl/skip_qc_filtered"
                },
                {
                    "type": "boolean",
                    "doc": "Skip quality plot of unfiltered input data (Default false)",
                    "label": "Skip NanoPlot before",
                    "default": false,
                    "id": "#workflow_longread_quality.cwl/skip_qc_unfiltered"
                },
                {
                    "label": "Input URLs used for this run",
                    "doc": "A provenance element to capture the original source of the input data",
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "string"
                        }
                    ],
                    "id": "#workflow_longread_quality.cwl/source"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "label": "start_adapter",
                    "doc": "The adapter sequence at read start (5'). (Default auto-detect)",
                    "id": "#workflow_longread_quality.cwl/start_adapter"
                },
                {
                    "type": "int",
                    "doc": "Number of threads to use for computational processes",
                    "label": "Number of threads",
                    "default": 2,
                    "id": "#workflow_longread_quality.cwl/threads"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "Trim_front",
                    "doc": "Trimming how many bases in front for read. (Default 0)",
                    "id": "#workflow_longread_quality.cwl/trim_front"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "label": "Trim_poly_x",
                    "doc": "Enable polyX trimming in 3' ends. (Default false)",
                    "id": "#workflow_longread_quality.cwl/trim_poly_x"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "trim_tail",
                    "doc": "Trimming how many bases in tail for read, Default 0)",
                    "id": "#workflow_longread_quality.cwl/trim_tail"
                }
            ],
            "steps": [
                {
                    "label": "Human filter",
                    "doc": "Filter human reads from the dataset using Hostile",
                    "when": "$(inputs.index !== null)",
                    "run": "#hostile_clean_longreads.cwl",
                    "in": [
                        {
                            "source": "#workflow_longread_quality.cwl/humandb",
                            "id": "#workflow_longread_quality.cwl/human_filter_longreads/index"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/identifier",
                            "valueFrom": "$(self+\"_\"+inputs.readtype+\"_human_filter\")",
                            "id": "#workflow_longread_quality.cwl/human_filter_longreads/output_filename_prefix"
                        },
                        {
                            "source": [
                                "#workflow_longread_quality.cwl/longread_quality_filter/out_reads",
                                "#workflow_longread_quality.cwl/workflow_merge_reads/merged_reads"
                            ],
                            "pickValue": "first_non_null",
                            "id": "#workflow_longread_quality.cwl/human_filter_longreads/reads"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/readtype",
                            "id": "#workflow_longread_quality.cwl/human_filter_longreads/readtype"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/threads",
                            "id": "#workflow_longread_quality.cwl/human_filter_longreads/threads"
                        }
                    ],
                    "out": [
                        "#workflow_longread_quality.cwl/human_filter_longreads/out_reads",
                        "#workflow_longread_quality.cwl/human_filter_longreads/summary"
                    ],
                    "id": "#workflow_longread_quality.cwl/human_filter_longreads"
                },
                {
                    "label": "Fastplong",
                    "doc": "Filter longreads on quality and length",
                    "run": "#fastplong.cwl",
                    "in": [
                        {
                            "source": "#workflow_longread_quality.cwl/adapter_fasta",
                            "id": "#workflow_longread_quality.cwl/longread_quality_filter/adapter_fasta"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/cut_front",
                            "id": "#workflow_longread_quality.cwl/longread_quality_filter/cut_front"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/cut_mean_quality",
                            "id": "#workflow_longread_quality.cwl/longread_quality_filter/cut_mean_quality"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/cut_tail",
                            "id": "#workflow_longread_quality.cwl/longread_quality_filter/cut_tail"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/cut_window_size",
                            "id": "#workflow_longread_quality.cwl/longread_quality_filter/cut_window_size"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/disable_adapter_trimming",
                            "id": "#workflow_longread_quality.cwl/longread_quality_filter/disable_adapter_trimming"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/disable_quality_filtering",
                            "id": "#workflow_longread_quality.cwl/longread_quality_filter/disable_quality_filtering"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/end_adapter",
                            "id": "#workflow_longread_quality.cwl/longread_quality_filter/end_adapter"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/identifier",
                            "id": "#workflow_longread_quality.cwl/longread_quality_filter/identifier"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/workflow_merge_reads/merged_reads",
                            "id": "#workflow_longread_quality.cwl/longread_quality_filter/input_file"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/length_limit",
                            "id": "#workflow_longread_quality.cwl/longread_quality_filter/length_limit"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/minimum_length",
                            "id": "#workflow_longread_quality.cwl/longread_quality_filter/length_required"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/mean_qual",
                            "id": "#workflow_longread_quality.cwl/longread_quality_filter/mean_qual"
                        },
                        {
                            "valueFrom": "$(inputs.identifier)_$(inputs.readtype)_filtered",
                            "id": "#workflow_longread_quality.cwl/longread_quality_filter/output_filename_prefix"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/poly_x_min_len",
                            "id": "#workflow_longread_quality.cwl/longread_quality_filter/poly_x_min_len"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/qualified_quality_phred",
                            "id": "#workflow_longread_quality.cwl/longread_quality_filter/qualified_quality_phred"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/readtype",
                            "id": "#workflow_longread_quality.cwl/longread_quality_filter/readtype"
                        },
                        {
                            "valueFrom": "$(inputs.identifier)_$(inputs.readtype)_fastplong_report",
                            "id": "#workflow_longread_quality.cwl/longread_quality_filter/report_title"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/start_adapter",
                            "id": "#workflow_longread_quality.cwl/longread_quality_filter/start_adapter"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/threads",
                            "id": "#workflow_longread_quality.cwl/longread_quality_filter/threads"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/trim_front",
                            "id": "#workflow_longread_quality.cwl/longread_quality_filter/trim_front"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/trim_poly_x",
                            "id": "#workflow_longread_quality.cwl/longread_quality_filter/trim_poly_x"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/trim_tail",
                            "id": "#workflow_longread_quality.cwl/longread_quality_filter/trim_tail"
                        }
                    ],
                    "out": [
                        "#workflow_longread_quality.cwl/longread_quality_filter/out_reads",
                        "#workflow_longread_quality.cwl/longread_quality_filter/html_report",
                        "#workflow_longread_quality.cwl/longread_quality_filter/json_report"
                    ],
                    "id": "#workflow_longread_quality.cwl/longread_quality_filter"
                },
                {
                    "label": "Nanoplot filtered folder",
                    "doc": "Nanoplot plots and files to single folder",
                    "when": "$(inputs.skip !== null)",
                    "run": "#files_to_folder.cwl",
                    "in": [
                        {
                            "source": "#workflow_longread_quality.cwl/readtype",
                            "valueFrom": "$(self+\"_nanoplot_filtered\")",
                            "id": "#workflow_longread_quality.cwl/nanoplot_filtered_files_to_folder/destination"
                        },
                        {
                            "source": [
                                "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/log",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/WeightedHistogramReadlength",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/WeightedLogTransformed_HistogramReadlength",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/Non_weightedHistogramReadlength",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/Non_weightedLogTransformed_HistogramReadlength",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/LengthvsQualityScatterPlot",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/Yield_By_Length",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/report",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/logfile",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/nanostats",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/pickle",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/raw_data",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/CumulativeYieldPlot_Gigabases",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/CumulativeYieldPlot_NumberOfReads",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/NumberOfReads_Over_Time",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/ActivePores_Over_Time",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/TimeLengthViolinPlot",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/TimeQualityViolinPlot"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#workflow_longread_quality.cwl/nanoplot_filtered_files_to_folder/files"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/log",
                            "valueFrom": "valueFrom: ${ return inputs.self ? [inputs.self] : null }\n",
                            "id": "#workflow_longread_quality.cwl/nanoplot_filtered_files_to_folder/skip"
                        }
                    ],
                    "out": [
                        "#workflow_longread_quality.cwl/nanoplot_filtered_files_to_folder/results"
                    ],
                    "id": "#workflow_longread_quality.cwl/nanoplot_filtered_files_to_folder"
                },
                {
                    "label": "NanoPlot before",
                    "doc": "NanoPlot Quality assessment and report of reads after filtering",
                    "run": "#nanoplot.cwl",
                    "when": "$(inputs.skip_qc_filtered == false && inputs.fastq_files !== null && inputs.fastq_files.length !== 0)",
                    "in": [
                        {
                            "valueFrom": "${\n  const sources = [\n    inputs.reffilt_reads,\n    inputs.humanfilt_reads,\n    inputs.filt_reads\n  ];\n  const first = sources.find(x => x !== null);\n  if (!first || first.size < 100) {\n    return null;\n  }\n  return [first];\n}\n",
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/fastq_files"
                        },
                        {
                            "valueFrom": "$(inputs.identifier)_$(inputs.readtype)_filtered_",
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/file_prefix"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/longread_quality_filter/out_reads",
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/filt_reads"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/human_filter_longreads/out_reads",
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/humanfilt_reads"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/identifier",
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/identifier"
                        },
                        {
                            "valueFrom": "$(inputs.identifier)_$(inputs.readtype)_filtered",
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/plot_title"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/readtype",
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/readtype"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/reference_filter_longreads/out_reads",
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/reffilt_reads"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/skip_qc_filtered",
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/skip_qc_filtered"
                        },
                        {
                            "default": true,
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/store_pickle"
                        },
                        {
                            "default": true,
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/store_raw"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/threads",
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/threads"
                        }
                    ],
                    "out": [
                        "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/log",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/WeightedHistogramReadlength",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/WeightedLogTransformed_HistogramReadlength",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/Non_weightedHistogramReadlength",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/Non_weightedLogTransformed_HistogramReadlength",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/LengthvsQualityScatterPlot",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/Yield_By_Length",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/report",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/logfile",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/nanostats",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/pickle",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/raw_data",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/CumulativeYieldPlot_Gigabases",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/CumulativeYieldPlot_NumberOfReads",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/NumberOfReads_Over_Time",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/ActivePores_Over_Time",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/TimeLengthViolinPlot",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/TimeQualityViolinPlot"
                    ],
                    "id": "#workflow_longread_quality.cwl/nanoplot_longreads_filtered"
                },
                {
                    "label": "NanoPlot unfiltered",
                    "doc": "NanoPlot Quality assessment and report of reads before filtering",
                    "run": "#nanoplot.cwl",
                    "when": "$(inputs.skip_qc_unfiltered == false)",
                    "in": [
                        {
                            "valueFrom": "${ return !inputs.fastq_rich ? [inputs.longreads] : null; }\n",
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/fastq_files"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/fastq_rich",
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/fastq_rich"
                        },
                        {
                            "valueFrom": "$(inputs.identifier)_$(inputs.readtype)_unfiltered_",
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/file_prefix"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/identifier",
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/identifier"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/workflow_merge_reads/merged_reads",
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/longreads"
                        },
                        {
                            "valueFrom": "$(inputs.identifier)_$(inputs.readtype)_unfiltered",
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/plot_title"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/readtype",
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/readtype"
                        },
                        {
                            "valueFrom": "${ return inputs.fastq_rich ? [inputs.longreads] : null }\n",
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/rich_fastq_files"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/skip_qc_unfiltered",
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/skip_qc_unfiltered"
                        },
                        {
                            "default": true,
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/store_pickle"
                        },
                        {
                            "default": true,
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/store_raw"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/threads",
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/threads"
                        }
                    ],
                    "out": [
                        "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/log",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/WeightedHistogramReadlength",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/WeightedLogTransformed_HistogramReadlength",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/Non_weightedHistogramReadlength",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/Non_weightedLogTransformed_HistogramReadlength",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/LengthvsQualityScatterPlot",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/Yield_By_Length",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/report",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/logfile",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/nanostats",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/pickle",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/raw_data",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/CumulativeYieldPlot_Gigabases",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/CumulativeYieldPlot_NumberOfReads",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/NumberOfReads_Over_Time",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/ActivePores_Over_Time",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/TimeLengthViolinPlot",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/TimeQualityViolinPlot"
                    ],
                    "id": "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered"
                },
                {
                    "label": "Nanoplot unfiltered folder",
                    "doc": "Nanoplot plots and files to single folder",
                    "when": "$(inputs.skip_qc_unfiltered == false)",
                    "in": [
                        {
                            "source": "#workflow_longread_quality.cwl/readtype",
                            "valueFrom": "$(self+\"_nanoplot_unfiltered\")",
                            "id": "#workflow_longread_quality.cwl/nanoplot_unfiltered_files_to_folder/destination"
                        },
                        {
                            "source": [
                                "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/log",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/WeightedHistogramReadlength",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/WeightedLogTransformed_HistogramReadlength",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/Non_weightedHistogramReadlength",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/Non_weightedLogTransformed_HistogramReadlength",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/LengthvsQualityScatterPlot",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/Yield_By_Length",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/report",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/logfile",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/nanostats",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/pickle",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/raw_data",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/CumulativeYieldPlot_Gigabases",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/CumulativeYieldPlot_NumberOfReads",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/NumberOfReads_Over_Time",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/ActivePores_Over_Time",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/TimeLengthViolinPlot",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/TimeQualityViolinPlot"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#workflow_longread_quality.cwl/nanoplot_unfiltered_files_to_folder/files"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/skip_qc_unfiltered",
                            "id": "#workflow_longread_quality.cwl/nanoplot_unfiltered_files_to_folder/skip_qc_unfiltered"
                        }
                    ],
                    "run": "#files_to_folder.cwl",
                    "out": [
                        "#workflow_longread_quality.cwl/nanoplot_unfiltered_files_to_folder/results"
                    ],
                    "id": "#workflow_longread_quality.cwl/nanoplot_unfiltered_files_to_folder"
                },
                {
                    "label": "Output reads",
                    "doc": "Step needed to output filtered reads because there is an option to not to.",
                    "when": "$(!inputs.do_not_output_filtered_reads && inputs.reads_in !== null)",
                    "run": {
                        "class": "ExpressionTool",
                        "requirements": [
                            {
                                "class": "InlineJavascriptRequirement"
                            }
                        ],
                        "inputs": [
                            {
                                "type": [
                                    "null",
                                    "File"
                                ],
                                "id": "#workflow_longread_quality.cwl/output_filtered_reads/run/reads_in"
                            }
                        ],
                        "outputs": [
                            {
                                "type": "File",
                                "id": "#workflow_longread_quality.cwl/output_filtered_reads/run/reads_out"
                            }
                        ],
                        "expression": "${ return {'reads_out': inputs.reads_in}; }\n"
                    },
                    "in": [
                        {
                            "source": "#workflow_longread_quality.cwl/do_not_output_filtered_reads",
                            "id": "#workflow_longread_quality.cwl/output_filtered_reads/do_not_output_filtered_reads"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/longread_quality_filter/out_reads",
                            "id": "#workflow_longread_quality.cwl/output_filtered_reads/filt_reads"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/human_filter_longreads/out_reads",
                            "id": "#workflow_longread_quality.cwl/output_filtered_reads/humanfilt_reads"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/identifier",
                            "id": "#workflow_longread_quality.cwl/output_filtered_reads/identifier"
                        },
                        {
                            "valueFrom": "${\n  const sources = [\n    inputs.reffilt_reads,\n    inputs.humanfilt_reads,\n    inputs.filt_reads\n  ];\n  const firstAvailable = sources.find(x => x !== null);\n  // If the first available read is not null, change output filename.\n  if (firstAvailable) {\n    firstAvailable.basename = inputs.identifier+\"_\"+inputs.readtype+\"_filtered.fastq.gz\";\n  }\n  return firstAvailable || null;\n}\n",
                            "id": "#workflow_longread_quality.cwl/output_filtered_reads/reads_in"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/readtype",
                            "id": "#workflow_longread_quality.cwl/output_filtered_reads/readtype"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/reference_filter_longreads/out_reads",
                            "id": "#workflow_longread_quality.cwl/output_filtered_reads/reffilt_reads"
                        }
                    ],
                    "out": [
                        "#workflow_longread_quality.cwl/output_filtered_reads/reads_out"
                    ],
                    "id": "#workflow_longread_quality.cwl/output_filtered_reads"
                },
                {
                    "label": "Custom reference filter",
                    "doc": "Filter reads using custom references with Hostile",
                    "when": "$(inputs.index !== null)",
                    "run": "#hostile_clean_longreads.cwl",
                    "in": [
                        {
                            "source": "#workflow_longread_quality.cwl/reference_filter_db",
                            "id": "#workflow_longread_quality.cwl/reference_filter_longreads/index"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/keep_reference_mapped_reads",
                            "id": "#workflow_longread_quality.cwl/reference_filter_longreads/invert"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/identifier",
                            "valueFrom": "$(self+\"_\"+inputs.readtype+\"_ref-filter\")",
                            "id": "#workflow_longread_quality.cwl/reference_filter_longreads/output_filename_prefix"
                        },
                        {
                            "source": [
                                "#workflow_longread_quality.cwl/human_filter_longreads/out_reads",
                                "#workflow_longread_quality.cwl/longread_quality_filter/out_reads",
                                "#workflow_longread_quality.cwl/workflow_merge_reads/merged_reads"
                            ],
                            "pickValue": "first_non_null",
                            "id": "#workflow_longread_quality.cwl/reference_filter_longreads/reads"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/readtype",
                            "id": "#workflow_longread_quality.cwl/reference_filter_longreads/readtype"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/threads",
                            "id": "#workflow_longread_quality.cwl/reference_filter_longreads/threads"
                        }
                    ],
                    "out": [
                        "#workflow_longread_quality.cwl/reference_filter_longreads/out_reads",
                        "#workflow_longread_quality.cwl/reference_filter_longreads/summary"
                    ],
                    "id": "#workflow_longread_quality.cwl/reference_filter_longreads"
                },
                {
                    "label": "Reports to folder",
                    "doc": "Preparation of QC output files to a specific output folder",
                    "run": "#files_to_folder.cwl",
                    "in": [
                        {
                            "source": "#workflow_longread_quality.cwl/readtype",
                            "valueFrom": "$(self+\"_quality_filter_reports\")",
                            "id": "#workflow_longread_quality.cwl/reports_files_to_folder/destination"
                        },
                        {
                            "source": [
                                "#workflow_longread_quality.cwl/longread_quality_filter/html_report",
                                "#workflow_longread_quality.cwl/longread_quality_filter/json_report",
                                "#workflow_longread_quality.cwl/human_filter_longreads/summary",
                                "#workflow_longread_quality.cwl/reference_filter_longreads/summary"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#workflow_longread_quality.cwl/reports_files_to_folder/files"
                        },
                        {
                            "source": [
                                "#workflow_longread_quality.cwl/nanoplot_unfiltered_files_to_folder/results",
                                "#workflow_longread_quality.cwl/nanoplot_filtered_files_to_folder/results"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#workflow_longread_quality.cwl/reports_files_to_folder/folders"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/readtype",
                            "id": "#workflow_longread_quality.cwl/reports_files_to_folder/readtype"
                        }
                    ],
                    "out": [
                        "#workflow_longread_quality.cwl/reports_files_to_folder/results"
                    ],
                    "id": "#workflow_longread_quality.cwl/reports_files_to_folder"
                },
                {
                    "label": "Merge paired reads",
                    "doc": "Creates a single file object. Also merges reads if multiple files are given.",
                    "run": "#workflow_merge_se_reads.cwl",
                    "in": [
                        {
                            "source": "#workflow_longread_quality.cwl/identifier",
                            "valueFrom": "$(self)_merged",
                            "id": "#workflow_longread_quality.cwl/workflow_merge_reads/filename"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/longreads",
                            "id": "#workflow_longread_quality.cwl/workflow_merge_reads/reads"
                        }
                    ],
                    "out": [
                        "#workflow_longread_quality.cwl/workflow_merge_reads/merged_reads"
                    ],
                    "id": "#workflow_longread_quality.cwl/workflow_merge_reads"
                }
            ],
            "id": "#workflow_longread_quality.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "https://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "https://schema.org/name": "Jasper Koehorst"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateModified": "2025-08-22",
            "https://schema.org/dateCreated": "2025-04-30",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "Workflow",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                },
                {
                    "class": "MultipleInputFeatureRequirement"
                },
                {
                    "class": "StepInputExpressionRequirement"
                }
            ],
            "label": "Merge multiple SE reads",
            "doc": "Merge (cat) fastq Single End reads (e.g. long reads) when multiple files.\nAlso converts single file array to a non array object.\n\nOutput is as single (non array) file object. \nThis (non array files) is usually required for tool inputs \n",
            "inputs": [
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "doc": "Filename prefix to be used when reads are going to merged. File extensions are preserved.\nThis is only used when multiple reads are given. default \"merged\"\n",
                    "label": "Filename prefix",
                    "default": "merged",
                    "id": "#workflow_merge_se_reads.cwl/filename"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "doc": "Single end reads reads. E.g Nanopore or PacBio. Can be compressed. Do not mix filetypes.",
                    "label": "Singe end reads",
                    "loadListing": "no_listing",
                    "id": "#workflow_merge_se_reads.cwl/reads"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputSource": [
                        "#workflow_merge_se_reads.cwl/fastq_merge_se/output",
                        "#workflow_merge_se_reads.cwl/fastq_se_array_to_file/file"
                    ],
                    "pickValue": "first_non_null",
                    "id": "#workflow_merge_se_reads.cwl/merged_reads"
                }
            ],
            "steps": [
                {
                    "label": "Merge SE reads",
                    "doc": "Merge multiple forward single end reads to a single file",
                    "when": "$(inputs.infiles.length > 1)",
                    "run": "#concatenate.cwl",
                    "in": [
                        {
                            "source": "#workflow_merge_se_reads.cwl/reads",
                            "id": "#workflow_merge_se_reads.cwl/fastq_merge_se/infiles"
                        },
                        {
                            "source": "#workflow_merge_se_reads.cwl/filename",
                            "valueFrom": "${\n  return self+inputs.infiles[0].basename.match(/\\.(fastq|fq)(\\.gz)?$/)[0];\n}\n",
                            "id": "#workflow_merge_se_reads.cwl/fastq_merge_se/outname"
                        }
                    ],
                    "out": [
                        "#workflow_merge_se_reads.cwl/fastq_merge_se/output"
                    ],
                    "id": "#workflow_merge_se_reads.cwl/fastq_merge_se"
                },
                {
                    "label": "SE reads array to file",
                    "doc": "Forward file of single file array to file object",
                    "when": "$(inputs.files.length === 1)",
                    "run": "#array_to_file_tool.cwl",
                    "in": [
                        {
                            "source": "#workflow_merge_se_reads.cwl/reads",
                            "id": "#workflow_merge_se_reads.cwl/fastq_se_array_to_file/files"
                        }
                    ],
                    "out": [
                        "#workflow_merge_se_reads.cwl/fastq_se_array_to_file/file"
                    ],
                    "id": "#workflow_merge_se_reads.cwl/fastq_se_array_to_file"
                }
            ],
            "id": "#workflow_merge_se_reads.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateCreated": "2025-04-30",
            "https://schema.org/dateModified": "2025-04-30",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "Workflow",
            "requirements": [
                {
                    "class": "StepInputExpressionRequirement"
                },
                {
                    "class": "SubworkflowFeatureRequirement"
                },
                {
                    "class": "InlineJavascriptRequirement"
                },
                {
                    "class": "MultipleInputFeatureRequirement"
                }
            ],
            "label": "Sylph profile and sylph-tax",
            "doc": "Taxonomic profiling of long reads using Sylph and convert to taxonomy abundances with sylph-tax. Including quality filtering (optional)",
            "outputs": [
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "Filtered reads output file",
                    "outputSource": "#main/step_output_filtered_reads/reads_out",
                    "id": "#main/filtered_reads"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "doc": "Quality reports output directory",
                    "outputSource": "#main/workflow_longread_quality/reports_folder",
                    "id": "#main/quality_reports"
                },
                {
                    "type": "File",
                    "doc": "Output directory",
                    "outputSource": "#main/sylph_profile_run/sylph_profile",
                    "id": "#main/sylph_profile"
                },
                {
                    "type": "File",
                    "doc": "Output directory",
                    "outputSource": "#main/sylph_tax/sylph_tax",
                    "id": "#main/tax_file"
                }
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "label": "Adapter fasta",
                    "doc": "Specify a FASTA file to trim both read ends by all the sequences in this FASTA file. (Default None)",
                    "id": "#main/adapter_fasta"
                },
                {
                    "type": "boolean",
                    "doc": "Add additional column(s) by integrating viral-host information available (currently available for IMGVR4.1). Default false",
                    "label": "Annotate virus hosts",
                    "default": false,
                    "id": "#main/annotate_virus_hosts"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "label": "Cut front",
                    "doc": "Move a sliding window from front (5') to tail, drop the bases in the window if its mean quality < threshold, stop otherwise. Default false",
                    "id": "#main/cut_front"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "Cut mean quality",
                    "doc": "The mean quality requirement option shared by cut_front, cut_tail or cut_sliding. Range: 1~36. Default 20",
                    "id": "#main/cut_mean_quality"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "label": "Cut tail",
                    "doc": "Move a sliding window from tail (3') to front, drop the bases in the window if its mean quality < threshold, stop otherwise Default false.",
                    "id": "#main/cut_tail"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 4,
                    "label": "Cut window size",
                    "doc": "The window size option shared by cut_front, cut_tail or cut_sliding. Range: 1~1000. Default 4",
                    "id": "#main/cut_window_size"
                },
                {
                    "type": "File",
                    "doc": "Sylph database file",
                    "label": "Database",
                    "id": "#main/database"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "label": "Output Destination",
                    "doc": "Output destination used for cwl-prov reporting.",
                    "id": "#main/destination"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "label": "Disable adapter trimming",
                    "doc": "Adapter trimming is enabled by default. If this option is specified, adapter trimming is disabled. Default false",
                    "id": "#main/disable_adapter_trimming"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "label": "End adapter",
                    "doc": "The adapter sequence at read end (3'). (Default auto-detect)",
                    "id": "#main/end_adapter"
                },
                {
                    "type": "boolean",
                    "doc": "Estimate true coverage and scale sequence abundance in `profile` by estimated unknown sequence percentage. Default false",
                    "label": "Estimate unknown",
                    "default": true,
                    "id": "#main/estimate_unknown"
                },
                {
                    "type": "boolean",
                    "doc": "Input fastq is generated by albacore, MinKNOW or guppy  with additional information concerning channel and time. \nUsed to creating more informative quality plots (Default false)\n",
                    "label": "Fastq rich (ONT)",
                    "default": false,
                    "id": "#main/fastq_rich_ont"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "A fasta file or minimap2 indexed filed (.mmi) index needs to be provided. Preindexed is much faster. (Default None)",
                    "label": "Filter human reads",
                    "loadListing": "no_listing",
                    "id": "#main/humandb"
                },
                {
                    "type": "string",
                    "doc": "Identifier for this dataset used in this workflow.",
                    "label": "identifier used",
                    "id": "#main/identifier"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "Maximum length limit",
                    "doc": "Reads longer than length_limit will be discarded. (Default no limit)",
                    "id": "#main/length_limit"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "doc": "Long reads sequence files (fastx/gzip)",
                    "label": "Long reads",
                    "id": "#main/longreads"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "Mean quality",
                    "doc": "If one read's mean_qual quality score < mean_qual, then this read is discarded. (Default 10)",
                    "default": 10,
                    "id": "#main/mean_qual"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "Minimum length required",
                    "doc": "Reads shorter will be discarded. (Default 100)",
                    "id": "#main/minimum_length"
                },
                {
                    "type": "boolean",
                    "label": "Output filtered reads",
                    "doc": "Output filtered reads when filtering is applied. (Default false)",
                    "default": false,
                    "id": "#main/output_filtered_reads"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "Poly_x_min_len",
                    "doc": "The minimum length to detect polyX in the read tail. (Default 10 when trim_poly_x is true)",
                    "id": "#main/poly_x_min_len"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 9,
                    "label": "Qualified_quality_phred",
                    "doc": "The quality value that a base is qualified. Default 9 means phred quality >=Q9 is qualified.",
                    "id": "#main/qualified_quality_phred"
                },
                {
                    "type": [
                        {
                            "type": "enum",
                            "symbols": [
                                "#main/readtype/nanopore",
                                "#main/readtype/pacbio"
                            ]
                        }
                    ],
                    "doc": "Type of read PacBio or Nanopore.",
                    "label": "Read type",
                    "id": "#main/readtype"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "A fasta file or minimap2 indexed filed (.mmi) index needs to be provided. Preindexed is much faster. (Default none)",
                    "label": "Filter reference file(s)",
                    "loadListing": "no_listing",
                    "id": "#main/reference_filter_db"
                },
                {
                    "type": "boolean",
                    "label": "Skip quality filtering",
                    "doc": "Skip quality reporting, filtering and contamination. (Default false)",
                    "default": false,
                    "id": "#main/skip_read_filter"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "label": "start_adapter",
                    "doc": "The adapter sequence at read start (5'). (Default auto-detect)",
                    "id": "#main/start_adapter"
                },
                {
                    "type": [
                        {
                            "type": "record",
                            "name": "#main/taxonomy_metadata/builtin_taxonomy_metadata",
                            "fields": [
                                {
                                    "type": [
                                        "null",
                                        {
                                            "type": "enum",
                                            "symbols": [
                                                "#main/taxonomy_metadata/builtin_taxonomy_metadata/builtin_taxonomy_metadata/GTDB_r214",
                                                "#main/taxonomy_metadata/builtin_taxonomy_metadata/builtin_taxonomy_metadata/GTDB_r220",
                                                "#main/taxonomy_metadata/builtin_taxonomy_metadata/builtin_taxonomy_metadata/GTDB_r226",
                                                "#main/taxonomy_metadata/builtin_taxonomy_metadata/builtin_taxonomy_metadata/IMGVR_4.1",
                                                "#main/taxonomy_metadata/builtin_taxonomy_metadata/builtin_taxonomy_metadata/SoilSMAG",
                                                "#main/taxonomy_metadata/builtin_taxonomy_metadata/builtin_taxonomy_metadata/OceanDNA",
                                                "#main/taxonomy_metadata/builtin_taxonomy_metadata/builtin_taxonomy_metadata/TaraEukaryoticSMAG",
                                                "#main/taxonomy_metadata/builtin_taxonomy_metadata/builtin_taxonomy_metadata/FungiRefSeq-2024-07-25"
                                            ]
                                        }
                                    ],
                                    "doc": "Provided taxonomy metadata from default sylph databases. (only available when running with the container image)",
                                    "label": "Taxonomy metadata",
                                    "name": "#main/taxonomy_metadata/builtin_taxonomy_metadata/builtin_taxonomy_metadata"
                                }
                            ]
                        },
                        {
                            "type": "record",
                            "name": "#main/taxonomy_metadata/taxonomy_metadata_file",
                            "fields": [
                                {
                                    "type": "File",
                                    "doc": "Taxonomy metadata file(s) that are not incorporated in the docker image.",
                                    "label": "Taxonomy metadata file",
                                    "name": "#main/taxonomy_metadata/taxonomy_metadata_file/taxonomy_metadata_file"
                                }
                            ]
                        }
                    ],
                    "id": "#main/taxonomy_metadata"
                },
                {
                    "type": "int",
                    "doc": "Maximum threads to use. (Default 3)",
                    "label": "Threads",
                    "default": 3,
                    "id": "#main/threads"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "Trim_front",
                    "doc": "Trimming how many bases in front for read. (Default 0)",
                    "id": "#main/trim_front"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "label": "Trim_poly_x",
                    "doc": "Enable polyX trimming in 3' ends. (Default false)",
                    "id": "#main/trim_poly_x"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "trim_tail",
                    "doc": "Trimming how many bases in tail for read, Default 0)",
                    "id": "#main/trim_tail"
                },
                {
                    "type": "boolean",
                    "doc": "Use mapped reads mapped to the custom reference db. (Default false, discard mapped)",
                    "label": "Use mapped reads",
                    "default": false,
                    "id": "#main/use_reference_mapped_reads"
                }
            ],
            "steps": [
                {
                    "label": "Output reads",
                    "doc": "Step needed to output filtered reads.",
                    "when": "$(!inputs.skip_read_filter && inputs.output_filtered_reads)",
                    "run": {
                        "class": "ExpressionTool",
                        "requirements": [
                            {
                                "class": "InlineJavascriptRequirement"
                            }
                        ],
                        "inputs": [
                            {
                                "type": [
                                    "null",
                                    "File"
                                ],
                                "id": "#main/step_output_filtered_reads/run/reads_in"
                            }
                        ],
                        "outputs": [
                            {
                                "type": "File",
                                "id": "#main/step_output_filtered_reads/run/reads_out"
                            }
                        ],
                        "expression": "${ return {'reads_out': inputs.reads_in}; }\n"
                    },
                    "in": [
                        {
                            "source": "#main/output_filtered_reads",
                            "id": "#main/step_output_filtered_reads/output_filtered_reads"
                        },
                        {
                            "source": "#main/workflow_longread_quality/filtered_reads",
                            "id": "#main/step_output_filtered_reads/reads_in"
                        },
                        {
                            "source": "#main/skip_read_filter",
                            "id": "#main/step_output_filtered_reads/skip_read_filter"
                        }
                    ],
                    "out": [
                        "#main/step_output_filtered_reads/reads_out"
                    ],
                    "id": "#main/step_output_filtered_reads"
                },
                {
                    "run": "#sylph_profile.cwl",
                    "in": [
                        {
                            "source": "#main/database",
                            "id": "#main/sylph_profile_run/database"
                        },
                        {
                            "source": "#main/estimate_unknown",
                            "id": "#main/sylph_profile_run/estimate_unknown"
                        },
                        {
                            "source": "#main/identifier",
                            "id": "#main/sylph_profile_run/output_filename_prefix"
                        },
                        {
                            "source": [
                                "#main/workflow_longread_quality/filtered_reads",
                                "#main/workflow_merge_reads/merged_reads"
                            ],
                            "pickValue": "first_non_null",
                            "id": "#main/sylph_profile_run/single_end_reads"
                        },
                        {
                            "source": "#main/threads",
                            "id": "#main/sylph_profile_run/threads"
                        }
                    ],
                    "out": [
                        "#main/sylph_profile_run/sylph_profile"
                    ],
                    "id": "#main/sylph_profile_run"
                },
                {
                    "run": "#sylph_tax.cwl",
                    "in": [
                        {
                            "source": "#main/annotate_virus_hosts",
                            "id": "#main/sylph_tax/annotate_virus_hosts"
                        },
                        {
                            "source": "#main/identifier",
                            "id": "#main/sylph_tax/output_filename_prefix"
                        },
                        {
                            "source": "#main/sylph_profile_run/sylph_profile",
                            "id": "#main/sylph_tax/sylph_profile"
                        },
                        {
                            "source": "#main/taxonomy_metadata",
                            "id": "#main/sylph_tax/taxonomy_metadata"
                        }
                    ],
                    "out": [
                        "#main/sylph_tax/sylph_tax"
                    ],
                    "id": "#main/sylph_tax"
                },
                {
                    "label": "Oxford Nanopore quality workflow",
                    "doc": "Quality, filtering and taxonomic classification workflow for Oxford Nanopore reads",
                    "when": "$(!inputs.skip_read_filter)",
                    "run": "#workflow_longread_quality.cwl",
                    "in": [
                        {
                            "source": "#main/adapter_fasta",
                            "id": "#main/workflow_longread_quality/adapter_fasta"
                        },
                        {
                            "source": "#main/cut_front",
                            "id": "#main/workflow_longread_quality/cut_front"
                        },
                        {
                            "source": "#main/cut_mean_quality",
                            "id": "#main/workflow_longread_quality/cut_mean_quality"
                        },
                        {
                            "source": "#main/cut_tail",
                            "id": "#main/workflow_longread_quality/cut_tail"
                        },
                        {
                            "source": "#main/cut_window_size",
                            "id": "#main/workflow_longread_quality/cut_window_size"
                        },
                        {
                            "source": "#main/disable_adapter_trimming",
                            "id": "#main/workflow_longread_quality/disable_adapter_trimming"
                        },
                        {
                            "source": "#main/end_adapter",
                            "id": "#main/workflow_longread_quality/end_adapter"
                        },
                        {
                            "source": "#main/fastq_rich_ont",
                            "id": "#main/workflow_longread_quality/fastq_rich"
                        },
                        {
                            "source": "#main/humandb",
                            "id": "#main/workflow_longread_quality/humandb"
                        },
                        {
                            "source": "#main/identifier",
                            "id": "#main/workflow_longread_quality/identifier"
                        },
                        {
                            "source": "#main/use_reference_mapped_reads",
                            "id": "#main/workflow_longread_quality/keep_reference_mapped_reads"
                        },
                        {
                            "source": "#main/length_limit",
                            "id": "#main/workflow_longread_quality/length_limit"
                        },
                        {
                            "source": "#main/longreads",
                            "id": "#main/workflow_longread_quality/longreads"
                        },
                        {
                            "source": "#main/mean_qual",
                            "id": "#main/workflow_longread_quality/mean_qual"
                        },
                        {
                            "source": "#main/minimum_length",
                            "id": "#main/workflow_longread_quality/minimum_length"
                        },
                        {
                            "source": "#main/poly_x_min_len",
                            "id": "#main/workflow_longread_quality/poly_x_min_len"
                        },
                        {
                            "source": "#main/qualified_quality_phred",
                            "id": "#main/workflow_longread_quality/qualified_quality_phred"
                        },
                        {
                            "source": "#main/readtype",
                            "id": "#main/workflow_longread_quality/readtype"
                        },
                        {
                            "source": "#main/reference_filter_db",
                            "id": "#main/workflow_longread_quality/reference_filter_db"
                        },
                        {
                            "source": "#main/skip_read_filter",
                            "id": "#main/workflow_longread_quality/skip_read_filter"
                        },
                        {
                            "source": "#main/start_adapter",
                            "id": "#main/workflow_longread_quality/start_adapter"
                        },
                        {
                            "source": "#main/threads",
                            "id": "#main/workflow_longread_quality/threads"
                        },
                        {
                            "source": "#main/trim_front",
                            "id": "#main/workflow_longread_quality/trim_front"
                        },
                        {
                            "source": "#main/trim_poly_x",
                            "id": "#main/workflow_longread_quality/trim_poly_x"
                        },
                        {
                            "source": "#main/trim_tail",
                            "id": "#main/workflow_longread_quality/trim_tail"
                        }
                    ],
                    "out": [
                        "#main/workflow_longread_quality/filtered_reads",
                        "#main/workflow_longread_quality/reports_folder"
                    ],
                    "id": "#main/workflow_longread_quality"
                },
                {
                    "label": "Merge paired reads",
                    "doc": "Creates a single file object. Also merges reads if multiple files are given.",
                    "when": "$(inputs.skip_read_filter)",
                    "run": "#workflow_merge_se_reads.cwl",
                    "in": [
                        {
                            "source": "#main/identifier",
                            "valueFrom": "$(self)_merged",
                            "id": "#main/workflow_merge_reads/filename"
                        },
                        {
                            "source": "#main/longreads",
                            "id": "#main/workflow_merge_reads/reads"
                        },
                        {
                            "source": "#main/skip_read_filter",
                            "id": "#main/workflow_merge_reads/skip_read_filter"
                        }
                    ],
                    "out": [
                        "#main/workflow_merge_reads/merged_reads"
                    ],
                    "id": "#main/workflow_merge_reads"
                }
            ],
            "id": "#main",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateModified": "2025-08-22",
            "https://schema.org/dateCreated": "2025-02-26",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        }
    ],
    "cwlVersion": "v1.2",
    "$namespaces": {
        "s": "https://schema.org/"
    }
}
