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
#SBATCH --job-name=fastp_trim
#SBATCH --output=logs/2_fastp_trim-%j.out
#SBATCH --error=logs/2_fastp_trim-%j.err

echo "Starting adapter trimming job"
date

# Activate conda
export CONDA_ROOT=$HOME/miniconda3
. $CONDA_ROOT/etc/profile.d/conda.sh
export PATH="$CONDA_ROOT/bin:$PATH"

# Activate environment containing fastp
conda activate ahi_workshop

# Create output directories
mkdir -p trimmed_fastq
mkdir -p trimmed_fastq/reports


# Paired-end samples (Quizartinib)


for sample in Quizartinib1_48h Quizartinib2_48h Quizartinib3_48h
do
    echo "Processing $sample"

    fastp \
        -i data/${sample}_1.fastq.gz \
        -I data/${sample}_2.fastq.gz \
        -o trimmed_fastq/${sample}_1.trimmed.fastq.gz \
        -O trimmed_fastq/${sample}_2.trimmed.fastq.gz \
        --detect_adapter_for_pe \
        --cut_front \
        --cut_tail \
        --cut_mean_quality 30 \
        --thread 16 \
        --html trimmed_fastq/reports/${sample}.html \
        --json trimmed_fastq/reports/${sample}.json
done


# Single-end samples (Untreated)


for sample in Untreated1_1 Untreated2_1
do
    echo "Processing $sample"

    fastp \
        -i data/${sample}.fastq.gz \
        -o trimmed_fastq/${sample}.trimmed.fastq.gz \
        --cut_front \
        --cut_tail \
        --cut_mean_quality 30 \
        --thread 16 \
        --html trimmed_fastq/reports/${sample}.html \
        --json trimmed_fastq/reports/${sample}.json
done

echo "Adapter trimming finished"
date