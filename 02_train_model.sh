#!/bin/bash

#The name of the job is fast-style-transfer
#SBATCH -J fast-style-transfer

#The job requires 1 compute node
#SBATCH -N 1

#The job requires 1 task per node
#SBATCH --ntasks-per-node=1

#The maximum walltime of the job is 24 hours
#SBATCH -t 24:00:00

#SBATCH --mem=16G

#If you keep the next two lines, you will get an e-mail notification
#whenever something happens to your job (it starts running, completes or fails)
#SBATCH --mail-type=ALL
#SBATCH --mail-user=

#Keep this line if you need a GPU for your job
#SBATCH --partition=gpu

#Indicates that you need one GPU node
#SBATCH --gres=gpu:tesla:1

#Commands to execute go below

#Load Python
module load python/3.6.3/virtenv

#Activate your environment
source activate tf2-gpu

IMPATH="c53a9eb7f98bd9efe52407712806bfee_XL.jpg"

mkdir ./checkpoints/$IMPATH/
mkdir ./checkpoint-images/$IMPATH/

echo "Starting training."
python style.py --style ./MagicMirror2.0-Trinity/$IMPATH \
  --checkpoint-dir ./checkpoints/$IMPATH/ \
  --test ./MagicMirror2.0-Trinity/test_image.jpg \
  --test-dir ./checkpoint-images/$IMPATH/ \
  --checkpoint-iterations 2000 \
  --batch-size 4
echo "Training finished."
