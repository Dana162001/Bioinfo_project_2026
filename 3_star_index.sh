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
#SBATCH --job-name=3_star_index
#SBATCH --output=logs/3_star_index-%j.out
#SBATCH --error=logs/3_star_index-%j.err

echo "Starting job"
date

# Activate conda
export CONDA_ROOT=$HOME/miniconda3
. $CONDA_ROOT/etc/profile.d/conda.sh
export PATH="$CONDA_ROOT/bin:$PATH"

# Activate environment containing fastp
conda activate ahi_workshop

# Create output directories
mkdir -p 3_star_index

STAR \
    --runThreadN 8 \
    --runMode genomeGenerate \
    --genomeDir 3_star_index \
    --genomeFastaFiles reference/GRCh38.primary_assembly.genome.fa \
    --sjdbGTFfile reference/gencode.v49.annotation.gtf \
    --sjdbOverhang 100