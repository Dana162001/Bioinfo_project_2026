#!/usr/local_rwth/bin/zsh

#SBATCH --mem=120G
#SBATCH --cpus-per-task=16
#SBATCH --time=12:00:00
#SBATCH --signal=2
#SBATCH --nodes=1
#SBATCH --export=ALL
#SBATCH --no-requeue
#SBATCH --partition=c23ms
#SBATCH --account=p0020567
#SBATCH --job-name=5_gene_counts
#SBATCH --output=logs/5_gene_counts-%j.out
#SBATCH --error=logs/5_gene_counts-%j.err

echo "Starting job"
date

# Activate conda
export CONDA_ROOT=$HOME/miniconda3
. $CONDA_ROOT/etc/profile.d/conda.sh
export PATH="$CONDA_ROOT/bin:$PATH"

# Activate environment containing fastp
conda activate ahi_workshop

# Create output directory
mkdir -p 5_counts


# Paired-End Samples (Quizartinib)

echo "Counting paired-end samples"

featureCounts \
-T 16 \
-p \
-t exon \
-g gene_id \
-a reference/gencode.v49.annotation.gtf \
-o 5_counts/quizartinib_counts.txt \
4_alignment/Quizartinib*_Aligned.sortedByCoord.out.bam

# Single-End Samples (Untreated)

echo "Counting single-end samples"

featureCounts \
-T 16 \
-t exon \
-g gene_id \
-a reference/gencode.v49.annotation.gtf \
-o 5_counts/untreated_counts.txt \
4_alignment/Untreated*_Aligned.sortedByCoord.out.bam


# Create combined count matrix

echo "Merging count matrices"

tail -n +3 5_counts/quizartinib_counts.txt > 5_counts/quizartinib_clean.txt
tail -n +3 5_counts/untreated_counts.txt > 5_counts/untreated_clean.txt

cut -f1,7- 5_counts/quizartinib_clean.txt > 5_counts/quizartinib_matrix.txt
cut -f7- 5_counts/untreated_clean.txt > 5_counts/untreated_matrix.txt

paste \
5_counts/quizartinib_matrix.txt \
5_counts/untreated_matrix.txt \
> 5_counts/final_count_matrix.txt

echo "Gene counting finished"
date