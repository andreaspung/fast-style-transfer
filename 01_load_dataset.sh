#!/bin/bash

#The name of the job is test_job
#SBATCH -J load_dataset

#The job requires 1 compute node
#SBATCH -N 1

#The job requires 1 task per node
#SBATCH --ntasks-per-node=1

#The maximum walltime of the job is 10 hours
#SBATCH -t 10:00:00

#SBATCH --mem=8G

#Commands to execute go below

#Load Python
module load python/3.6.3/CUDA

#Download the dataset
sh setup.sh