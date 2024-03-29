#!/bin/bash
#SBATCH --job-name=24h-affect-sub-lag-adj-1
#SBATCH --time=1-00:00:00
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=20GB
#SBATCH --cpus-per-task=5
#SBATCH --partition=comp

cd /fs04/ft29/multilevelcoda-24h-affect

module load R/4.2.2-mkl

Rscript 24h-affect-sub-lag-adj-1.R

echo 'Completed by' $USER