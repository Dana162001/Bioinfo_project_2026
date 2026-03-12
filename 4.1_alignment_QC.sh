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
#SBATCH --job-name=4.1_alignmentQC
#SBATCH --output=logs/4.1_alignmentQC-%j.out
#SBATCH --error=logs/4.1_alignmentQC-%j.err

echo "Starting job"
date

# Activate conda
export CONDA_ROOT=$HOME/miniconda3
. $CONDA_ROOT/etc/profile.d/conda.sh
export PATH="$CONDA_ROOT/bin:$PATH"

# Activate environment containing fastp
conda activate ahi_workshop

for bam in 4_alignment/*Aligned.sortedByCoord.out.bam
do
    samtools flagstat $bam > ${bam%.bam}.flagstat.txt
done

echo "Splice-Aware Alignment QC finished"
date