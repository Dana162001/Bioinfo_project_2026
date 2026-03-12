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
#SBATCH --job-name=4_alignment
#SBATCH --output=logs/4_alignment-%j.out
#SBATCH --error=logs/4_alignment-%j.err

echo "Starting job"
date

# Activate conda
export CONDA_ROOT=$HOME/miniconda3
. $CONDA_ROOT/etc/profile.d/conda.sh
export PATH="$CONDA_ROOT/bin:$PATH"

# Activate environment containing fastp
conda activate ahi_workshop

# Create output directories
mkdir 4_alignment




for sample in Quizartinib1_48h Quizartinib2_48h Quizartinib3_48h
do
    STAR \
        --runThreadN 8 \
        --genomeDir 3_star_index \
        --readFilesIn 2_trimmed_fastq/${sample}_1.trimmed.fastq.gz \
                      2_trimmed_fastq/${sample}_2.trimmed.fastq.gz \
        --readFilesCommand zcat \
        --outFileNamePrefix 4_alignment/${sample}_ \
        --outSAMtype BAM SortedByCoordinate
done


for sample in Untreated1_1 Untreated2_1
do
    STAR \
        --runThreadN 8 \
        --genomeDir 3_star_index \
        --readFilesIn 2_trimmed_fastq/${sample}.trimmed.fastq.gz \
        --readFilesCommand zcat \
        --outFileNamePrefix 4_alignment/${sample}_ \
        --outSAMtype BAM SortedByCoordinate
done

echo "Splice-Aware Alignment finished"
date