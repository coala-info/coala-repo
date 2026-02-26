# cleaverna CWL Generation Report

## cleaverna

### Tool Description
Advanced machine learning-based computational tool for scoring candidate DNAzyme cleavage sites in substrate RNA sequences using structural and thermodynamic features.

### Metadata
- **Docker Image**: quay.io/biocontainers/cleaverna:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/reyhaneh-tavakoli/CleaveRNA
- **Package**: https://anaconda.org/channels/bioconda/packages/cleaverna/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cleaverna/overview
- **Total Downloads**: 41
- **Last updated**: 2025-12-05
- **GitHub**: https://github.com/reyhaneh-tavakoli/CleaveRNA
- **Stars**: N/A
### Original Help Text
```text
============================================================
🧬 CleaveRNA Analysis Tool 🧬
============================================================
usage: CleaveRNA [-h] --model_name NAME
                 [--target_files_prediction FASTA [FASTA ...]]
                 [--target_files_training FASTA [FASTA ...]] [--params CSV]
                 [--training_file CSV] [--training_scores CSV]
                 [--specific_query_input CSV] [--prediction_mode MODE]
                 [--output_dir DIR]

┌─────────────────────────────────────────────────────────────────────────────┐
│                        🧬 CleaveRNA Analysis Tool 🧬                        │
│                                                                             │
│  Advanced machine learning-based computational tool for scoring candidate   │
│  DNAzyme cleavage sites in substrate RNA sequences using structural and     │
│  thermodynamic features.                                                    │
│                                                                             │
│  Features:                                                                  │
│  • Machine Learning Prediction Models                                       │
│  • RNA Secondary Structure Analysis                                         │
│  • Thermodynamic Feature Extraction                                         │
│  • Multiple Prediction Modes                                                │
│  • Cross-validation and Performance Metrics                                 │
└─────────────────────────────────────────────────────────────────────────────┘
            

options:
  -h, --help            Show this help message and exit

🔴 REQUIRED ARGUMENTS:
  --model_name NAME     Model identifier and output file prefix (e.g.,
                        "my_experiment")

📁 INPUT FILES:
  --target_files_prediction FASTA [FASTA ...]
                        Target RNA sequence files in FASTA format (required
                        for prediction mode)
  --target_files_training FASTA [FASTA ...]
                        Training RNA sequence files in FASTA format (required
                        for training mode)
  --params CSV          Parameters file with columns: LA, RA, CS, Tem, CA
  --training_file CSV   Training data feature matrix (mutually exclusive with
                        --target_files_training)
  --training_scores CSV
                        Training target labels/scores (required with
                        --training_file)
  --specific_query_input CSV
                        Custom query parameters for specific_query mode

🔬 ANALYSIS OPTIONS:
  --prediction_mode MODE
                        Analysis mode selection: • default : Standard cleavage
                        site prediction • target_screen : Screen custom
                        cleavage sites • target_check : Validate sites in
                        specific regions • specific_query : Analyze custom
                        DNAzyme sequences

📤 OUTPUT OPTIONS:
  --output_dir DIR      Output directory for results (default: current
                        directory)

┌─────────────────────────────────────────────────────────────────────────────┐
│                              📋 USAGE EXAMPLES                              │
└─────────────────────────────────────────────────────────────────────────────┘

🎯 TRAINING MODE - Generate features for model training:
┌─────────────────────────────────────────────────────────────────────────────┐
│ cleaverna --target_files_training train1.fasta train2.fasta \              │
│           --params parameters.csv --prediction_mode default \              │
│           --model_name my_model --output_dir results/                       │
└─────────────────────────────────────────────────────────────────────────────┘

🔮 PREDICTION MODE - Standard cleavage site prediction:
┌─────────────────────────────────────────────────────────────────────────────┐
│ cleaverna --target_files_prediction seq1.fasta seq2.fasta \                │
│           --params parameters.csv --prediction_mode default \              │
│           --training_file training_data.csv \                              │
│           --training_scores labels.csv \                                   │
│           --model_name prediction_model --output_dir results/               │
└─────────────────────────────────────────────────────────────────────────────┘

🎯 TARGET SCREENING - Screen specific cleavage sites:
┌─────────────────────────────────────────────────────────────────────────────┐
│ cleaverna --target_files_prediction target.fasta \                         │
│           --params screen_params.csv --prediction_mode target_screen \     │
│           --training_file training_data.csv \                              │
│           --training_scores labels.csv \                                   │
│           --model_name screen_model --output_dir screening_results/         │
└─────────────────────────────────────────────────────────────────────────────┘

🔍 TARGET CHECK - Validate cleavage sites in specific regions:
┌─────────────────────────────────────────────────────────────────────────────┐
│ cleaverna --target_files_prediction target.fasta \                         │
│           --params check_params.csv --prediction_mode target_check \       │
│           --training_file training_data.csv \                              │
│           --training_scores labels.csv \                                   │
│           --model_name check_model --output_dir check_results/              │
└─────────────────────────────────────────────────────────────────────────────┘

⚡ SPECIFIC QUERY - Custom DNAzyme sequence analysis:
┌─────────────────────────────────────────────────────────────────────────────┐
│ cleaverna --target_files_prediction target.fasta \                         │
│           --params query_params.csv --prediction_mode specific_query \     │
│           --specific_query_input custom_queries.csv \                      │
│           --training_file training_data.csv \                              │
│           --training_scores labels.csv \                                   │
│           --model_name query_model --output_dir query_results/              │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                            🔗 MORE INFORMATION                              │
└─────────────────────────────────────────────────────────────────────────────┘

📚 Documentation: https://github.com/reyhaneh-tavakoli/CleaveRNA
💡 Issues & Support: https://github.com/reyhaneh-tavakoli/CleaveRNA/issues
```

