#!/bin/bash -l
#SBATCH -J pcaDBind
#SBATCH --mem=40G
#SBATCH --time=24:00:00
#SBATCH -N 1
#SBATCH -c 8

module load anaconda3/cpu/5.3.1
module purge
conda activate r_env

Rscript pca_diffBind.R
