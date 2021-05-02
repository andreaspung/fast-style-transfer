#!/bin/bash

#The name of the job is fast-style-transfer
#SBATCH -J fast-style-transfer

#The job requires 1 compute node
#SBATCH -N 1

#The job requires 1 task per node
#SBATCH --ntasks-per-node=1

#The maximum walltime of the job is 5 minutes
#SBATCH -t 20:00:00

#SBATCH --mem=8G

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
#module load python/3.8.6
module load tensorflow2/py3.cuda10.0
#module load broadwell/cudnn/7.6.3/cuda-10.1

#Activate your environment
#source /gpfs/space/home/citius/anaconda3/etc/profile.d/conda.sh
#conda activate tf-gpu

#pip install --user --upgrade tensorflow-gpu==2.1.0
pip install --user imageio
pip install --user moviepy
pip install --user imageio-ffmpeg

conda list
module list

echo "Starting training."
python style.py --style ./MagicMirror2.0-Trinity/OTSING.jpg \
  --checkpoint-dir ./checkpoints/ \
  --test ./MagicMirror2.0-Trinity/896.jpg \
  --test-dir ./checkpoint-images/ \
  --content-weight 1.5e1 \
  --checkpoint-iterations 1000 \
  --batch-size 20