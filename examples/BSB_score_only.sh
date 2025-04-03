#!/bin/bash
#SBATCH -p gpu
#SBATCH --mem=32g
#SBATCH --gres=gpu:rtx2080:1
#SBATCH -c 3
#SBATCH --output=example_3_from_fasta.out

path_to_PDB="/Users/scala/funclib_datasets/Repsol1_BSB/full_run_inputs/1IZO_A_w_ligs_ref_2.pdb"
path_to_fasta="/Users/pilyam/GitHub/ProteinMPNN/inputs/BSB_score_only/1IZO_1000_seqs.fa"

output_dir="/Users/pilyam/GitHub/ProteinMPNN/outputs/BSB_score_only_48_020_soluble/"
if [ ! -d $output_dir ]
then
    mkdir -p $output_dir
fi

chains_to_design="A"

python ../protein_mpnn_run.py \
        --path_to_fasta $path_to_fasta \
        --pdb_path $path_to_PDB \
        --model_name "v_48_020" \
        --use_soluble_model \
        --pdb_path_chains "$chains_to_design" \
        --out_folder $output_dir \
        --num_seq_per_target 1 \
        --sampling_temp "0.1" \
        --seed 13 \
        --batch_size 1
#        --save_probs 1 \
