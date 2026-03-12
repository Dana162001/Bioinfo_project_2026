## RNA-seq Analysis of AML Cells Treated with Quizartinib
Bioinformatics Project 2026 AHI.

### Overview

This project contains a complete RNA-seq analysis pipeline to identify differentially expressed genes (DEGs) in acute myeloid leukemia (AML) cells treated with Quizartinib for 48 hours compared to untreated controls. Quizartinib is a selective inhibitor of the FLT3 receptor tyrosine kinase, a driver mutation in many AML cases.

The analysis starts from raw sequencing reads (FASTQ) and proceeds through quality control, read trimming, genome alignment, gene quantification, and differential expression analysis.

The goal of the project is to characterize transcriptional changes induced by FLT3 inhibition and identify genes and pathways affected by Quizartinib treatment.

### Workflow Summary

The analysis follows a standard RNA-seq pipeline:

1. Quality Control
Raw sequencing reads are assessed for quality and sequencing artifacts using FastQC.

2. Adapter Trimming
Adapter sequences and low-quality bases are removed using fastp.

3. STAR Genome Index building

4. Genome Alignment
Trimmed reads are aligned to the human reference genome using the splice-aware aligner STAR.

5. Gene Quantification
Aligned reads are assigned to genes using featureCounts, generating a gene-level count matrix.

6. Differential Expression Analysis
Gene counts are analyzed using PyDESeq2, the Python implementation of the DESeq2 statistical framework, to identify genes significantly up- or down-regulated after treatment.

#### Visualization: Results are visualized using:
* Volcano plots highlighting significant genes
* Heatmaps of the differentially expressed genes

### Directory Structure
#### Note: not all output folders are saved to the GitHub repository due to the large size

```
├── 1_fastqc_raw
│   
├── 2_trimmed_fastq
│   
├── 3_star_index
│   
├── 4_alignment
│   
├── 5_counts
│   
├── 6_PyDESeq2
│  
├── logs
│ 
├── data
│ 
├── reference 
│ 
├── 2_trim_fastp.sh
├── 3_star_index.sh
├── 4_alignment.sh
├── 4.1_alignment_QC.sh
├── 5_gene_level_counting.sh
├── env.yml
├── README.md
└── .gitignore
```

### Reproducibility
#### Local
1. Set up [conda](https://docs.conda.io/projects/conda/en/latest/user-guide/install/index.html) environment
Conda environment file is provided to fully reproduce the setup used in this project.

Create the environment using:
```
conda env create -f env.yml
```

2. Activate the environment:
```
conda activate ahi_workshop
```
3. Run Quality Control in terminal
```
for file in *.fastq.gz
do
    fastqc $file -o 1_fastqc_raw
done
```
run multiQC summary:
```
multiqc 1_fastqc_raw -o 1_fastqc_raw
```
4. Next run the shell scripts in order: 2_trim_fastp.sh → 5_gene_level_counting.sh


### Tools Used

Key tools and libraries used in this project:

FastQC — sequencing quality control

fastp — adapter trimming and quality filtering

STAR — splice-aware RNA-seq alignment

featureCounts — gene-level read quantification

PyDESeq2 — differential expression analysis

Python (pandas, seaborn, matplotlib) — data analysis and visualization

### Key Outputs

* Gene count matrix
* Differential expression results
* Volcano plot of significant genes
* vHeatmap of top differentially expressed genes

### Author

Daryna Pikulska 

AHI RWTH Bioinformatics 2026